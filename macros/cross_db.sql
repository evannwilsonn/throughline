{#- Cross-database helpers: every model runs unchanged on DuckDB (local) and Snowflake. -#}

{# Text timestamp 'YYYY-MM-DD HH:MI:SS' to timestamp; blanks become null #}
{% macro to_ts(column) -%}{{ return(adapter.dispatch('to_ts')(column)) }}{%- endmacro %}
{% macro duckdb__to_ts(column) -%}try_strptime(nullif(trim({{ column }}), ''), '%Y-%m-%d %H:%M:%S'){%- endmacro %}
{% macro snowflake__to_ts(column) -%}try_to_timestamp_ntz(nullif(trim({{ column }}), ''), 'YYYY-MM-DD HH24:MI:SS'){%- endmacro %}

{# Text to number; blanks become null #}
{% macro to_num(column) -%}{{ return(adapter.dispatch('to_num')(column)) }}{%- endmacro %}
{% macro duckdb__to_num(column) -%}try_cast(nullif(trim({{ column }}), '') as double){%- endmacro %}
{% macro snowflake__to_num(column) -%}try_to_double(nullif(trim({{ column }}), '')){%- endmacro %}

{% macro to_int(column) -%}{{ return(adapter.dispatch('to_int')(column)) }}{%- endmacro %}
{% macro duckdb__to_int(column) -%}try_cast(nullif(trim({{ column }}), '') as integer){%- endmacro %}
{% macro snowflake__to_int(column) -%}try_to_number(nullif(trim({{ column }}), '')){%- endmacro %}

{# Whole days between two timestamps (fractional, so 36 hours = 1.5) #}
{% macro days_between(start_ts, end_ts) -%}{{ return(adapter.dispatch('days_between')(start_ts, end_ts)) }}{%- endmacro %}
{% macro duckdb__days_between(start_ts, end_ts) -%}(epoch({{ end_ts }}) - epoch({{ start_ts }})) / 86400.0{%- endmacro %}
{% macro snowflake__days_between(start_ts, end_ts) -%}datediff(second, {{ start_ts }}, {{ end_ts }}) / 86400.0{%- endmacro %}

{# Months between two month-start dates #}
{% macro months_between(start_month, end_month) -%}{{ return(adapter.dispatch('months_between')(start_month, end_month)) }}{%- endmacro %}
{% macro duckdb__months_between(start_month, end_month) -%}datediff('month', {{ start_month }}, {{ end_month }}){%- endmacro %}
{% macro snowflake__months_between(start_month, end_month) -%}datediff(month, {{ start_month }}, {{ end_month }}){%- endmacro %}

{% macro month_start(column) -%}cast(date_trunc('month', {{ column }}) as date){%- endmacro %}

{# Shift a date by n months #}
{% macro add_months(column, n) -%}{{ return(adapter.dispatch('add_months')(column, n)) }}{%- endmacro %}
{% macro duckdb__add_months(column, n) -%}cast({{ column }} + to_months({{ n }}) as date){%- endmacro %}
{% macro snowflake__add_months(column, n) -%}dateadd(month, {{ n }}, {{ column }}){%- endmacro %}
