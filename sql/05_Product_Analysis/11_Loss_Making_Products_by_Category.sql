USE ecommerce_analytics;
GO

-- 11. Loss-Making Products by Category


WITH product_profit AS (
    SELECT 
        category,
        product_id,
        SUM(profit) AS total_profit
    FROM ecommerce_sales
    GROUP BY category, product_id
)
SELECT 
    category,
    COUNT(DISTINCT product_id) AS total_products,
    COUNT(DISTINCT CASE WHEN total_profit < 0 THEN product_id END) AS loss_making_products,
    (COUNT(DISTINCT CASE WHEN total_profit < 0 THEN product_id END) * 100.0 / 
     COUNT(DISTINCT product_id)) AS loss_product_percentage,
    SUM(CASE WHEN total_profit < 0 THEN total_profit ELSE 0 END) AS total_loss
FROM product_profit
GROUP BY category
ORDER BY total_loss;
GO
