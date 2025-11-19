{% snapshot stg_orders %}
{{
    config(
        target_database='analytics',
        target_schema='scd',
        unique_key='o_orderkey',
        strategy='check',
        check_cols=['o_orderpriority','o_orderdate','o_comment'],
        hard_deletes='new_record',
        alias='scd_orders3'
    )
}}
select * from {{source('src','orders')}}
{% endsnapshot %}
