
USE ecommerce_analytics;
GO

-- Core KPIs

-- 1. Total Sales
SELECT 
    'Total Sales' AS kpi_name,
    SUM(sales) AS value,
    '$' AS currency
FROM ecommerce_sales;
GO

-- 2. Total Profit
SELECT 
    'Total Profit' AS kpi_name,
    SUM(profit) AS value,
    '$' AS currency
FROM ecommerce_sales;
GO

-- 3. Profit Margin
SELECT 
    'Profit Margin' AS kpi_name,
    (SUM(profit) / SUM(sales)) * 100 AS value,
    '%' AS unit
FROM ecommerce_sales;
GO

-- 4. Total Orders
SELECT 
    'Total Orders' AS kpi_name,
    COUNT(DISTINCT order_id) AS value,
    'orders' AS unit
FROM ecommerce_sales;
GO

-- 5. Total Customers
SELECT 
    'Total Customers' AS kpi_name,
    COUNT(DISTINCT customer_id) AS value,
    'customers' AS unit
FROM ecommerce_sales;
GO

-- 6. Total Quantity Sold
SELECT 
    'Total Quantity' AS kpi_name,
    SUM(quantity) AS value,
    'units' AS unit
FROM ecommerce_sales;
GO

-- 7. Average Order Value (AOV)
SELECT 
    'Average Order Value' AS kpi_name,
    SUM(sales) / COUNT(DISTINCT order_id) AS value,
    '$' AS currency
FROM ecommerce_sales;
GO

-- 8. Average Discount
SELECT 
    'Average Discount' AS kpi_name,
    AVG(discount) * 100 AS value,
    '%' AS unit
FROM ecommerce_sales;
GO

-- 9. Average Profit per Order
SELECT 
    'Average Profit per Order' AS kpi_name,
    SUM(profit) / COUNT(DISTINCT order_id) AS value,
    '$' AS currency
FROM ecommerce_sales;
GO

-- 10. Average Quantity per Order
SELECT 
    'Average Quantity per Order' AS kpi_name,
    SUM(quantity) / COUNT(DISTINCT order_id) AS value,
    'units' AS unit
FROM ecommerce_sales;
GO