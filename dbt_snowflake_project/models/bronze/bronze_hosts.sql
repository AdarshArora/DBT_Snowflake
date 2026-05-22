--select * from {{ source('staging','hosts') }}


{# {% set incremental_flag = 1 %}
{% set incremental_column = 'created_at' %} #}

{{  config(materialized='incremental') }}

select * from {{ source('staging','hosts') }}
{% if is_incremental() %}
    WHERE created_at> (SELECT COALESCE(MAX(created_at),'1900-01-01') from {{ this }})
{% endif %}