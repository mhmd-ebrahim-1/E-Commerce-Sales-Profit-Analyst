USE ecommerce_analytics;
GO

-- 13. Year-to-Date (YTD) Sales


WITH monthly_sales AS (
    SELECT 
        year,
        month,
        year_month,
        SUM(sales) AS monthly_sales
    FROM ecommerce_sales
    GROUP BY year, month, year_month
)
SELECT 
    year,
    month,
    year_month,
    monthly_sales,
    SUM(monthly_sales) OVER (
        PARTITION BY year
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ytd_sales
FROM monthly_sales
ORDER BY year, month;
GO
