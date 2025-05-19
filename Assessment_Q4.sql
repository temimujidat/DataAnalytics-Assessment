-- QUESTION 4:

-- SCENARIO: Marketing team wants to estimate CLV based on account tenure and transaction volume.

-- TASK: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
--     1. Account tenure (months since signup)
--     2. Total transactions
--     3. Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)

-- Order by estimated CLV from highest to lowest


SELECT
    uc.id AS customer_id,  -- customer id
    CONCAT(uc.first_name, ' ', uc.last_name) AS name,  -- customer name
    
    -- Calculating then account tenure - months since signup
    PERIOD_DIFF(DATE_FORMAT(CURDATE(), '%Y%m'), DATE_FORMAT(uc.date_joined, '%Y%m')) AS tenure_months,
    
    -- Calculating the total number of confirmed transactions 
    COUNT(ss.id) AS total_transactions,
    
    -- Estimated CLV formula based on transaction count and average profit
    -- CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction
    ROUND(
        (
            COUNT(ss.id) / 
            NULLIF(PERIOD_DIFF(DATE_FORMAT(CURDATE(), '%Y%m'), DATE_FORMAT(uc.date_joined, '%Y%m')), 0)  -- Tenure in Months
        ) * 12 *   -- Normalizing to yearly rate
        (0.001 * AVG(ss.confirmed_amount)), -- Profit per transaction
        2) AS estimated_clv  -- Estimated CLV rounded up to 2 decimal places

FROM
    users_customuser uc

-- Join customers data with savings transactions data to get customers' transaction details
JOIN
    savings_savingsaccount ss ON ss.owner_id = uc.id

-- Filter to only consider confirmed transactions
WHERE
    ss.confirmed_amount > 0


-- Group by customer details
GROUP BY
    uc.id,   -- Group by customer id
    uc.name,  -- Group by customer name
    uc.date_joined   -- Group by customer signup date

-- Order results by estimated CLV in ascending order
ORDER BY
    estimated_clv ASC;
