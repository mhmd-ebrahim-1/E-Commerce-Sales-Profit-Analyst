USE ecommerce_analytics;
GO

-- 14. Year-to-Date (YTD) Profit


WITH monthly_profit AS (
    SELECT 
        year,
        month,
        year_month,
        SUM(profit) AS monthly_profit
    FROM ecommerce_sales
    GROUP BY year, month, year_month
)
SELECT 
    year,
    month,
    year_month,
    monthly_profit,
    SUM(monthly_profit) OVER (
        PARTITION BY year
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ytd_profit
FROM monthly_profit
ORDER BY year, month;
GO
