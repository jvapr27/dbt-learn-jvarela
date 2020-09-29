with stg_orders as (select * from {{ ref('stg_orders') }}),
payments as (select * from {{ ref('stg_payments') }}),
final as (
 select 
  stg_orders.order_id, 
  stg_orders.customer_id,
  sum(payments.amount ) as total_order_amount,
  stg_orders.order_date
 from stg_orders left join payments using (order_id) 
 where payments.status = 'success'
 group by order_id, customer_id, order_date

)

select * from final 