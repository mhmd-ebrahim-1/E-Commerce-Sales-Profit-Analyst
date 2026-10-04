USE ecommerce_analytics;
GO

-- 5. Running Total Sales (Cumulative Sum)


WITH monthly_sales AS (
    SELECT 
        year_month,
        SUM(sales) AS monthly_sales
    FROM ecommerce_sales
    GROUP BY year_month
)
SELECT 
    year_month,
    monthly_sales,
    SUM(monthly_sales) OVER (ORDER BY year_month) AS running_total_sales,
    SUM(monthly_sales) OVER (ORDER BY year_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_sales_alt
FROM monthly_sales
ORDER BY year_month;
GO
