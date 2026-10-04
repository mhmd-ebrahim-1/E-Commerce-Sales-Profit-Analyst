USE ecommerce_analytics;
GO

-- KPIs by Ship Mode

SELECT 
    ship_mode,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders,
    AVG(DATEDIFF(day, order_date, ship_date)) AS avg_shipping_days
FROM ecommerce_sales
GROUP BY ship_mode
ORDER BY total_sales DESC;
GO
