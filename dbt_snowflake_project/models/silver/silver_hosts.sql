{{ config(materialized="incremental", unique_key="HOST_ID") }}

select
    host_id,
    replace(host_name, ' ', '_') as host_name,
    host_since,
    is_superhost,
    response_rate,
    case
        when response_rate > 90 then 'Very Good Response Rate'
        when response_rate > 80 then 'Good Response Rate'
        when response_rate > 60 then 'Average Response Rate'
        else 'Poor Response Rate'
    end as response_rate_quality,
    created_at
from {{ ref("bronze_hosts") }}
