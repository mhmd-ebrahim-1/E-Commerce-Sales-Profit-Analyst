USE ecommerce_analytics;
GO

-- Comprehensive KPI Report

SELECT 
    'REVENUE METRICS' AS metric_category,
    'Total Sales' AS metric_name,
    '$' + FORMAT(SUM(sales), 'N2') AS metric_value
FROM ecommerce_sales

UNION ALL

SELECT 
    'REVENUE METRICS',
    'Total Profit',
    '$' + FORMAT(SUM(profit), 'N2')
FROM ecommerce_sales

UNION ALL

SELECT 
    'REVENUE METRICS',
    'Profit Margin',
    FORMAT(
        SUM(profit) * 100.0 / NULLIF(SUM(sales), 0),
        'N2'
    ) + '%'
FROM ecommerce_sales

UNION ALL

SELECT 
    'ORDER METRICS',
    'Total Orders',
    FORMAT(COUNT(DISTINCT order_id), 'N0')
FROM ecommerce_sales

UNION ALL

SELECT 
    'ORDER METRICS',
    'Average Order Value',
    '$' + FORMAT(
        SUM(sales) / NULLIF(COUNT(DISTINCT order_id), 0),
        'N2'
    )
FROM ecommerce_sales

UNION ALL

SELECT 
    'ORDER METRICS',
    'Average Quantity per Order',
    FORMAT(
        SUM(quantity) * 1.0 / NULLIF(COUNT(DISTINCT order_id), 0),
        'N2'
    )
FROM ecommerce_sales

UNION ALL

SELECT 
    'CUSTOMER METRICS',
    'Total Customers',
    FORMAT(COUNT(DISTINCT customer_id), 'N0')
FROM ecommerce_sales

UNION ALL

SELECT 
    'CUSTOMER METRICS',
    'Average Revenue per Customer',
    '$' + FORMAT(
        SUM(sales) / NULLIF(COUNT(DISTINCT customer_id), 0),
        'N2'
    )
FROM ecommerce_sales

UNION ALL

SELECT 
    'CUSTOMER METRICS',
    'Average Orders per Customer',
    FORMAT(
        COUNT(DISTINCT order_id) * 1.0 /
        NULLIF(COUNT(DISTINCT customer_id), 0),
        'N2'
    )
FROM ecommerce_sales

UNION ALL

SELECT 
    'PRODUCT METRICS',
    'Total Quantity Sold',
    FORMAT(SUM(quantity), 'N0')
FROM ecommerce_sales

UNION ALL

SELECT 
    'PRODUCT METRICS',
    'Average Discount',
    FORMAT(AVG(discount) * 100, 'N2') + '%'
FROM ecommerce_sales

UNION ALL

SELECT 
    'PRODUCT METRICS',
    'Average Sales per Unit',
    '$' + FORMAT(
        SUM(sales) / NULLIF(SUM(quantity), 0),
        'N2'
    )
FROM ecommerce_sales

UNION ALL

SELECT 
    'LOSS METRICS',
    'Loss-Making Transactions',
    FORMAT(
        SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END),
        'N0'
    )
FROM ecommerce_sales

UNION ALL

SELECT 
    'LOSS METRICS',
    'Total Loss Amount',
    '$' + FORMAT(
        SUM(CASE WHEN profit < 0 THEN profit ELSE 0 END),
        'N2'
    )
FROM ecommerce_sales

UNION ALL

SELECT 
    'LOSS METRICS',
    'Loss Percentage',
    FORMAT(
        SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) * 100.0 /
        NULLIF(COUNT(*), 0),
        'N2'
    ) + '%'
FROM ecommerce_sales

ORDER BY metric_category, metric_name;
GO