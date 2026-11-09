
-- ============================================================
-- SUPERSTORE SALES ANALYTICS
-- Data Quality and Consistency Checks
-- ============================================================
-- Purpose:
-- Validate data consistency before creating a normalized
-- relational database in the core schema.
--
-- Source table: staging.superstore_clean
-- ============================================================


-- 1. Check for duplicate row IDs
-- Each row_id should uniquely identify one order line.

SELECT
    row_id
FROM staging.superstore_clean
GROUP BY row_id
HAVING COUNT(*) > 1;


-- 2. Check order-to-customer consistency
-- Each order_id should be associated with only one customer_id.

SELECT
    order_id,
    COUNT(DISTINCT customer_id) AS customers
FROM staging.superstore_clean
GROUP BY order_id
HAVING COUNT(DISTINCT customer_id) > 1;


-- 3. Check product ID consistency
-- Identify product IDs associated with multiple product names.
--
-- Result:
-- 32 product IDs are associated with two distinct product names.
-- This requires further investigation before creating
-- the core.products table.

SELECT
    product_id,
    COUNT(DISTINCT product_name) AS products
FROM staging.superstore_clean
GROUP BY product_id
HAVING COUNT(DISTINCT product_name) > 1;


-- 4. Investigate inconsistent product IDs
-- Retrieve the distinct product names associated with
-- the product IDs identified in the previous check.
--
-- The CTE identifies inconsistent product IDs.
-- The JOIN retrieves their corresponding product names.

WITH duplicates AS (
    SELECT
        product_id,
        COUNT(DISTINCT product_name) AS products
    FROM staging.superstore_clean
    GROUP BY product_id
    HAVING COUNT(DISTINCT product_name) > 1
)
SELECT
    sc.product_id,
    sc.product_name
FROM staging.superstore_clean sc
JOIN duplicates d
    ON d.product_id = sc.product_id
GROUP BY sc.product_id, sc.product_name
ORDER BY sc.product_id, sc.product_name;


-- 5. Check customer data consistency
-- Verify whether each customer_id is associated with
-- a single customer name and segment.
--
-- Multiple segments may be valid depending on business rules.

SELECT
    customer_id,
    COUNT(DISTINCT customer_name) AS names,
    COUNT(DISTINCT segment) AS segments
FROM staging.superstore_clean
GROUP BY customer_id
HAVING
    COUNT(DISTINCT customer_name) > 1
    OR COUNT(DISTINCT segment) > 1;


-- 6. Check order data consistency
-- Verify whether each order_id has consistent customer,
-- order date, shipping date and shipping mode information.
--
-- Different shipping dates may indicate multiple shipments
-- rather than incorrect data.

SELECT
    order_id,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT order_date) AS order_dates,
    COUNT(DISTINCT ship_date) AS ship_dates,
    COUNT(DISTINCT ship_mode) AS ship_modes
FROM staging.superstore_clean
GROUP BY order_id
HAVING
    COUNT(DISTINCT customer_id) > 1
    OR COUNT(DISTINCT order_date) > 1
    OR COUNT(DISTINCT ship_date) > 1
    OR COUNT(DISTINCT ship_mode) > 1;


-- 7. Check product category consistency
-- Verify whether each product_id belongs to a single
-- combination of category and sub_category.
--
-- Result:
-- No product IDs have multiple category/subcategory combinations.
-- Product categories are consistent at the product_id level.

SELECT
    product_id,
    COUNT(DISTINCT (category, sub_category)) AS categories
FROM staging.superstore_clean
GROUP BY product_id
HAVING COUNT(DISTINCT (category, sub_category)) > 1;


