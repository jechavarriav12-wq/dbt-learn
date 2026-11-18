SELECT 
id,
id*10 as id_por_diez
from {{ref('my_second_dbt_model')}}