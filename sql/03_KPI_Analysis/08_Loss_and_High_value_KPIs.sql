USE ecommerce_analytics;
GO


-- Loss-Making KPIs

-- Loss-making transactions
SELECT 
    COUNT(*) AS loss_making_transactions,
    SUM(profit) AS total_loss,
    AVG(profit) AS avg_loss_per_transaction,
    SUM(sales) AS sales_from_loss_transactions,
    (COUNT(*) * 100.0 / 
        NULLIF((SELECT COUNT(*) FROM ecommerce_sales), 0)
    ) AS percentage_of_total_transactions
FROM ecommerce_sales
WHERE profit < 0;
GO

-- Loss-making by Category
SELECT 
    category,
    COUNT(*) AS loss_transactions,
    SUM(profit) AS total_loss,
    SUM(sales) AS sales_from_losses,
    (SUM(profit) * 100.0 / 
        NULLIF(SUM(sales), 0)
    ) AS loss_margin_pct
FROM ecommerce_sales
WHERE profit < 0
GROUP BY category
ORDER BY total_loss ASC;
GO

-- High-Value KPIs

-- Orders above $1000
WITH order_summary AS (
    SELECT
        order_id,
        SUM(sales) AS order_sales,
        SUM(profit) AS order_profit
    FROM ecommerce_sales
    GROUP BY order_id
)
SELECT 
    COUNT(*) AS high_value_orders,
    SUM(order_sales) AS high_value_sales,
    SUM(order_profit) AS high_value_profit,
    (SUM(order_sales) * 100.0 /
        NULLIF(
            (SELECT SUM(sales) FROM ecommerce_sales),
            0
        )
    ) AS percentage_of_total_sales
FROM order_summary
WHERE order_sales > 1000;
GO