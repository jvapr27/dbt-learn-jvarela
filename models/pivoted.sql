-- you can use jinja to generate sql 
-- 

with Payments as ( 
  select * from {{ ref('stg_payments') }}

), 

pivoted as (
  select order_id, 
  {% for payment_method in ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

  sum(case when payment_method = '{{ payment_method }}' then amount else 0 end ) as {{ payment_method }}_amount
  {%- if not loop.last %} , {% endif %}
  {%- endfor %}
  from Payments

  group by 1

)

select * from pivoted