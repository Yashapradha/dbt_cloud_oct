{{config(materialized = 'incremental', unique_key='nation_id', on_schema_change="sync_all_columns")}}

with nation as(
    select 
    nation_id,
    region_id,
    nation_name,
    nation_comment,
    jodo_col,
    current_timestamp() as updated_at
    from {{ref('stg_nations')}}

    {% if is_incremental() %}
    WHERE updated_at > (
        SELECT COALESCE(MAX(updated_at), '1900-01-01') 
        FROM {{ this }}
    )
{% endif %}

)

select * from nation