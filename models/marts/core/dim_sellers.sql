select seller_id, city, state, zip_prefix from {{ ref('stg_olist__sellers') }}
