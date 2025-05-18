-- Retrieve customers who have at least one active savings plan
-- and one active investment plan, along with their total deposit amount.
-- The results are sorted by the total deposits in descending order.

SELECT 
    u.id AS owner_id,                            -- Customer ID
   concat(u.first_name,' ',u.last_name) as name,                                     -- Customer Name
    COUNT(CASE WHEN p.plan_type_id = 1 THEN 1 END) AS active_savings_plans,   -- Count of active savings plans
    COUNT(CASE WHEN p.plan_type_id = 2 THEN 1 END) AS active_investment_plans, -- Count of active investment plans
    COALESCE(SUM(s.amount), 0) AS total_deposit_amount  -- Sum of deposits, defaults to 0 if none
FROM 
    users_customuser u
LEFT JOIN 
    plans_plan p 
    ON u.id = p.owner_id 
    AND p.status_id = 1                        -- Only active plans considered
LEFT JOIN 
    savings_savingsaccount s 
    ON p.id = s.plan_id
GROUP BY 
    u.id, u.name
HAVING 
    active_savings_plans > 0                    -- At least one active savings plan
    AND active_investment_plans > 0             -- At least one active investment plan
ORDER BY 
    total_deposit_amount DESC;                  -- Sort by total deposit amount, highest first
