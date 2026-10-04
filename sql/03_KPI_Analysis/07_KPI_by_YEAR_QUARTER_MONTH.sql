USE ecommerce_analytics;
GO

-- KPIs by Year

SELECT 
    year,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_quantity
FROM ecommerce_sales
GROUP BY year
ORDER BY year;
GO

-- KPIs by Quarter

SELECT 
    year,
    quarter,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders
FROM ecommerce_sales
GROUP BY year, quarter
ORDER BY year, quarter;
GO

-- KPIs by Month

SELECT 
    year,
    month,
    month_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders
FROM ecommerce_sales
GROUP BY year, month, month_name
ORDER BY year, month;
GO