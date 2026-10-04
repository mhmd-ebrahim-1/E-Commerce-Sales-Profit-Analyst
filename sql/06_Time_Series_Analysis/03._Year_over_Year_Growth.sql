USE ecommerce_analytics;
GO

-- 3. Year-over-Year Growth (Using CTE and Window Functions)


WITH yearly_data AS (
    SELECT 
        year,
        SUM(sales) AS yearly_sales,
        SUM(profit) AS yearly_profit,
        COUNT(DISTINCT order_id) AS yearly_orders
    FROM ecommerce_sales
    GROUP BY year
)
SELECT 
    year,
    yearly_sales,
    yearly_profit,
    yearly_orders,
    LAG(yearly_sales) OVER (ORDER BY year) AS prev_year_sales,
    LAG(yearly_profit) OVER (ORDER BY year) AS prev_year_profit,
    (yearly_sales - LAG(yearly_sales) OVER (ORDER BY year)) / 
        LAG(yearly_sales) OVER (ORDER BY year) * 100 AS sales_yoy_growth_pct,
    (yearly_profit - LAG(yearly_profit) OVER (ORDER BY year)) / 
        LAG(yearly_profit) OVER (ORDER BY year) * 100 AS profit_yoy_growth_pct
FROM yearly_data
ORDER BY year;
GO
