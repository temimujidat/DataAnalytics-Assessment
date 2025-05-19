-- QUESTION 3

-- SCENARIO: The ops team wants to flag accounts with no inflow transactions for over one year.
-- TASK: Find all active accounts (savings or investments) with no transactions in the last 365 days.

SELECT
    sa.plan_id,  -- Plan id on the customer's account
    sa.owner_id,  -- Customer id
    
    -- Determine if the customer's account is a savings or an investment account
    CASE
        WHEN pp.is_regular_savings = 1 THEN 'savings'   -- If avings plan 
        WHEN pp.is_a_fund = 1 THEN 'investment'  -- If investment plan 
        ELSE 'unknown'   -- If unknown value
    END AS type,
    
    -- Derive the last transaction date and inactivity duration on customer's account
    MAX(sa.created_on) AS last_transaction_date,   -- Most recent transaction date
    DATEDIFF(CURDATE(), MAX(sa.created_on)) AS inactivity_days   -- Days since last transaction

FROM savings_savingsaccount sa

-- Linking the customer's account data with the plan data inorder to get the plan details. 
INNER JOIN plans_plan pp
    ON sa.plan_id = pp.id

-- Filter to consider valid transactions from active, non-archived, and non-deleted plans
WHERE
    sa.confirmed_amount > 0
    AND pp.status_id = 1    -- Active plan
    AND pp.is_archived = 0   -- Non achieved plan
    AND pp.is_deleted = 0     -- Non deleted plan

-- Group by customer and account plan to determine last transaction per account
GROUP BY
    sa.plan_id,    -- Group by Plan id
    sa.owner_id,   -- Group by customer id
    pp.is_regular_savings,   -- Group by plan type
    pp.is_a_fund

-- Filter to only include accounts with no inflow for more than 365 days
HAVING
    MAX(sa.created_on) < (CURDATE() - INTERVAL 365 DAY)

-- Order results by inactivity days 
ORDER BY
    inactivity_days DESC;
