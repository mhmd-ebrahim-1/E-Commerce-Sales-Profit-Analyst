USE ecommerce_analytics;
GO

--  11. KPI SUMMARY VIEW

CREATE VIEW dbo.v_kpi_summary
AS
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity,
    CAST(
        SUM(sales) /
        NULLIF(COUNT(DISTINCT order_id), 0)
        AS DECIMAL(15,2)
    ) AS avg_order_value, -- Average Order Value

    CAST(
        AVG(discount)
        AS DECIMAL(10,2)
    ) AS avg_discount, -- Average discount

    CAST(
        SUM(profit) * 100.0 /
        NULLIF(SUM(sales), 0)
        AS DECIMAL(10,2)
    ) AS profit_margin_pct  -- Profit Margin

FROM dbo.ecommerce_sales;
GO


-- 12. MONTHLY TRENDS VIEW

CREATE VIEW dbo.v_monthly_trends
AS
SELECT
    year_month,
    [year],
    [month],
    month_name,
    SUM(sales) AS monthly_sales,
    SUM(profit) AS monthly_profit,
    COUNT(DISTINCT order_id) AS monthly_orders,

    CAST(
        SUM(profit) * 100.0 /
        NULLIF(SUM(sales), 0)
        AS DECIMAL(10,2)
    ) AS monthly_profit_margin

FROM dbo.ecommerce_sales

GROUP BY
    year_month,
    [year],
    [month],
    month_name;
GO

-- 13. CATEGORY PERFORMANCE VIEW

CREATE VIEW dbo.v_category_performance
AS
SELECT
    category,

    SUM(sales) AS total_sales,

    SUM(profit) AS total_profit,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(quantity) AS total_quantity,

    CAST(
        SUM(profit) * 100.0 /
        NULLIF(SUM(sales), 0)
        AS DECIMAL(10,2)
    ) AS profit_margin_pct

FROM dbo.ecommerce_sales

GROUP BY category;
GO


-- 14. REGIONAL PERFORMANCE VIEW

CREATE VIEW dbo.v_regional_performance
AS
SELECT
    region,
    state,

    SUM(sales) AS total_sales,

    SUM(profit) AS total_profit,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(quantity) AS total_quantity,

    CAST(
        SUM(profit) * 100.0 /
        NULLIF(SUM(sales), 0)
        AS DECIMAL(10,2)
    ) AS profit_margin_pct

FROM dbo.ecommerce_sales

GROUP BY
    region,
    state;
GO