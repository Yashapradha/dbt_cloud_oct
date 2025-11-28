{% macro jinja_functions() -%}
    '{{ invocation_id }}'::varchar AS dbt_batch_id,
    '{{ run_started_at }}'::timestamp as dbt_batch_ts
{%- endmacro %}