-- English category names, with a readable label when Olist left the category blank or untranslated.
select
    p.product_id,
    coalesce(t.category_en, p.category_pt, 'uncategorized')            as category_raw,
    upper(left(coalesce(t.category_en, p.category_pt, 'uncategorized'), 1))
        || replace(substr(coalesce(t.category_en, p.category_pt, 'uncategorized'), 2), '_', ' ') as category,
    p.category_pt,
    t.category_en is null and p.category_pt is not null                as missing_translation,
    p.photo_count,
    p.weight_g,
    p.volume_cm3
from {{ ref('stg_olist__products') }} as p
left join {{ ref('stg_olist__category_translation') }} as t using (category_pt)
