USE ecommerce_analytics;
GO

-- 7. Rolling Average Sales (3-Month Moving Average)


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
    AVG(monthly_sales) OVER (
        ORDER BY year_month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3month_avg_sales
FROM monthly_sales
ORDER BY year_month;
GO
