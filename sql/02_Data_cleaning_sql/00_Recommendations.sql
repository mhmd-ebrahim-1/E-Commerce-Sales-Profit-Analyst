/* 

    DATA CLEANING RECOMMENDATIONS:

1. NULL Values:
    - Check critical columns (order_id, order_date, customer_id, sales, profit)
    - If NULLs found, either:
        a) Remove records with NULLs in critical columns
        b) Impute with appropriate values (mean, median, default)
        c) Remove the column if not needed

2. Duplicates:
    - Completely duplicate rows should be removed
    - Duplicate Order IDs are expected (one order = multiple products)
    - Consider aggregating at order level if needed

3. Invalid Values:
    - Negative Sales: Investigate - could be returns or data entry errors
    - Negative Quantity: Investigate - could be returns
    - Invalid Discount: Check if values are within 0-1 range
    - Date Sequence: Ship Date should not be before Order Date

4. Outliers:
    - Sales outliers: May represent legitimate high-value transactions
    - Profit outliers: May represent loss-making orders (important for analysis)
    - Decision: Keep outliers for business analysis unless clearly erroneous

5. Date Transformations:
    - Extract year, quarter, month for time-series analysis
    - Calculate order-to-ship days for operational analysis
    - Create derived columns for profit margin and sales per quantity

6. Data Type Conversions:
    - Ensure date columns are DATE type
    - Ensure numeric columns are appropriate types (DECIMAL, INT)
    - Ensure categorical columns are VARCHAR with appropriate length
*/