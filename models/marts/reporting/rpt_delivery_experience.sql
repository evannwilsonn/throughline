-- How delivery timing drives review scores. The single clearest lever in the data.
with d as (
    select
        case
            when days_late <= -10 then '1. 10+ days early'
            when days_late <= -1  then '2. 1-9 days early'
            when days_late <= 0   then '3. On the promised day'
            when days_late <= 3   then '4. 1-3 days late'
            when days_late <= 7   then '5. 4-7 days late'
            else '6. 8+ days late'
        end as delivery_bucket,
        review_score
    from {{ ref('fct_orders') }}
    where is_delivered and review_score is not null
      and order_month between cast('{{ var("report_start") }}' as date) and cast('{{ var("report_end") }}' as date)
)
select
    delivery_bucket,
    count(*)                                                   as orders,
    count(*) * 1.0 / sum(count(*)) over ()                     as share_of_orders,
    avg(review_score)                                          as avg_review_score,
    avg(case when review_score = 1 then 1.0 else 0.0 end)      as one_star_rate,
    avg(case when review_score = 5 then 1.0 else 0.0 end)      as five_star_rate
from d
group by 1
