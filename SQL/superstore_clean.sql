CREATE TABLE staging.superstore_clean AS
SELECT
    "Row ID"::INTEGER AS row_id,
    "Order ID"::VARCHAR(20) AS order_id,
    TO_DATE("Order Date", 'MM/DD/YYYY') AS order_date,
    TO_DATE("Ship Date", 'MM/DD/YYYY') AS ship_date,
    "Ship Mode" AS ship_mode,
    "Customer ID" AS customer_id,
    "Customer Name" AS customer_name,
    "Segment" AS segment,
    "Country" AS country,
    "City" AS city,
    "State" AS state,
    "Postal Code"::VARCHAR(20) AS postal_code,
    "Region" AS region,
    "Product ID" AS product_id,
    "Category" AS category,
    "Sub-Category" AS sub_category,
    "Product Name" AS product_name,
    "Sales"::NUMERIC(12,2) AS sales,
    "Quantity"::INTEGER AS quantity,
    "Discount"::NUMERIC(5,2) AS discount,
    "Profit"::NUMERIC(12,2) AS profit
FROM staging.sample;