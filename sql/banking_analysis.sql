-- Banking Operations Analysis
-- Dataset: NIBSS Nigerian Banking Transactions
-- Analyst: Charity Ikeh


-- Summary: Overall transaction and fraud overview
SELECT
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS total_fraud_cases,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(AVG(amount), 2) AS avg_amount_ngn,
    ROUND(SUM(amount), 2) AS total_amount_ngn
FROM nibss_banking_cleaned;



-- Transaction volume and fraud by bank
SELECT
    bank,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_cases,
    ROUND(SUM(amount), 2) AS total_amount_ngn,
    ROUND(AVG(amount), 2) AS avg_amount_ngn
FROM nibss_banking_cleaned
GROUP BY bank
ORDER BY total_transactions DESC;



-- Fraud breakdown by technique
SELECT
    fraud_technique,
    COUNT(*) AS cases,
    ROUND(COUNT(*) * 100.0 / 
          SUM(COUNT(*)) OVER(), 2) AS pct_of_total_fraud
FROM nibss_banking_cleaned
WHERE is_fraud = 1
GROUP BY fraud_technique
ORDER BY cases DESC;


-- Transaction volume by channel
SELECT
    channel,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_cases,
    ROUND(AVG(amount), 2) AS avg_amount_ngn
FROM nibss_banking_cleaned
GROUP BY channel
ORDER BY total_transactions DESC;


-- Top 10 customers by transaction volume
SELECT
    customer_id,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_amount_ngn,
    SUM(is_fraud) AS fraud_cases
FROM nibss_banking_cleaned
GROUP BY customer_id
ORDER BY total_transactions DESC
LIMIT 10;


-- Monthly transaction trend
SELECT
    transaction_month,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_amount_ngn,
    SUM(is_fraud) AS fraud_cases
FROM nibss_banking_cleaned
GROUP BY transaction_month
ORDER BY transaction_month;
