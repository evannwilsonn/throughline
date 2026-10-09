select
    trim(product_id)                              as product_id,
    nullif(trim(product_category_name), '')       as category_pt,
    {{ to_int('product_photos_qty') }}            as photo_count,
    {{ to_num('product_weight_g') }}              as weight_g,
    {{ to_num('product_length_cm') }} * {{ to_num('product_height_cm') }} * {{ to_num('product_width_cm') }} as volume_cm3
from {{ source('olist', 'products') }}
