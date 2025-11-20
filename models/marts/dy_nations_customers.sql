{{ config(
    materialized = 'dynamic_table',
    target_lag = '10 minutes',
    snowflake_warehouse = 'TRANSFORM_WH',
    refresh_mode='incremental'
) }}

select  
    n.nation_name  nation_name,
    sum(c.customer_id)  no_of_customers,
    sum(c.account_balance)  account_balance
from {{ ref('stg_customers') }} c
join {{ ref('stg_nations') }} n on c.nation_id = n.nation_id
group by n.nation_name