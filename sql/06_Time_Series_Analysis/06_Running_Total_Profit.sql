USE ecommerce_analytics;
GO

-- 6. Running Total Profit


WITH monthly_profit AS (
    SELECT 
        year_month,
        SUM(profit) AS monthly_profit
    FROM ecommerce_sales
    GROUP BY year_month
)
SELECT 
    year_month,
    monthly_profit,
    SUM(monthly_profit) OVER (ORDER BY year_month) AS running_total_profit
FROM monthly_profit
ORDER BY year_month;
GO
