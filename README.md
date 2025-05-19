# ASSESSMENT TITLE

Data Analytics Assessment

# ASSESSMENT OVERVIEW

This repository contains solutions of SQL Proficiency Assessment that evaluations my ability to work with relational databases by writing SQL queries to solve business problems. 

The four questions in this assessment are:

1. Assessment Q1: Identify customers with Savings and Investment Plans - **Assessment_Q1.sql**
2. Assessment Q2: Analyze customers transaction into Frequency Segmentation - **Assessment_Q2.sql**
3. Assessment Q3: Identify accounts with No Inflows for Over 365 days   - **Assessment_Q3.sql**
4. Assessment Q4: Estimate Customer Lifetime Value (CLV) - **Assessment_Q4.sql**


# QUESTION 1

##Question 1 Scenario: 

Identify customers with Savings and Investment Plans 


##Question 1 - Task:

Write a query to find customer that meets the below conditions:
	1: Atleast one funded savings plan
	2: Atleast one funded investment plan 

##Question 1 - Solution Approach

The query identifies customers who hold both a savings plan and an investment plan. It calculates the total of their confirmed deposits, filters out customers who haven't made any deposits, and sorts the results by total deposits in descending order.


# QUESTION 2

##Question 2 Scenario: 

The finance team wants to analyze how often customers transact to segment them.


##Question 2 - Task:

Calculate the average number of transactions per customer per month and categorize them based on:
	1. "High Frequency" (≥10 transactions/month)
	2. "Medium Frequency" (3-9 transactions/month)
	3. "Low Frequency" (≤2 transactions/month)

##Question 2 - Solution Approach

The query computes the average number of transactions per customer each month, then classifies them into different frequency groups. The results are organized by frequency category and average monthly transactions.



# QUESTION 3

##Question 3 Scenario: 

The ops team wants to flag accounts with no inflow transactions for over one year.

##Question 3 - Task:

Find all active accounts (savings or investments) with no transactions in the last 365 days (1 year).

##Question 3 - Solution Approach

This query finds customers who have active savings or investment plans and excludes those who haven't made any transactions in the past year. The results are sorted by inactivity, starting with the accounts that have been the least active.



# QUESTION 4

##Question 4 Scenario: 

Marketing team wants to estimate CLV based on account tenure and transaction volume.

##Question 4 - Task:

For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
	1. Account tenure (months since signup)
	2. Total transactions
	3. Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)

##Question 4 - Solution Approach

The query determines the length of time an account has been active, the transaction volume, and the Customer Lifetime Value (CLV) for each customer. It then arranges customers by their estimated CLV in descending order to identify the highest-value customers.



# CHALLENGES FACED
1. Aggregating Data:
   - Correctly aggregating data was challenging, especially when working with 'GROUP BY' and 'HAVING' clauses. I optimized these query sections to ensure the aggregations were precise.

2. Handling Null Valued:

**Handling Null Values**
   - Dealing with NULL values led to some unexpected outcomes, particularly during aggregation and filtering. I added appropriate NULL checks and refined the logic to ensure accurate handling of missing data.




# HOW TO USE

1. Clone this repository to your local machine:







