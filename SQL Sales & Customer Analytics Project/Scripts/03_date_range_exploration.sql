-- Find the Date of the First And Last Order
-- How Many Years of sales are avaiable
SELECT
    MIN(order_date) first_order_date,
    MAX(order_date) last_order_date,
    DATEDIFF(year, MIN(order_date), MAX(order_date)) order_range_years
FROM gold.fact_sales;


-- Find the yongest and oldest customers
SELECT
    MIN(birthdate) Oldest_customer,
    DATEDIFF(year, MIN(birthdate), GETDATE()) Oldest_Age,
    MAX(birthdate) Youngest_customer,
    DATEDIFF(year, MAX(birthdate), GETDATE()) Youngest_Age
FROM gold.dim_customers;