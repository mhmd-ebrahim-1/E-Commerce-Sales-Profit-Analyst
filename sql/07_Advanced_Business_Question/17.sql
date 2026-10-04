USE ecommerce_analytics;
GO

-- QUESTION 17: Which shipping mode is most popular?

WITH ShipModeSummary AS
(
    SELECT
        ship_mode,
        COUNT(DISTINCT order_id) AS order_count
    FROM dbo.ecommerce_sales
    GROUP BY ship_mode
)
SELECT TOP 1
    'Most Popular Ship Mode' AS question,
    ship_mode AS answer,
    order_count,
    CAST(
        order_count * 100.0 /
        SUM(order_count) OVER ()
        AS DECIMAL(10,2)
    ) AS percentage
FROM ShipModeSummary
ORDER BY order_count DESC;
GO