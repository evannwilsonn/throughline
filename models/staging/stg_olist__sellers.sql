select
    trim(seller_id)                   as seller_id,
    lpad(trim(seller_zip_code_prefix), 5, '0') as zip_prefix,
    lower(trim(seller_city))          as city,
    upper(trim(seller_state))         as state
from {{ source('olist', 'sellers') }}
