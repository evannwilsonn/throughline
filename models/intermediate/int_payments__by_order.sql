-- Payment totals per order. The main payment type is the one that paid the most.
select
    order_id,
    sum(payment_value)                       as amount_paid,
    count(*)                                 as payment_count,
    max_by(payment_type, payment_value)      as main_payment_type,
    max(installments)                        as max_installments,
    max(case when payment_type = 'voucher' then 1 else 0 end) = 1 as used_voucher
from {{ ref('stg_olist__order_payments') }}
group by 1
