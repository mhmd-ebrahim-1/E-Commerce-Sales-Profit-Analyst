USE ecommerce_analytics;
GO

-- QUESTION 13: Which customer segment is most profitable?


SELECT TOP 1
    'Most Profitable Segment' AS question,
    segment AS answer,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct
FROM ecommerce_sales
GROUP BY segment
ORDER BY total_profit DESC;
GO