/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

/*Segment products into cost ranges and 
count how many products fall into each segment*/

SELECT
    segment,
    COUNT(product_name) total_products
FROM (
    SELECT
        product_name,
        cost,
        CASE
            WHEN cost < 100 THEN 'Below 100'
            WHEN cost>100 AND cost<=500 THEN '100-500'
            WHEN cost >500 AND cost <=1000 THEN '500-1000'
            ELSE 'above 1000'
        END AS segment
    FROM gold.dim_products
) t
GROUP BY segment
ORDER BY total_products DESC;


/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/

WITH customer_spending AS (
    SELECT
        c.customer_key,
        SUM(f.sales_amount) total_spending,
        MIN(order_date) first_order,
        MAX(order_date) last_order,
        DATEDIFF(month, MIN(order_date), MAX(order_date)) lifespan
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c
        ON f.customer_key = c.customer_key
    GROUP BY c.customer_key
)
SELECT
    customer_segment,
    COUNT(customer_key) total_customers
FROM (
    SELECT
        customer_key,
        lifespan,
        CASE
            WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
            WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spending
) t
GROUP BY customer_segment
ORDER BY total_customers;