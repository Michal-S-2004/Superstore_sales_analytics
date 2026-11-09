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

-- Results:
-- Test 1: No duplicate row IDs (if confirmed)
-- Test 2: No orders assigned to multiple customers (if confirmed)
-- Test 3: 32 product IDs associated with two distinct product names
-- Further investigation required before creating core.products

with duplicates as(select product_id, count(distinct product_name) as products
from staging.superstore_clean sc 
group by product_id 
having count(distinct product_name)>1)
select sc.product_id, sc.product_name
from staging.superstore_clean sc 
join duplicates d on d.product_id = sc.product_id
group by sc.product_id, sc.product_name
order by sc.product_id, sc.product_name
