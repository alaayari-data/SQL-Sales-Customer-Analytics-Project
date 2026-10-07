-- Find the Total Sales
SELECT
    SUM(sales_amount) total_sales
FROM gold.fact_sales;


-- Find how many items are sold
SELECT
    SUM(quantity) total_quantity
FROM gold.fact_sales;


-- Find the average selling price
SELECT
    AVG(price) avg_price
FROM gold.fact_sales;


-- Find the Total number of Orders
SELECT
    COUNT(order_number) total_orders
FROM gold.fact_sales;

SELECT
    COUNT(DISTINCT order_number) total_orders
FROM gold.fact_sales;


-- Find the total number of products
SELECT
    COUNT(product_id) total_products
FROM gold.dim_products;

SELECT
    COUNT(DISTINCT product_id) total_products
FROM gold.dim_products;


-- Find the total number of customers
SELECT
    COUNT(customer_id) total_customers
FROM gold.dim_customers;


-- Find the total number of customers that has placed an order
SELECT
    COUNT(DISTINCT customer_key) total_customers
FROM gold.fact_sales;


-- Generate a report that show all the key metrics of the business
SELECT
    'Total Sales' AS MeasureName,
    SUM(sales_amount) MeasureValue
FROM gold.fact_sales

UNION ALL

SELECT
    'Total Quantity' AS MeasureName,
    SUM(quantity) MeasureValue
FROM gold.fact_sales

UNION ALL

SELECT
    'Average Price' AS MeasureName,
    AVG(sales_amount) MeasureValue
FROM gold.fact_sales

UNION ALL

SELECT
    'Nr. Orders' AS MeasureName,
    COUNT(DISTINCT order_number) MeasureValue
FROM gold.fact_sales

UNION ALL

SELECT
    'Nr. Products' AS MeasureName,
    COUNT(DISTINCT product_id) MeasureValue
FROM gold.dim_products

UNION ALL

SELECT
    'Nr. Customers' AS MeasureName,
    COUNT(customer_id) MeasureValue
FROM gold.dim_customers;