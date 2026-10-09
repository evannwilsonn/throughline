-- Customer state performance per month (27 Brazilian states).
select
    order_month                                      as month_start,
    customer_state                                   as state,
    sum(case when is_valid_sale then order_value else 0 end)  as gmv,
    sum(case when is_valid_sale then 1 else 0 end)            as orders,
    avg(case when is_delivered then days_to_deliver end)      as avg_delivery_days,
    avg(case when is_delivered then case when delivered_on_time then 1.0 else 0.0 end end) as on_time_rate,
    avg(review_score)                                         as avg_review_score
from {{ ref('fct_orders') }}
where order_month between cast('{{ var("report_start") }}' as date) and cast('{{ var("report_end") }}' as date)
group by 1, 2
