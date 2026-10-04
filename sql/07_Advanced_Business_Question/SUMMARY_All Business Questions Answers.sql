USE ecommerce_analytics;
GO

-- Product metrics
WITH product_metrics AS (
    SELECT
        product_id,
        product_name,
        category,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        SUM(quantity) AS total_quantity
    FROM ecommerce_sales
    GROUP BY
        product_id,
        product_name,
        category
),

-- Customer metrics
customer_metrics AS (
    SELECT
        customer_id,
        customer_name,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        SUM(profit) * 100.0 /
            NULLIF(SUM(sales), 0) AS profit_margin
    FROM ecommerce_sales
    GROUP BY
        customer_id,
        customer_name
),

-- Order metrics
order_metrics AS (
    SELECT
        order_id,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit
    FROM ecommerce_sales
    GROUP BY order_id
),

-- Monthly metrics
monthly_metrics AS (
    SELECT
        year,
        month,
        month_name,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit
    FROM ecommerce_sales
    GROUP BY
        year,
        month,
        month_name
),

-- Monthly growth
monthly_growth AS (
    SELECT
        year,
        month,
        total_sales,
        total_profit,
        LAG(total_sales) OVER (
            ORDER BY year, month
        ) AS previous_month_sales
    FROM monthly_metrics
),

-- Sub-category metrics
subcategory_metrics AS (
    SELECT
        sub_category,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        SUM(profit) * 100.0 /
            NULLIF(SUM(sales), 0) AS profit_margin
    FROM ecommerce_sales
    GROUP BY sub_category
),

-- City metrics
city_metrics AS (
    SELECT
        city,
        SUM(sales) AS total_sales
    FROM ecommerce_sales
    GROUP BY city
),

-- Region metrics
region_metrics AS (
    SELECT
        region,
        SUM(profit) AS total_profit
    FROM ecommerce_sales
    GROUP BY region
),

-- Quarter metrics
quarter_metrics AS (
    SELECT
        year,
        quarter,
        SUM(sales) AS total_sales
    FROM ecommerce_sales
    GROUP BY
        year,
        quarter
),

-- Customer years
customer_years AS (
    SELECT
        customer_id,
        COUNT(DISTINCT YEAR(order_date)) AS years_purchased
    FROM ecommerce_sales
    GROUP BY customer_id
),

-- Correlation data
correlation_data AS (
    SELECT
        discount,
        sales,
        AVG(discount) OVER () AS avg_discount,
        AVG(sales) OVER () AS avg_sales
    FROM ecommerce_sales
),

-- Correlation result
correlation_result AS (
    SELECT
        CASE
            WHEN SUM(
                (discount - avg_discount) *
                (sales - avg_sales)
            ) > 0
                THEN 'Positive'

            WHEN SUM(
                (discount - avg_discount) *
                (sales - avg_sales)
            ) < 0
                THEN 'Negative'

            ELSE 'Weak / No Relationship'
        END AS relationship
    FROM correlation_data
),

-- Product margins
product_margin AS (
    SELECT
        product_id,
        product_name,
        total_sales,
        total_profit,
        total_profit * 100.0 /
            NULLIF(total_sales, 0) AS profit_margin
    FROM product_metrics
),

-- Overall metrics
overall_metrics AS (
    SELECT
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        SUM(profit) * 100.0 /
            NULLIF(SUM(sales), 0) AS profit_margin,
        AVG(discount) * 100 AS average_discount,
        SUM(sales) /
            NULLIF(COUNT(DISTINCT order_id), 0) AS average_order_value,
        AVG(order_to_ship_days) AS average_shipping_days
    FROM ecommerce_sales
),

-- Loss-making products
product_loss AS (
    SELECT
        COUNT(*) AS loss_product_count
    FROM product_metrics
    WHERE total_profit < 0
),

-- Loss-making states
state_loss AS (
    SELECT
        COUNT(*) AS loss_state_count
    FROM (
        SELECT state
        FROM ecommerce_sales
        GROUP BY state
        HAVING SUM(profit) < 0
    ) AS states
),

-- Customer retention
retention_metrics AS (
    SELECT
        SUM(
            CASE
                WHEN years_purchased > 1 THEN 1
                ELSE 0
            END
        ) * 100.0 /
            NULLIF(COUNT(*), 0) AS retention_rate
    FROM customer_years
),

