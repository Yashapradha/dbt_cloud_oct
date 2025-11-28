{{ config(
    tags = 'sample'
)}}
with suppliers as (
    select *
    from {{ ref('stg_suppliers') }}
),

nations as (
    select *
    from {{ ref('stg_nations') }}
),

regions as (
    select *
    from {{ ref('stg_regions') }}
)

select
    s.* exclude nation_id,
    n.nation_name as nation_name,
    r.region_name as region_name,
    {{jinja_functions()}}
from suppliers s
join nations n
    on s.nation_id = n.nation_id
join regions r
    on n.region_id = r.region_id