with order_payments as (
    select order_id,
    sum(amount) as amount
    from {{ ref('stg_payments') }}
    where status = 'success'
    group by order_id
),
orders as (
    select *
    from {{ ref('stg_orders') }}
)
select o.order_id,
o.order_date,
o.customer_id,
coalesce(op.amount,0) amount
from orders o
left join order_payments op on o.order_id = op.order_id