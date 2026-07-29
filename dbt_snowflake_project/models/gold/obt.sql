{% set configs = [

    {
        "table": "AIRBNB.SILVER.SILVER_BOOKINGS",
        "columns": "silver_bookings.*",
        "alias":"silver_bookings"
    },
    {
        "table":"AIRBNB.SILVER.SILVER_LISTINGS",
        "columns":"silver_listings.host_id,silver_listings.property_type,silver_listings.room_type,silver_listings.city,silver_listings.country,silver_listings.accommodates,silver_listings.bedrooms,silver_listings.bathrooms,silver_listings.price_per_night,silver_listings.price_tag,silver_listings.created_at as LISTING_CREATED_AT",
        "alias":"silver_listings",
        "join_condition":"silver_bookings.listing_id = silver_listings.listing_id"
    },
    {
        "table":"AIRBNB.SILVER.SILVER_HOSTS",
        "columns":"silver_hosts.HOST_NAME,silver_hosts.HOST_SINCE,silver_hosts.IS_SUPERHOST,silver_hosts.RESPONSE_RATE,silver_hosts.RESPONSE_RATE_QUALITY,silver_hosts.CREATED_AT as HOST_CREATED_AT",
        "alias":"silver_hosts",
        "join_condition":"silver_hosts.host_id = silver_listings.host_id"
    }
] %}


select 
    {% for config in configs %}
        {{ config.columns }}{% if not loop.last %},{% endif %}
    {% endfor %}
FROM {{ configs[0].table}}
{% for config in configs[1:]%}
LEFT JOIN {{ config.table }} as {{ config.alias }}
ON {{ config.join_condition }}
{% endfor %}
    
