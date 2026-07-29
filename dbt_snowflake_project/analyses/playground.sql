

select
    order_id,
    sum(case when payment_method = 'bank_transfer' then amount end) as bank_transfer_amount,
    sum(case when payment_method = 'credit_card' then amount end) as credit_card_amount,
    sum(case when payment_method = 'gift_card' then amount end) as gift_card_amount,
    sum(amount) as total_amount
from app_data.payments
group by 1

--

{% set payment_methods = ['bank_transfer','credit_card','gift_card'] %}

select
    order_id,
    {% for payment_method in payment_methods %}
    sum(case when payment_method = '{{payment_method}}' then amount end ) as {{payment_method}}_amount,
    {% endfor %}
    sum(anmount) as total_amount
from app_data.payments
group by 1

--

{% set flag=1 %}

SELECT * FROM {{ ref('bronze_bookings') }}
{% if flag==1 %}
    where nights_booked > 1
{% else %}
    where night_booked = 1
{% endif %}


--
{% set incremental_flag = 1 %}
{% set incremental_column = 's_date' %}

select * from source('staging','listings')
{% if incremental_flag == 1 %}
   WHERE {{ incremental_column }}> SELECT COALESCE(MAX({{ incremental_column }}),'1900-01-01') from {{ ref("bronze_listings") }}
{% endif %}