-- Review text is Portuguese free text and stays out of the warehouse; only the score and timing are used.
select
    trim(review_id)                          as review_id,
    trim(order_id)                           as order_id,
    {{ to_int('review_score') }}             as review_score,
    {{ to_ts('review_creation_date') }}      as review_sent_at,
    {{ to_ts('review_answer_timestamp') }}   as review_answered_at,
    nullif(trim(review_comment_message), '') is not null as has_comment
from {{ source('olist', 'order_reviews') }}
