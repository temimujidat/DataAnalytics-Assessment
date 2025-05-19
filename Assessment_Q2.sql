-- QUESTION 2 


-- SCENARIO: The finance team wants to analyze how often customers 
--         transact to segment them.

-- TASK: Calculate the average number of transactions per customer per month and categorize them based on:
--       1. "High Frequency" (≥10 transactions/month)
--       2. "Medium Frequency" (3-9 transactions/month)
--       3. "Low Frequency" (≤2 transactions/month)



SELECT
    frequency_category,  -- Labeled: High, Medium or low frequency
    COUNT(*) AS customer_count,   -- Number of customers in each category
    ROUND(AVG(avg_txns_per_month), 2) AS avg_transactions_per_month   -- Average transaction rate per category

FROM (
    -- Defining customers based on their average monthly transaction count
    SELECT
        owner_id,  -- Customer id
        ROUND(AVG(monthly_txn_count), 2) AS avg_txns_per_month,   -- Average monthly transaction count per customer
        

        -- Segmenting based on customers average monthly transaction to the frequency categories
        CASE
            WHEN AVG(monthly_txn_count) >= 10 THEN 'High Frequency'
            WHEN AVG(monthly_txn_count) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM (

        -- Computing average customer's monthly transaction counts
        SELECT
            ss.owner_id,  -- Customer id
            DATE_FORMAT(ss.created_on, '%Y-%m-01') AS txn_month,   
            COUNT(*) AS monthly_txn_count    

        FROM savings_savingsaccount  ss
        WHERE ss.confirmed_amount > 0  -- To Only includes valid transaction of customers
        
        GROUP BY ss.owner_id,  -- Group by customer id and transaction month
        DATE_FORMAT(ss.created_on, '%Y-%m-01')
    ) AS monthly_counts


    GROUP BY owner_id
) AS categorized_users

-- Final grouping by frequency category
GROUP BY frequency_category

-- Order results by High Frequency, Medium Frequency and Low Frequency
ORDER BY
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
