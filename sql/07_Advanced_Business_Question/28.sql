USE ecommerce_analytics;
GO

-- QUESTION 28: What is the profit contribution by region?

WITH RegionalProfit AS
(
    SELECT
        region,
        SUM(profit) AS total_profit
    FROM dbo.ecommerce_sales
    GROUP BY region
)
SELECT
    'Regional Profit Contribution' AS question,
    region AS answer,
    CAST(total_profit AS DECIMAL(18,2)) AS total_profit,
    CAST(
        total_profit * 100.0 /
        SUM(total_profit) OVER ()
        AS DECIMAL(10,2)
    ) AS profit_contribution_pct
FROM RegionalProfit
ORDER BY total_profit DESC;
GO