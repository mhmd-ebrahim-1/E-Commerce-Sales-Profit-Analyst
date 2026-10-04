USE ecommerce_analytics;
GO

-- QUESTION 15: Which products have high sales but low profit?


SELECT TOP 10
    'High Sales Low Profit Products' AS question,
    product_name AS answer,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct
FROM ecommerce_sales
GROUP BY product_name
HAVING SUM(sales) > 1000 AND (SUM(profit) / SUM(sales)) * 100 < 5
ORDER BY total_sales DESC;
GO
