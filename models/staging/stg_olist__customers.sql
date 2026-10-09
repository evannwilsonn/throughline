select
    trim(customer_id)                 as customer_id,
    trim(customer_unique_id)          as customer_unique_id,
    lpad(trim(customer_zip_code_prefix), 5, '0') as zip_prefix,
    lower(trim(customer_city))        as city,
    upper(trim(customer_state))       as state
from {{ source('olist', 'customers') }}
