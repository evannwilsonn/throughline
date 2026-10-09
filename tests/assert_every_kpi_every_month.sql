-- Each reported month carries every KPI in the catalog, so no tile can silently go blank.
select month_start, count(*) as kpis
from {{ ref('rpt_kpi_monthly') }}
group by 1
having count(*) <> (select count(*) from {{ ref('kpi_definitions') }})
