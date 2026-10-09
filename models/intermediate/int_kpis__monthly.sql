-- Every KPI for every month, wide. Definitions live in seeds/kpi_definitions.csv;
-- this is the one place they're computed, so no chart can drift from another.
with orders as (
    select o.*, c.cohort_month
    from {{ ref('fct_orders') }} as o
    join {{ ref('dim_customers') }} as c using (customer_unique_id)
),

valid as (
    select
        order_month,
        sum(order_value)                                          as gmv,
        count(*)                                                  as orders,
        count(distinct customer_unique_id)                        as active_customers,
        count(distinct case when cohort_month < order_month then customer_unique_id end) as returning_customers,
        sum(freight_value)                                        as freight
    from orders
    where is_valid_sale
    group by 1
),

all_orders as (
    select
        order_month,
        count(*)                                                                    as all_orders,
        sum(case when not is_valid_sale then 1 else 0 end)                          as lost_orders,
        avg(case when is_delivered then case when delivered_on_time then 1.0 else 0.0 end end) as on_time_rate,
        avg(case when is_delivered then days_to_deliver end)                        as avg_delivery_days,
        avg(review_score)                                                           as avg_review_score
    from orders
    group by 1
),

sellers as (
    select order_month, count(distinct seller_id) as active_sellers
    from {{ ref('fct_order_items') }}
    where is_valid_sale
    group by 1
)

select
    v.order_month                                   as month_start,
    v.gmv,
    v.orders,
    v.gmv / v.orders                                as aov,
    v.active_customers,
    v.returning_customers * 1.0 / v.active_customers as repeat_customer_rate,
    a.on_time_rate,
    a.avg_delivery_days,
    a.lost_orders * 1.0 / a.all_orders              as cancel_rate,
    a.avg_review_score,
    v.freight / v.gmv                               as freight_ratio,
    s.active_sellers
from valid as v
join all_orders as a using (order_month)
join sellers as s using (order_month)
