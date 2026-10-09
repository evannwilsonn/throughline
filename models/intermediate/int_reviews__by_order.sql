-- One score per order. When a customer reviewed twice, the most recent answer wins.
select
    order_id,
    review_score,
    has_comment,
    review_answered_at
from {{ ref('stg_olist__order_reviews') }}
qualify row_number() over (partition by order_id order by review_answered_at desc, review_id) = 1
