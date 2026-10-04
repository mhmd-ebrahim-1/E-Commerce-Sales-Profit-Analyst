USE ecommerce_analytics;
GO

-- 13. Seasonal Product Analysis (by Quarter)


SELECT 
    category,
    quarter,
    SUM(sales) AS quarterly_sales,
    SUM(profit) AS quarterly_profit,
    COUNT(DISTINCT product_id) AS products_sold,
    SUM(quantity) AS total_quantity
FROM ecommerce_sales
GROUP BY category, quarter
ORDER BY category, quarter;
GO