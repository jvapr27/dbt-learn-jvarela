with orders as (select * from {{ ref('stg_orders') }}),
payments as (select * from {{ ref('stg_payments') }}),
final as (
 select 
  orders.order_id, 
  orders.customer_id,
  sum(payments.amount ) as total_order_amount,
  orders.order_date
 from orders left join payments using (order_id) 
 where payments.status = 'success'
 group by order_id, customer_id, order_date

)

select * from final 