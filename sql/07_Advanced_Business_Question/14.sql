USE ecommerce_analytics;
GO

-- QUESTION 14: What is the monthly growth rate?


WITH monthly_sales AS (
    SELECT 
        year_month,
        SUM(sales) AS monthly_sales
    FROM ecommerce_sales
    GROUP BY year_month
)
SELECT 
    'Monthly Growth Rate' AS question,
    year_month AS period,
    (monthly_sales - LAG(monthly_sales) OVER (ORDER BY year_month)) / 
        LAG(monthly_sales) OVER (ORDER BY year_month) * 100 AS growth_rate_pct
FROM monthly_sales
ORDER BY year_month;
GO