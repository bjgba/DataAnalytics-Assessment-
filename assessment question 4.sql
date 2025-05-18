-- Calculate an estimated Customer Lifetime Value (CLV) for currently active customers
SELECT 
    u.id AS customer_id,  -- Unique identifier for the customer
    u.name,               -- Name of the customer
    TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE()) AS tenure_months,  -- Customer's lifetime in months
    COUNT(s.id) AS total_transactions,  -- Total number of successful transactions
    ROUND(
        (COUNT(s.id) / TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE())) * 12 *  -- Annualize the transaction rate
        (SUM(s.amount) * 0.001), 2) AS estimated_clv  -- Scaled and rounded CLV estimate
FROM 
    users_customuser u
LEFT JOIN 
    savings_savingsaccount s ON u.id = s.owner_id  -- Link customers to their transactions
WHERE 
    s.transaction_status = 'successful'  -- Only include successful transactions
    AND u.date_joined IS NOT NULL        -- Exclude customers with no recorded join date
    AND u.is_active = 1                  -- Limit results to active customers only
GROUP BY 
    u.id, u.name, u.date_joined
HAVING 
    tenure_months > 0  -- Ensure tenure is positive to avoid divide-by-zero errors
ORDER BY 
    estimated_clv DESC;  -- Rank customers from highest to lowest estimated CLV
