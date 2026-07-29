{{ config(materialized='ephemeral') }}

with hosts as(

    select host_id, host_name, host_since, IS_SUPERHOST, RESPONSE_RATE_QUALITY, HOST_CREATED_AT
    from {{ref('obt')}}
)
select * from hosts