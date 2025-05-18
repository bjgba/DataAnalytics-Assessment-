# DataAnalytics-Assessment-

Question 1 – High-Value Customers with Multiple Products
Scenario: The business is interested in identifying customers who have both a savings and an investment plan—ideal for cross-selling opportunities.
Task: Write a query to find customers with at least one funded savings plan and one funded investment plan, then sort them by total deposits.

My Approach:
I focused on finding customers who hold both savings and investment plans, as these are key candidates for cross-selling. By joining customer, plan, and account data, I filtered for those with active (funded) savings and investment plans. Then, I calculated their total deposits and sorted the results in descending order to highlight the most valuable customers based on their contribution.

Question 2 – Transaction Frequency Analysis
Scenario: The finance team needs to segment customers based on how frequently they transact—e.g., frequent users vs. occasional ones.
Task: Calculate the average number of transactions per customer per month and categorize them as:

High Frequency (≥10/month)

Medium Frequency (3–9/month)

Low Frequency (≤2/month)

My Approach:
To better understand customer engagement, I calculated each customer’s average monthly transaction count using successful transactions only. Based on these figures, I grouped them into High, Medium, or Low frequency categories. This makes it easier for the finance team to target the right segments with appropriate products or communication strategies.

Question 3 – Account Inactivity Alert
Scenario: The operations team wants to flag accounts that haven't seen any inflow transactions for over a year.
Task: Identify all active accounts (savings or investment) with no transactions in the last 365 days.

My Approach:
I filtered for active plans—excluding archived or deleted ones—and looked at their transaction history. Any plan with no transactions in the past year (or no transactions at all) was flagged as inactive. This helps the ops team quickly identify dormant accounts for possible follow-up or reactivation campaigns.

Question 4 – Customer Lifetime Value (CLV) Estimation
Scenario: Marketing needs a simple way to estimate CLV using customer tenure and transaction volume.
Task: For each customer, calculate:

Tenure (months since signup)

Total transactions

Estimated CLV using:
CLV = (total_transactions / tenure) * 12 * (0.1% of total transaction value)

Sort by CLV, highest to lowest

My Approach:
To provide a meaningful CLV estimate, I measured how long each customer has been with us, counted their successful transactions, and applied a simplified CLV formula assuming 0.1% profit per transaction. This gives marketing a clear view of which customers are most valuable over time, helping them prioritize retention and loyalty efforts.

Challenges I Faced:
Initially, I assumed SQL Server would be fine for running these queries. But once I got started, I noticed that the syntax in the test was designed for MySQL. That caused a brief delay, but I adapted quickly. I downloaded and set up MySQL locally, reran the scripts, and everything worked perfectly from that point onward.
