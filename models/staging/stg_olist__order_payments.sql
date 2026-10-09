-- "not_defined" appears on a handful of zero-value rows; it's kept and labelled.
select
    trim(order_id)                          as order_id,
    {{ to_int('payment_sequential') }}      as payment_seq,
    case lower(trim(payment_type))
        when 'boleto' then 'boleto (bank slip)'
        when 'not_defined' then 'unknown'
        else replace(lower(trim(payment_type)), '_', ' ')
    end                                     as payment_type,
    {{ to_int('payment_installments') }}    as installments,
    {{ to_num('payment_value') }}           as payment_value
from {{ source('olist', 'order_payments') }}
