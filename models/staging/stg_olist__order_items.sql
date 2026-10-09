select
    trim(order_id)                     as order_id,
    {{ to_int('order_item_id') }}      as order_item_seq,
    trim(product_id)                   as product_id,
    trim(seller_id)                    as seller_id,
    {{ to_ts('shipping_limit_date') }} as ship_by_at,
    {{ to_num('price') }}              as item_price,
    {{ to_num('freight_value') }}      as freight_value
from {{ source('olist', 'order_items') }}
