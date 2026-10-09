-- One row per person, with lifetime order history.
select
    customer_unique_id,
    min_by(customer_state, purchased_at)                       as home_state,
    min(case when is_valid_sale then order_month end)          as cohort_month,
    max(purchased_at)                                          as last_order_at,
    sum(case when is_valid_sale then 1 else 0 end)                      as valid_orders,
    sum(case when is_valid_sale then order_value else 0 end)   as lifetime_value
from {{ ref('fct_orders') }}
group by 1
