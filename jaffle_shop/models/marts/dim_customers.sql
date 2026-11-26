with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

orders_1 as(
    select sum(case when total_amount is null then 0 else total_amount end) as lifetime_value,
    customer_id
    from {{ref('fct_orders')}}
    group by customer_id
),

customer_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders
    from orders
    group by customer_id
)

select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customer_orders.first_order_date,
    customer_orders.most_recent_order_date,
    coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
    coalesce(orders_1.lifetime_value,0) as lifetime_value

from customers
left join customer_orders
    on customers.customer_id = customer_orders.customer_id
left join orders_1
    on customers.customer_id = orders_1.customer_id