-- Final answers
answers AS (

    -- Q1
    SELECT
        1 AS sort_order,
        'Total Revenue' AS question,
        '$' + FORMAT(total_sales, 'N2') AS answer
    FROM overall_metrics

    UNION ALL

    -- Q2
    SELECT
        2,
        'Total Profit',
        '$' + FORMAT(total_profit, 'N2')
    FROM overall_metrics

    UNION ALL

    -- Q3
    SELECT
        3,
        'Overall Profit Margin',
        FORMAT(profit_margin, 'N2') + '%'
    FROM overall_metrics

    UNION ALL

    -- Q4
    SELECT TOP 1
        4,
        'Top Revenue Category',
        category
    FROM ecommerce_sales
    GROUP BY category
    ORDER BY SUM(sales) DESC

    UNION ALL

    -- Q5
    SELECT TOP 1
        5,
        'Top Profit Category',
        category
    FROM ecommerce_sales
    GROUP BY category
    ORDER BY SUM(profit) DESC

    UNION ALL

    -- Q6
    SELECT
        6,
        'Loss-Making Products Count',
        FORMAT(loss_product_count, 'N0')
    FROM product_loss

    UNION ALL

    -- Q7
    SELECT TOP 1
        7,
        'Top Customer',
        customer_name
    FROM customer_metrics
    ORDER BY total_sales DESC

    UNION ALL

    -- Q8
    SELECT TOP 1
        8,
        'Most Profitable Region',
        region
    FROM region_metrics
    ORDER BY total_profit DESC

    UNION ALL

    -- Q9
    SELECT
        9,
        'States with Negative Profit',
        FORMAT(loss_state_count, 'N0')
    FROM state_loss

    UNION ALL

    -- Q10
    SELECT
        10,
        'Discount vs Profit',
        CASE
            WHEN AVG(
                CASE
                    WHEN discount = 0 THEN profit
                END
            ) >
            AVG(
                CASE
                    WHEN discount > 0 THEN profit
                END
            )
            THEN 'No Discount has Higher Average Profit'
            ELSE 'Discounted Sales have Higher Average Profit'
        END
    FROM ecommerce_sales

    UNION ALL

    -- Q11
    SELECT TOP 1
        11,
        'Top Product by Sales',
        product_name
    FROM product_metrics
    ORDER BY total_sales DESC

    UNION ALL

    -- Q12
    SELECT TOP 1
        12,
        'Bottom Product by Profit',
        product_name
    FROM product_metrics
    ORDER BY total_profit ASC

    UNION ALL

    -- Q13
    SELECT TOP 1
        13,
        'Most Profitable Segment',
        segment
    FROM ecommerce_sales
    GROUP BY segment
    ORDER BY SUM(profit) DESC

    UNION ALL

    -- Q14
    SELECT TOP 1
        14,
        'Highest Monthly Sales Growth',
        FORMAT(
            (total_sales - previous_month_sales) * 100.0 /
                NULLIF(previous_month_sales, 0),
            'N2'
        ) + '%'
    FROM monthly_growth
    WHERE previous_month_sales IS NOT NULL
    ORDER BY
        (total_sales - previous_month_sales) * 100.0 /
            NULLIF(previous_month_sales, 0) DESC

    UNION ALL

    -- Q15
    SELECT TOP 1
        15,
        'High Sales Low Profit Product',
        product_name
    FROM product_margin
    WHERE total_sales >= (
        SELECT AVG(total_sales)
        FROM product_margin
    )
    ORDER BY profit_margin ASC

    UNION ALL

    -- Q16
    SELECT
        16,
        'Average Order Value',
        '$' + FORMAT(average_order_value, 'N2')
    FROM overall_metrics

    UNION ALL

    -- Q17
    SELECT TOP 1
        17,
        'Most Popular Ship Mode',
        ship_mode
    FROM ecommerce_sales
    GROUP BY ship_mode
    ORDER BY COUNT(DISTINCT order_id) DESC

    UNION ALL

    -- Q18
    SELECT
        18,
        'Average Shipping Time',
        FORMAT(average_shipping_days, 'N1') + ' days'
    FROM overall_metrics

    UNION ALL

    -- Q19
    SELECT TOP 1
        19,
        'Highest Profit Margin Sub-Category',
        sub_category
    FROM subcategory_metrics
    ORDER BY profit_margin DESC

    UNION ALL

    -- Q20
    SELECT
        20,
        'Loss-Making Order Percentage',
        FORMAT(
            SUM(
                CASE
                    WHEN total_profit < 0 THEN 1
                    ELSE 0
                END
            ) * 100.0 /
                NULLIF(COUNT(*), 0),
            'N2'
        ) + '%'
    FROM order_metrics

    UNION ALL

    -- Q21
    SELECT TOP 1
        21,
        'Highest Sales City',
        city
    FROM city_metrics
    ORDER BY total_sales DESC

    UNION ALL

    -- Q22
    SELECT
        22,
        'Discount vs Sales Relationship',
        relationship
    FROM correlation_result

    UNION ALL

    -- Q23
    SELECT TOP 1
        23,
        'Most Frequently Ordered Product',
        product_name
    FROM ecommerce_sales
    GROUP BY
        product_id,
        product_name
    ORDER BY COUNT(DISTINCT order_id) DESC

    UNION ALL

    -- Q24
    SELECT
        24,
        'Customer Retention Rate',
        FORMAT(retention_rate, 'N2') + '%'
    FROM retention_metrics

    UNION ALL

    -- Q25
    SELECT TOP 1
        25,
        'Highest Sales Quarter',
        'Q' + CAST(quarter AS VARCHAR(1))
    FROM quarter_metrics
    ORDER BY total_sales DESC

    UNION ALL

    -- Q26
    SELECT
        26,
        'Average Discount',
        FORMAT(average_discount, 'N2') + '%'
    FROM overall_metrics

    UNION ALL

    -- Q27
    SELECT TOP 1
        27,
        'Highest Quantity Product',
        product_name
    FROM product_metrics
    ORDER BY total_quantity DESC

    UNION ALL

    -- Q28
    SELECT TOP 1
        28,
        'Highest Regional Profit Contribution',
        region
    FROM region_metrics
    ORDER BY total_profit DESC

    UNION ALL

    -- Q29
    SELECT TOP 1
        29,
        'Highest Profit Margin Customer',
        customer_name
    FROM customer_metrics
    WHERE total_sales > 0
    ORDER BY profit_margin DESC

    UNION ALL

    -- Q30
    SELECT TOP 1
        30,
        'Highest Monthly Profit Margin',
        FORMAT(
            total_profit * 100.0 /
                NULLIF(total_sales, 0),
            'N2'
        ) + '%'
    FROM monthly_metrics
    ORDER BY
        total_profit * 100.0 /
            NULLIF(total_sales, 0) DESC
)

-- Final output
SELECT
    question,
    answer
FROM answers
ORDER BY sort_order;

GO