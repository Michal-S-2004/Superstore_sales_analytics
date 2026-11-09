select row_id
from staging.superstore_clean 
group by row_id 
having count(*)>1;

select order_id, count(distinct customer_id) as customers
from staging.superstore_clean sc 
group by order_id
having count(distinct customer_id)>1;

select product_id, count(distinct product_name) as products
from staging.superstore_clean sc 
group by product_id 
having count(distinct product_name)>1;