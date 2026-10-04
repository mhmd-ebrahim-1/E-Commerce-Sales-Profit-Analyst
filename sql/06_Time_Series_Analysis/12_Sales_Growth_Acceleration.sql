USE ecommerce_analytics;
GO

-- 12. Sales Growth Acceleration (Month-over-Month Change in Growth Rate)


WITH monthly_data AS (
    SELECT 
        year_month,
        SUM(sales) AS monthly_sales
    FROM ecommerce_sales
    GROUP BY year_month
),
growth_rates AS (
    SELECT 
        year_month,
        monthly_sales,
        (monthly_sales - LAG(monthly_sales) OVER (ORDER BY year_month)) / 
            LAG(monthly_sales) OVER (ORDER BY year_month) * 100 AS mom_growth_pct
    FROM monthly_data
)
SELECT 
    year_month,
    monthly_sales,
    mom_growth_pct,
    mom_growth_pct - LAG(mom_growth_pct) OVER (ORDER BY year_month) AS growth_acceleration_pct
FROM growth_rates
ORDER BY year_month;
GO
