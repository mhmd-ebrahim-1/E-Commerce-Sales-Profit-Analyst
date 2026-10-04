USE ecommerce_analytics;
GO

-- 16. Product Return Analysis (Negative Profit as Proxy)


SELECT 
    category,
    sub_category,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_transactions,
    (SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS loss_transaction_pct,
    SUM(CASE WHEN profit < 0 THEN profit ELSE 0 END) AS total_loss,
    SUM(CASE WHEN profit < 0 THEN sales ELSE 0 END) AS sales_from_losses
FROM ecommerce_sales
GROUP BY category, sub_category
ORDER BY loss_transaction_pct DESC;
GO
