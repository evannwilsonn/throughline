select
    i.order_id,
    i.order_item_seq,
    i.product_id,
    i.seller_id,
    pr.category,
    o.order_month,
    o.customer_state,
    o.is_valid_sale,
    o.delivered_on_time,
    o.review_score,
    i.item_price,
    i.freight_value
from {{ ref('stg_olist__order_items') }} as i
join {{ ref('fct_orders') }} as o using (order_id)
left join {{ ref('dim_products') }} as pr using (product_id)
