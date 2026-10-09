-- One row per order: value, payment, delivery performance, review and customer sequence.
-- customer_unique_id is the real person; Olist issues a new customer_id on every order.
with o as (
    select
        o.*,
        c.customer_unique_id,
        c.state       as customer_state,
        c.city        as customer_city
    from {{ ref('stg_olist__orders') }} as o
    join {{ ref('stg_olist__customers') }} as c using (customer_id)
)

select
    o.order_id,
    o.customer_unique_id,
    o.customer_state,
    o.customer_city,
    o.order_status,
    o.purchased_at,
    {{ month_start('o.purchased_at') }}                                     as order_month,
    o.order_status not in ('canceled', 'unavailable')                       as is_valid_sale,
    o.order_status = 'delivered' and o.delivered_at is not null             as is_delivered,
    coalesce(i.item_count, 0)                                               as item_count,
    coalesce(i.seller_count, 0)                                             as seller_count,
    coalesce(i.product_value, 0)                                            as product_value,
    coalesce(i.freight_value, 0)                                            as freight_value,
    coalesce(i.product_value, 0) + coalesce(i.freight_value, 0)             as order_value,
    p.amount_paid,
    p.main_payment_type,
    p.max_installments,
    coalesce(p.used_voucher, false)                                         as used_voucher,
    -- vouchers and interest on installments make paid differ from order value; keep the gap visible
    p.amount_paid - (coalesce(i.product_value, 0) + coalesce(i.freight_value, 0)) as payment_gap,
    o.promised_delivery_date,
    o.delivered_at,
    case when o.delivered_at is not null
         then {{ days_between('o.purchased_at', 'o.delivered_at') }} end    as days_to_deliver,
    case when o.delivered_at is not null
         then cast(o.delivered_at as date) <= o.promised_delivery_date end  as delivered_on_time,
    case when o.delivered_at is not null
         then {{ days_between('cast(o.promised_delivery_date as timestamp)', 'cast(cast(o.delivered_at as date) as timestamp)') }}
    end                                                                      as days_late,
    r.review_score,
    r.has_comment                                                            as review_has_comment,
    row_number() over (partition by o.customer_unique_id order by o.purchased_at, o.order_id) as customer_order_number
from o
left join {{ ref('int_order_items__by_order') }} as i using (order_id)
left join {{ ref('int_payments__by_order') }} as p using (order_id)
left join {{ ref('int_reviews__by_order') }} as r using (order_id)
