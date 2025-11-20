WITH customers as (
    SELECT *
    FROM {{ ref('stg_customers') }}
),
nations as (
    SELECT *
    FROM {{ ref('stg_nations') }}
),
regions as (
    SELECT *
    FROM {{ ref('stg_regions') }}
)
SELECT
    *
FROM customers c
 JOIN nations n
    ON c.nation_id = n.nation_id
JOIN regions r
    ON n.region_id = r.region_id