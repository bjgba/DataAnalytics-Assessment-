-- Retrieve a list of inactive plans based on the date of their last transaction
SELECT 
    p.id AS plan_id,  -- Identifier for the plan
    p.owner_id,       -- ID of the customer who owns the plan
    CASE 
        WHEN p.plan_type_id = 1 THEN 'Savings'      -- Classify plan type
        WHEN p.plan_type_id = 2 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    MAX(s.transaction_date) AS last_transaction_date,  -- Latest transaction linked to the plan
    DATEDIFF(CURRENT_DATE(), MAX(s.transaction_date)) AS inactivity_days  -- Days since last activity
FROM 
    plans_plan p
LEFT JOIN 
    savings_savingsaccount s ON p.id = s.plan_id  -- Associate plans with their transactions
WHERE 
    p.status_id = 1       -- Filter for plans that are marked as active
    AND p.is_deleted = 0  -- Exclude plans that have been deleted
    AND p.is_archived = 0 -- Exclude archived plans
GROUP BY 
    p.id, p.owner_id, p.plan_type_id
HAVING 
    -- Only include plans that have never had a transaction 
    -- or whose last transaction was more than 1 year ago
    MAX(s.transaction_date) IS NULL 
    OR MAX(s.transaction_date) < DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY)
ORDER BY 
    inactivity_days DESC;  -- Show the most inactive plans first
