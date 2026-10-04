USE ecommerce_analytics;
GO

-- 2. Month-over-Month Growth (Using CTE and Window Functions)


WITH monthly_data AS (
    SELECT 
        year,
        month,
        month_name,
        year_month,
        SUM(sales) AS monthly_sales,
        SUM(profit) AS monthly_profit,
        COUNT(DISTINCT order_id) AS monthly_orders
    FROM ecommerce_sales
    GROUP BY year, month, month_name, year_month
)
SELECT 
    year,
    month,
    month_name,
    year_month,
    monthly_sales,
    monthly_profit,
    monthly_orders,
    LAG(monthly_sales) OVER (ORDER BY year_month) AS prev_month_sales,
    LAG(monthly_profit) OVER (ORDER BY year_month) AS prev_month_profit,
    (monthly_sales - LAG(monthly_sales) OVER (ORDER BY year_month)) / 
        LAG(monthly_sales) OVER (ORDER BY year_month) * 100 AS sales_mom_growth_pct,
    (monthly_profit - LAG(monthly_profit) OVER (ORDER BY year_month)) / 
        LAG(monthly_profit) OVER (ORDER BY year_month) * 100 AS profit_mom_growth_pct
FROM monthly_data
ORDER BY year, month;
GO
