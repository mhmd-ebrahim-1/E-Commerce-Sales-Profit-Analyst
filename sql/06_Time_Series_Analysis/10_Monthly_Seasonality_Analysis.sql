USE ecommerce_analytics;
GO

-- 10. Monthly Seasonality Analysis (Average by Month Across Years)


WITH monthly_orders AS (
    SELECT 
        month,
        month_name,
        COUNT(DISTINCT order_id) AS monthly_orders
    FROM ecommerce_sales
    GROUP BY month, month_name
)
SELECT 
    mo.month,
    mo.month_name,
    AVG(es.sales) AS avg_monthly_sales,
    AVG(es.profit) AS avg_monthly_profit,
    AVG((es.profit / es.sales) * 100) AS avg_profit_margin_pct,
    AVG(mo.monthly_orders) AS avg_monthly_orders
FROM ecommerce_sales es
JOIN monthly_orders mo ON es.month = mo.month AND es.month_name = mo.month_name
GROUP BY mo.month, mo.month_name
ORDER BY mo.month;
GO
