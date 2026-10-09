select
    trim(product_category_name)                    as category_pt,
    trim(product_category_name_english)            as category_en
from {{ source('olist', 'category_translation') }}
