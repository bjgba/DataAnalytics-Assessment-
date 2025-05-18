-- Step 1: Compute monthly successful transactions per customer
WITH monthly_transactions AS (
    SELECT 
        s.owner_id,  -- Unique identifier for the customer
        DATE_FORMAT(s.transaction_date, '%Y-%m') AS month_year,  -- Format date to Year-Month
        COUNT(*) AS transaction_count  -- Number of successful transactions in that month
    FROM 
        savings_savingsaccount s
    WHERE 
        s.transaction_status = 'successful'  -- Include only successful transactions
        AND s.transaction_date IS NOT NULL   -- Exclude records without a transaction date
    GROUP BY 
        s.owner_id, month_year
),

-- Step 2: Calculate average monthly transaction count per customer
customer_avg_transactions AS (
    SELECT 
        owner_id,  -- Customer ID
        AVG(transaction_count) AS avg_transactions_per_month  -- Average monthly transactions
    FROM 
        monthly_transactions
    GROUP BY 
        owner_id
)

-- Step 3: Categorize customers based on their average monthly transactions
SELECT 
    CASE 
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'   -- 10 or more transactions
        WHEN avg_transactions_per_month >= 3 THEN 'Medium Frequency' -- Between 3 and 9.99
        ELSE 'Low Frequency'                                         -- Less than 3
    END AS frequency_category,
    COUNT(*) AS customer_count,  -- Number of customers in each category
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month  -- Rounded average
FROM 
    customer_avg_transactions
GROUP BY 
    frequency_category
ORDER BY 
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        WHEN 'Low Frequency' THEN 3
    END;
