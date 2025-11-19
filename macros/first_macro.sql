{%macro jodo(col1,col2) %}
    {{col1}} || ' ' ||{{col2}}
{% endmacro %}

{% macro gender(gn) %}
    case
        when {{ gn }} = 'M' then 'Male'
        when {{ gn }} = 'F' then 'Female'
        else 'Unknown'
    end
{% endmacro %}


{% macro age_group(employee_age) %}
CASE 
        WHEN employee_age < 25 THEN 'Youngster'
        WHEN employee_age < 60 THEN 'Middle'
        ELSE 'Senior'
        end
        {% endmacro %}

{%macro phone(ph) %}

 '(' ||SUBSTR({{ph}}, 1, 3) || ') ' ||   SUBSTR({{ph}}, 4, 3) || '-' ||   SUBSTR({{ph}}, 7)
{% endmacro %}




{% macro show_emps() %}
    
    {% set query %}
        select name
        from {{ ref('stg_employees') }}
    {% endset %}
    
    {% set results = run_query(query) %}
    
    {{log(results.print_table(), info=True      )}}
{% endmacro %}


{% macro stage_and_unload() %}

    {{ run_query("create or replace stage dbt_stage directory = (enable = true);") }}

    {{ run_query("
        copy into @dbt_stage
        from  ref('stg_nations')
        file_format = (type = csv  );
    ") }}

{% endmacro %}

{% macro unload()%}
{% do run_query("create or replace stage stage_analytics") %}
{% do run_query("copy into @stage_analytics from stg_nations partition by (region_id)
file_format= (type = csv compression=none null_if=(' ')) header=true ; ") %}
{% endmacro %}


{% macro mod_tab(table_name) %}
    {% set sql_stmt = "alter table " ~ table_name ~ " add column updated_at timestamp_ltz" %}
    {% do run_query(sql_stmt) %}
{% endmacro %}
