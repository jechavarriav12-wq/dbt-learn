SELECT id as payment_id, (amount/100) as amount,
FROM {{ref('raw_payments')}}