USE ecommerce_analytics;
GO

-- 9. Day of Week Analysis


SELECT 
    day_of_week,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    AVG(sales) AS avg_order_value
FROM ecommerce_sales
GROUP BY day_of_week
ORDER BY 
    CASE day_of_week
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
        WHEN 'Sunday' THEN 7
    END;
GO
