-- Paid amount should be close to item value plus freight. Vouchers and installment interest
-- explain most gaps, so this warns rather than fails and lists the outliers for review.
{{ config(severity='warn', warn_if='>200') }}
select order_id, order_value, amount_paid, payment_gap
from {{ ref('fct_orders') }}
where is_valid_sale
  and not used_voucher
  and amount_paid is not null
  and abs(payment_gap) > greatest(0.2 * order_value, 5)
