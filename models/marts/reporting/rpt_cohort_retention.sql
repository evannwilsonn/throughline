-- Share of each monthly cohort (first valid order) that ordered again N months later.
with activity as (
    select distinct c.cohort_month, o.customer_unique_id, o.order_month
    from {{ ref('fct_orders') }} as o
    join {{ ref('dim_customers') }} as c using (customer_unique_id)
    where o.is_valid_sale
),
sized as (
    select cohort_month, count(distinct customer_unique_id) as cohort_size
    from activity group by 1
)
select
    a.cohort_month,
    {{ months_between('a.cohort_month', 'a.order_month') }}   as months_since_first,
    s.cohort_size,
    count(distinct a.customer_unique_id)                       as active_customers,
    count(distinct a.customer_unique_id) * 1.0 / s.cohort_size as retention_rate
from activity as a
join sized as s using (cohort_month)
where a.cohort_month between cast('{{ var("report_start") }}' as date) and cast('{{ var("report_end") }}' as date)
  and a.order_month <= cast('{{ var("report_end") }}' as date)
group by 1, 2, 3
