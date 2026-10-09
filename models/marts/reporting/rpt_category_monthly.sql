-- Category performance per month. GMV here is item price plus that item's freight.
select
    order_month                                       as month_start,
    category,
    sum(item_price + freight_value)                   as gmv,
    count(distinct order_id)                          as orders,
    count(*)                                          as items,
    avg(review_score)                                 as avg_review_score,
    avg(case when delivered_on_time is not null then case when delivered_on_time then 1.0 else 0.0 end end) as on_time_rate
from {{ ref('fct_order_items') }}
where is_valid_sale
  and order_month between cast('{{ var("report_start") }}' as date) and cast('{{ var("report_end") }}' as date)
group by 1, 2
