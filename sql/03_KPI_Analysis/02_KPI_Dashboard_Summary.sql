
USE ecommerce_analytics;
GO

-- KPI Dashboard Summary

SELECT 
    'Total Sales' AS metric,
    '$' + FORMAT(SUM(sales), 'N2') AS value
FROM ecommerce_sales

UNION ALL

SELECT 
    'Total Profit',
    '$' + FORMAT(SUM(profit), 'N2')
FROM ecommerce_sales

UNION ALL

SELECT 
    'Profit Margin',
    FORMAT((SUM(profit) / SUM(sales)) * 100, 'N2') + '%'
FROM ecommerce_sales

UNION ALL

SELECT 
    'Total Orders',
    FORMAT(COUNT(DISTINCT order_id), 'N0')
FROM ecommerce_sales

UNION ALL

SELECT 
    'Total Customers',
    FORMAT(COUNT(DISTINCT customer_id), 'N0')
FROM ecommerce_sales

UNION ALL

SELECT 
    'Total Quantity',
    FORMAT(SUM(quantity), 'N0')
FROM ecommerce_sales

UNION ALL

SELECT 
    'Average Order Value',
    '$' + FORMAT(SUM(sales) / COUNT(DISTINCT order_id), 'N2')
FROM ecommerce_sales

UNION ALL

SELECT 
    'Average Discount',
    FORMAT(AVG(discount) * 100, 'N2') + '%'
FROM ecommerce_sales;
GO