-- Scorecard GMV must equal order-level GMV, and order-level product value must equal the sum of items.
with scorecard as (
    select sum(value) as gmv from {{ ref('rpt_kpi_monthly') }} where kpi_id = 'gmv'
),
orders as (
    select sum(order_value) as gmv from {{ ref('fct_orders') }}
    where is_valid_sale
      and order_month between cast('{{ var("report_start") }}' as date) and cast('{{ var("report_end") }}' as date)
),
items as (
    select (select sum(item_price) from {{ ref('fct_order_items') }}) as item_total,
           (select sum(product_value) from {{ ref('fct_orders') }}) as order_total
)
select s.gmv as scorecard_gmv, o.gmv as order_gmv, i.item_total, i.order_total
from scorecard as s cross join orders as o cross join items as i
where abs(s.gmv - o.gmv) > 0.01 or abs(i.item_total - i.order_total) > 0.01
