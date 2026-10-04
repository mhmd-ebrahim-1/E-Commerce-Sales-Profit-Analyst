USE ecommerce_analytics;
GO

-- 4. Date Transformations

-- Extract date components (if not already done)
SELECT TOP 10
    order_date,
    YEAR(order_date) AS year,
    DATEPART(quarter, order_date) AS quarter,
    MONTH(order_date) AS month,
    DATENAME(month, order_date) AS month_name,
    DATEPART(week, order_date) AS week,
    DATENAME(weekday, order_date) AS day_of_week
FROM ecommerce_sales;
GO

-- Calculate Order-to-Ship Days
SELECT TOP 10
    order_id,
    order_date,
    ship_date,
    DATEDIFF(day, order_date, ship_date) AS order_to_ship_days
FROM ecommerce_sales
WHERE DATEDIFF(day, order_date, ship_date) < 0;
GO