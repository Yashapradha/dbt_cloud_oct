with nation_info as (
select 
n.nation_id, 
n.nation_name,
r.region_id,
r.region_name, 
n.nation_comment 
from {{ref('stg_nations')}} n join {{ref('stg_regions')}} r on n.region_id=r.region_id
)
select * from nation_info