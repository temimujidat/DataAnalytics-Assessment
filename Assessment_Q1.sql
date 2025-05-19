
-- QUESTION 1 

-- SCENARIO: The business wants to identify customers who have both a savings and an investment plan.

-- TASK: Write a query to find customer that meets the below conditions:
 --   1: Atleast one funded savings plan
 --   2: Atleast one funded investment plan 

 -- sorted by total deposits.


SELECT
    uc.id AS owner_id, -- Customer ID
    CONCAT(uc.first_name, ' ', uc.last_name) AS name,  -- Customer Name (Concatenating first and last name)


    -- Counts of each customer's savings plans
    COUNT(DISTINCT CASE 
        WHEN pp.is_regular_savings = 1 THEN pp.id
    END) AS savings_count,


    -- Counts of each customer's investment plans
    COUNT(DISTINCT CASE 
        WHEN pp.is_a_fund = 1 THEN pp.id
    END) AS investment_count,


    -- Total confirmed deposits in customer's savings account 
    SUM(CASE 
            WHEN ss.confirmed_amount > 0 THEN ss.confirmed_amount
            ELSE 0
        END
    ) AS total_deposits

FROM users_customuser uc



-- Linking the users_customuser data with the investment plan data. 
LEFT JOIN plans_plan pp
    ON uc.id = pp.owner_id


-- Linking the users_customuser data with the customer savings data. 
LEFT JOIN savings_savingsaccount ss
    ON uc.id = ss.owner_id


-- Group by customer id and name 
-- to aggregate savings counts, investment counts and total deposits
GROUP BY uc.id, name


-- Filter to only include users with at least one funded savings AND one investment plan AND have made confirmed deposits
HAVING 
    savings_count > 0 
    AND investment_count > 0 
    AND total_deposits > 0

-- Order results by total deposits in descending order 
ORDER BY total_deposits DESC;
