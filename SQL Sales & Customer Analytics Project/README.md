# Sales Data Analysis

Analysis of a sales database containing customer, product, and order data to answer business questions around **revenue, customer behavior, product performance, and sales trends**.

The project progresses from data exploration and business metrics to trend analysis, segmentation, and reusable reporting views designed for further analysis and reporting.

## Data

The analysis uses three tables from the `gold` schema in SQL Server:

| Table                | Description            | Main columns                                                                                     |
| -------------------- | ---------------------- | ------------------------------------------------------------------------------------------------ |
| `gold.fact_sales`    | One row per order line | `order_number`, `order_date`, `customer_key`, `product_key`, `sales_amount`, `quantity`, `price` |
| `gold.dim_customers` | One row per customer   | `customer_key`, `customer_number`, `first_name`, `last_name`, `country`, `gender`, `birthdate`   |
| `gold.dim_products`  | One row per product    | `product_key`, `product_id`, `product_name`, `category`, `subcategory`, `cost`                   |

`fact_sales` is connected to the customer and product dimensions through `customer_key` and `product_key`.

## Business Questions

The analysis focuses on questions such as:

* What data and dimensions are available in the database?
* Which countries do customers come from?
* What product categories and subcategories are available?
* What is the overall sales performance?
* How many orders, customers, products, and items are involved?
* How do sales and customer activity vary by country, gender, and category?
* Which products generate the most and least revenue?
* How do sales and customer activity change over time?
* What are the running sales totals and moving average prices?
* Which categories contribute the most to total revenue?
* How can products be classified by cost and performance?
* How can customers be segmented based on purchasing behavior and lifespan?

## Analysis Scripts

The scripts are organized in analysis stages:

| Script                             | Purpose                                                       |
| ---------------------------------- | ------------------------------------------------------------- |
| `01_database_exploration.sql`      | Explores the database structure, tables, and customer columns |
| `02_dimensions_exploration.sql`    | Analyzes countries, categories, subcategories, and products   |
| `03_date_range_exploration.sql`    | Examines order dates, sales periods, and customer age ranges  |
| `04_measures_exploration.sql`      | Calculates key business metrics and consolidated KPIs         |
| `05_magnitude_analysis.sql`        | Compares customers, products, and revenue across dimensions   |
| `06_ranking_analysis.sql`          | Identifies the top and bottom products by revenue             |
| `07_change_over_time_analysis.sql` | Analyzes monthly and yearly sales trends                      |
| `08_cumulative_analysis.sql`       | Calculates running sales totals and moving average prices     |
| `10_data_segmentation.sql`         | Creates product cost ranges and customer segments             |
| `11_part_to_whole_analysis.sql`    | Measures category contribution to total sales                 |
| `12_report_customers.sql`          | Creates `gold.report_customers` for customer-level reporting  |
| `13_report_products.sql`           | Creates `gold.report_products` for product-level reporting    |

## Reporting Views

### `gold.report_customers`

A customer-level reporting view containing:

* Customer name and age
* Age group
* Customer segment: **VIP, Regular, New**
* Total orders
* Total sales
* Total quantity
* Total products purchased
* Customer lifespan
* Recency
* Average order value
* Average monthly spend

This view provides a reusable customer profile for analyzing purchasing behavior and customer value.

### `gold.report_products`

A product-level reporting view containing:

* Product, category, and subcategory
* Product cost
* Performance segment: **High Performer, Mid Range, Low**
* Total orders
* Total sales
* Total quantity
* Unique customers
* Product lifespan
* Recency
* Average selling price
* Average order revenue
* Average monthly revenue

This view can be used to evaluate product performance and identify products with different levels of commercial contribution.

## SQL Skills Applied

* **Aggregations:** `SUM`, `AVG`, `COUNT`, `MIN`, `MAX`, `GROUP BY`
* **Joins:** `LEFT JOIN`
* **CTEs and subqueries**
* **Window functions:** `SUM() OVER`, `AVG() OVER`, `ROW_NUMBER() OVER`
* **Conditional logic:** `CASE`
* **Date analysis:** `DATEDIFF`, `DATETRUNC`, `FORMAT`, `GETDATE`
* **Set operations:** `UNION ALL`
* **Views:** `CREATE VIEW`
* **Data segmentation and business categorization**
* **Time-series and cumulative analysis**

## Key Findings

The analysis covers **60,398 order lines, 27,659 orders, 18,484 customers, and 295 products**, with sales data spanning from December 2010 to January 2014.

### Overall Performance

* Total sales are approximately **29.36M**, with **60,423 items sold**.
* Average order value is approximately **1,061**.
* The average order contains roughly **2 order lines**.
* Customers are relatively balanced by gender, with **9,341 male** and **9,128 female** customers.

### Categories & Products

* **Bikes account for approximately 96.5% of total revenue (28.3M)**.
* Accessories represent approximately **2.4%**, while Clothing represents approximately **1.2%**.
* The Components category contains **127 products but no recorded sales** in `fact_sales`.
* Only **130 of 295 products** have recorded sales.
* The top five products are all **Mountain-200** bikes and together account for approximately **22.7% of total sales**.
* The five lowest-selling products generate less than **8,000** each.

### Geographic Performance

* The **United States** has the largest customer base, with approximately **7,482 customers**.
* Australia follows with approximately **3,591 customers**.
* Despite having around half as many customers as the United States, **Australia generates nearly the same revenue: 9.06M vs. 9.16M**.
* This difference highlights the importance of looking beyond customer volume when evaluating market performance.

### Sales Trends

* Sales reached approximately **7.08M in 2011**, **5.84M in 2012**, and **16.34M in 2013**.
* 2012 sales decreased by approximately **17%** compared with 2011.
* 2013 sales increased substantially, reaching approximately **180% growth compared with 2012**.
* December 2013 recorded the highest monthly sales, at approximately **1.87M**.
* Accessories and Clothing began contributing to sales during 2012–2013.
* Active customers increased significantly from **3,255 in 2012 to 17,427 in 2013**.

### Customer Segmentation

* **New customers:** 14,629 (**79%**)
* **Regular customers:** 2,200 (**12%**)
* **VIP customers:** 1,653 (**9%**)

Although VIP customers represent only **9% of the customer base**, they generate approximately **36.7% of total revenue**.

Average spend is approximately:

* **VIP:** 6,510
* **New:** 758

Additionally, approximately **63% of customers have a 0-month lifespan**, indicating that they made purchases within only one month of activity.

## Data Quality Notes

* **19 sales records** have no order date.
* **17 customers** have no birthdate.
* Customer lifespan calculations were reviewed and corrected before customer segmentation.
* 2010 and 2014 contain only partial-year data, so they are excluded from full-year comparisons.

