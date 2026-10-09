-- Item value per order: what the customer bought, what freight cost, and how many sellers shipped it.
select
    order_id,
    count(*)                    as item_count,
    count(distinct seller_id)   as seller_count,
    sum(item_price)             as product_value,
    sum(freight_value)          as freight_value
from {{ ref('stg_olist__order_items') }}
group by 1
