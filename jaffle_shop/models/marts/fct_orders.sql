with payments as( 
    SELECT order_id,
    sum(CASE WHEN payment_method='bank_transfer' then amount else 0 end) as bank_transfer_amount,
    sum(CASE WHEN payment_method='credit_card' then amount else 0 end) as credit_card_amount,
    sum(CASE WHEN payment_method='coupon' then amount else 0 end) as coupon_amount,
    sum(CASE WHEN payment_method='gift_card' then amount else 0 end) as gift_card_amount,
    sum(amount) as total_amount
    FROM {{ref('stg_payments')}}
    GROUP BY order_id
),
customer_orders as (
    SELECT customer_id, status, order_id,order_date
    FROM {{ref('stg_orders')}}
)

SELECT 
    coalesce(payments.bank_transfer_amount, 0) as bank_transfer_amount,
    coalesce(payments.credit_card_amount, 0) as credit_card_amount,
    coalesce(payments.coupon_amount, 0) as coupon_amount,
    coalesce(payments.gift_card_amount, 0) as gift_card_amount,
    coalesce(payments.total_amount, 0) as total_amount,
    customer_orders.order_id,
    customer_orders.customer_id,
    customer_orders.order_date,
    customer_orders.status
FROM customer_orders
left join payments
    on customer_orders.order_id=payments.order_id