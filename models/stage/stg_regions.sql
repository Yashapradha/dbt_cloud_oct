{{ config(alias="stage_regions") }}

with
    region as (
        select
            r_regionkey as region_id,
            r_name as region_name,
            r_comment as region_comment,
            {{ jinja_functions() }}
        from {{ source("src", "regions") }}
    )
select *
from region
