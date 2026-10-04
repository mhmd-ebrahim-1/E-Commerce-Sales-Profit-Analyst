USE ecommerce_analytics;
GO

-- 15. Time Series Summary Report


WITH yearly_summary AS (
    SELECT 
        year,
        SUM(sales) AS yearly_sales,
        SUM(profit) AS yearly_profit,
        COUNT(DISTINCT order_id) AS yearly_orders
    FROM ecommerce_sales
    GROUP BY year
),
monthly_summary AS (
    SELECT 
        year,
        month,
        month_name,
        SUM(sales) AS monthly_sales,
        SUM(profit) AS monthly_profit
    FROM ecommerce_sales
    GROUP BY year, month, month_name
)
SELECT 
    'Yearly Summary' AS summary_type,
    CAST(year AS VARCHAR(10)) AS period,
    '$' + FORMAT(yearly_sales, 'N2') AS sales,
    '$' + FORMAT(yearly_profit, 'N2') AS profit,
    FORMAT(yearly_orders, 'N0') AS orders
FROM yearly_summary

UNION ALL

SELECT 
    'Monthly Average',
    'All Months',
    '$' + FORMAT(AVG(monthly_sales), 'N2'),
    '$' + FORMAT(AVG(monthly_profit), 'N2'),
    FORMAT(AVG(monthly_sales) / NULLIF(AVG(monthly_sales), 0), 'N0')
FROM monthly_summary

ORDER BY summary_type, period;
GO
