USE Finance;

SELECT * FROM fins_sales;

-- 1. Which country has the highest total loss amount.
SELECT TOP 1 Country, SUM(Profits) AS TOTAL_LOSS_AMOUNT FROM fins_sales GROUP BY Country ORDER BY SUM(Profits) ASC ;

-- 2. Which product has the maximum number of loss transactions.
SELECT TOP 1 Product, COUNT(*) AS TRANS_LOSS_AMOUNT FROM fins_sales WHERE Profits < 0 GROUP BY Product ORDER BY TRANS_LOSS_AMOUNT  DESC ;

-- 3. Find countries where average profit is negative.
SELECT Country, AVG(ProfitS) AS AVG_PROFITS FROM fins_sales GROUP BY Country HAVING AVG(ProfitS) < 0;

-- 4. Find products whose total profit exceeds 5 million.
SELECT Product, SUM(Profits) AS TOTAL_PROFIT FROM fins_sales GROUP BY Product HAVING SUM(Profits) > 5000000;

-- 5.Find percentage of loss transactions overall.
SELECT (COUNT(CASE WHEN Profits < 0 THEN 1 END) * 100.0 / COUNT(*)) AS percentage_of_loss_transactions FROM fins_sales;

-- 6. Which segment contributes most to losses.
SELECT TOP 1 Segment, SUM(Profits) AS MOST_LOSS FROM fins_sales WHERE Profits < 0 GROUP BY Segment ORDER BY SUM(Profits) ASC;

-- 7.Find countries with both profits and losses.
SELECT Country FROM fins_sales GROUP BY Country
HAVING SUM(CASE WHEN Profits > 0 THEN 1 ELSE 0 END) > 0
AND 
SUM(CASE WHEN Profits < 0 THEN 1 ELSE 0 END) > 0;

-- 8. Find the most profitable product in each country.
SELECT DISTINCT Product, Country, SUM(Profits) AS MOST_PROFITS FROM fins_sales GROUP BY Country,Product HAVING SUM(Profits) > 0;

SELECT DISTINCT Product, Country, SUM(Profits) AS MOST_PROFITS FROM fins_sales
GROUP BY Country,Product HAVING SUM(Profits) = ( SELECT MAX(TOTAL_PROFITS) FROM
(SELECT SUM(Profits) AS TOTAL_PROFITS FROM fins_sales F2
WHERE F2.Country = fins_sales.Country
GROUP BY Product) AS X);

-- 9. Find products that never generated losses.
SELECT Product FROM fins_sales GROUP BY Product HAVING MIN(Profits) >= 0;

-- 10.Which country has the most stable profits.
SELECT TOP 1 Country, (MAX(Profits) - MIN(Profits)) AS STABLE_PROFIT FROM fins_sales GROUP BY Country ORDER BY STABLE_PROFIT;













