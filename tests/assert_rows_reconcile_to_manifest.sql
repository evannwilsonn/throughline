-- Row counts in the raw layer must match what the extractor recorded when it downloaded each file.
{% set tables = ['orders','order_items','order_payments','order_reviews','customers','sellers','products','category_translation'] %}
with loaded as (
    {%- for t in tables %}
    select '{{ t }}' as tbl, count(*) as n from {{ source('olist', t) }}{% if not loop.last %} union all{% endif %}
    {%- endfor %}
)
select l.tbl, l.n, m."rows" as manifest_rows
from loaded as l
join {{ source('olist', '_extract_manifest') }} as m on m."table" = l.tbl
where l.n <> m."rows"
