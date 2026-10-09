"""
Export the reporting marts the dashboard reads into dashboard/data.json.

Run after `dbt build`:  python dashboard/export_data.py
"""
from __future__ import annotations

import json
from datetime import date, datetime
from pathlib import Path

import duckdb

ROOT = Path(__file__).resolve().parents[1]
DB = ROOT / "warehouse" / "throughline.duckdb"
OUT = ROOT / "dashboard" / "data.json"


def clean(v):
    if isinstance(v, (date, datetime)):
        return v.isoformat()[:7]
    if isinstance(v, float):
        return round(v, 6)
    if hasattr(v, "as_tuple"):
        return round(float(v), 6)
    return v


def rows(con, sql):
    cur = con.execute(sql)
    cols = [d[0] for d in cur.description]
    return {"columns": cols, "rows": [[clean(v) for v in r] for r in cur.fetchall()]}


def main() -> None:
    con = duckdb.connect(str(DB), read_only=True)
    one = lambda sql: con.execute(sql).fetchone()[0]
    payload = {
        "generated": date.today().isoformat(),
        "kpi_catalog": rows(con, "select kpi_id, kpi_name, category, definition, unit, direction, target_type, target_value from reference.kpi_definitions order by sort_order"),
        "kpis": rows(con, "select month_start, kpi_id, value, prior_month_value, prior_year_value, target, status from reporting.rpt_kpi_monthly order by month_start, kpi_id"),
        "categories": rows(con, "select month_start, category, gmv, orders, avg_review_score, on_time_rate from reporting.rpt_category_monthly order by 1, 3 desc"),
        "states": rows(con, "select month_start, state, gmv, orders, avg_delivery_days, on_time_rate, avg_review_score from reporting.rpt_state_monthly order by 1, 3 desc"),
        "delivery": rows(con, "select delivery_bucket, orders, share_of_orders, avg_review_score, one_star_rate, five_star_rate from reporting.rpt_delivery_experience order by 1"),
        "cohorts": rows(con, "select cohort_month, months_since_first, cohort_size, retention_rate from reporting.rpt_cohort_retention where months_since_first between 1 and 12 order by 1, 2"),
        "quality": {
            "raw_orders": one("select count(*) from raw_olist.orders"),
            "customer_ids": one("select count(distinct customer_id) from staging.stg_olist__customers"),
            "people": one("select count(*) from core.dim_customers"),
            "repeat_people": one("select count(*) from core.dim_customers where valid_orders > 1"),
            "orders_with_multiple_reviews": one("select count(*) from (select order_id from staging.stg_olist__order_reviews group by 1 having count(*) > 1)"),
            "untranslated_or_blank_category_products": one("select count(*) from core.dim_products where missing_translation or category_pt is null"),
            "orders_excluded_partial_months": one("select count(*) from core.fct_orders where order_month < date '2017-01-01' or order_month > date '2018-08-01'"),
            "lost_orders": one("select count(*) from core.fct_orders where not is_valid_sale"),
            "delivered_missing_date": one("select count(*) from core.fct_orders where order_status = 'delivered' and delivered_at is null"),
            "orders_without_items": one("select count(*) from core.fct_orders where item_count = 0"),
            "in_transit_by_month": {r[0]: r[1] for r in con.execute("""select strftime(order_month, '%Y-%m'), count(*) from core.fct_orders
                where is_valid_sale and delivered_at is null and order_status not in ('delivered', 'canceled', 'unavailable')
                  and order_month between date '2017-01-01' and date '2018-08-01' group by 1""").fetchall()},
            "installment_interest": one("select round(sum(payment_gap)) from core.fct_orders where is_valid_sale and not used_voucher and payment_gap > 0"),
        },
    }
    OUT.write_text(json.dumps(payload, separators=(",", ":")))
    print(f"Wrote {OUT.relative_to(ROOT)} ({OUT.stat().st_size / 1024:.0f} KB)")


if __name__ == "__main__":
    main()
