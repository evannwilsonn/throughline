select
    trim(order_id)                                   as order_id,
    trim(customer_id)                                as customer_id,
    lower(trim(order_status))                        as order_status,
    {{ to_ts('order_purchase_timestamp') }}          as purchased_at,
    {{ to_ts('order_approved_at') }}                 as approved_at,
    {{ to_ts('order_delivered_carrier_date') }}      as shipped_at,
    {{ to_ts('order_delivered_customer_date') }}     as delivered_at,
    cast({{ to_ts('order_estimated_delivery_date') }} as date) as promised_delivery_date,
    _loaded_at
from {{ source('olist', 'orders') }}
