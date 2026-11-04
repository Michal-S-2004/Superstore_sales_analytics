create schema staging

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.superstore (
    "Row ID" INTEGER,
    "Order ID" VARCHAR(20),
    "Order Date" DATE,
    "Ship Date" DATE,
    "Ship Mode" VARCHAR(50),
    "Customer ID" VARCHAR(20),
    "Customer Name" VARCHAR(100),
    "Segment" VARCHAR(50),
    "Country" VARCHAR(100),
    "City" VARCHAR(100),
    "State" VARCHAR(100),
    "Postal Code" VARCHAR(20),
    "Region" VARCHAR(50),
    "Product ID" VARCHAR(30),
    "Category" VARCHAR(50),
    "Sub-Category" VARCHAR(50),
    "Product Name" TEXT,
    "Sales" NUMERIC(12,2),
    "Quantity" INTEGER,
    "Discount" NUMERIC(5,2),
    "Profit" NUMERIC(12,2)
);

SELECT *
FROM staging.sample 
limit 10;

SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'staging'
  AND table_name = 'sample'
ORDER BY ordinal_position;

SELECT
    "Order Date",
    TO_DATE("Order Date", 'MM/DD/YYYY') AS order_date,
    "Ship Date",
    TO_DATE("Ship Date", 'MM/DD/YYYY') AS ship_date
FROM staging.sample
LIMIT 10;