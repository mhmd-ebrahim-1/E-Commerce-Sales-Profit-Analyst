USE ecommerce_analytics;
GO

-- 17. Product Performance Summary Report

SELECT 
    'PRODUCT PERFORMANCE SUMMARY' AS report_section,
    category AS dimension,
    COUNT(DISTINCT product_id) AS metric_value,
    'Unique Products' AS metric_name
FROM dbo.ecommerce_sales
GROUP BY category

UNION ALL

SELECT 
    'PRODUCT PERFORMANCE SUMMARY',
    category,
    SUM(sales) AS metric_value,
    'Total Sales ($)' AS metric_name
FROM dbo.ecommerce_sales
GROUP BY category

UNION ALL

SELECT 
    'PRODUCT PERFORMANCE SUMMARY',
    category,
    SUM(profit) AS metric_value,
    'Total Profit ($)' AS metric_name
FROM dbo.ecommerce_sales
GROUP BY category

UNION ALL

SELECT 
    'PRODUCT PERFORMANCE SUMMARY',
    category,
    CASE 
        WHEN SUM(sales) = 0 THEN 0
        ELSE (SUM(profit) / SUM(sales)) * 100
    END AS metric_value,
    'Profit Margin (%)' AS metric_name
FROM dbo.ecommerce_sales
GROUP BY category

UNION ALL

SELECT 
    'PRODUCT PERFORMANCE SUMMARY',
    category,
    SUM(quantity) AS metric_value,
    'Total Quantity Sold' AS metric_name
FROM dbo.ecommerce_sales
GROUP BY category

ORDER BY 
    dimension,
    metric_name;
GO