{% set configs = [

    {
        "table": "AIRBNB.gold.obt",
        "columns": "gold_obt.booking_id,gold_obt.host_id,gold_obt.listing_id,gold_obt.TOTAL_BOOKING_AMOUNT,gold_obt.CLEANING_FEE,gold_obt.SERVICE_FEE,gold_obt.ACCOMMODATES,gold_obt.BEDROOMS,gold_obt.BATHROOMS,gold_obt.PRICE_PER_NIGHT,gold_obt.RESPONSE_RATE",
        "alias":"gold_obt"
    },
    {
        "table":"AIRBNB.gold.dim_bookings",
        "columns":"",
        "alias":"dim_bookings",
        "join_condition":"gold_obt.booking_id = dim_bookings.booking_id"
    },
    {
        "table":"AIRBNB.gold.dim_hosts",
        "columns":"",
        "alias":"dim_hosts",
        "join_condition":"gold_obt.host_id = dim_hosts.host_id"
    },
    {
        "table":"AIRBNB.gold.dim_listings",
        "columns":"",
        "alias":"dim_listings",
        "join_condition":"gold_obt.listing_id = dim_listings.listing_id"
    }
] %}


select {{configs[0].columns}}
FROM {{ configs[0].table}} as {{configs[0].alias}}
{% for config in configs[1:]%}
LEFT JOIN {{ config.table }} as {{ config.alias }}
ON {{ config.join_condition }}
{% endfor %}
    
