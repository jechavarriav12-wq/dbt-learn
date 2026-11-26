SELECT order_id, total_amount 
from {{ref('fct_orders')}}
WHERE total_amount<0