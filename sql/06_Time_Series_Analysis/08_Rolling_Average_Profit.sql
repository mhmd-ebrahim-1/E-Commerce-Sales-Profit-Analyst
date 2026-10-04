USE ecommerce_analytics;
GO

-- 8. Rolling Average Profit (3-Month Moving Average)


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
    AVG(monthly_profit) OVER (
        ORDER BY year_month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3month_avg_profit
FROM monthly_profit
ORDER BY year_month;
GO
