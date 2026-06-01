USE Finance;

SELECT * FROM fins_sales;

UPDATE fins_sales SET Discount_Band = 'Moderate' WHERE Discount_Band IS NULL;

----------------------------------------- SALES ANALYSIS ---------------------------------------------------

-- 1. the total sales for each country
SELECT Country,SUM(Gross_Sales) AS TOTAL_SALES FROM fins_sales GROUP BY Country;

-- 2. Which country has the highest gross sales
SELECT TOP 1 Country,SUM(Gross_Sales) AS TOTAL_SALES FROM fins_sales GROUP BY Country ORDER BY SUM(Gross_Sales) DESC;

-- 3. Which country has the lowest profit
SELECT TOP 1 Country,SUM(Profits) AS TOTAL_PROFITS FROM fins_sales GROUP BY Country ORDER BY SUM(Profits) ASC;

-- 4. Find the top 3 countries by profit.
SELECT TOP 3 Country,SUM(Profits) AS TOTAL_PROFITS FROM fins_sales GROUP BY Country ORDER BY SUM(Profits) DESC;

-- 5. Which product generated the highest sales.
SELECT TOP 1 SUM(Gross_Sales) AS HIHG_SALES,Product FROM fins_sales GROUP BY Product ORDER BY SUM(Gross_Sales) DESC;

-- 6.Which product generated the lowest profit.
SELECT TOP 1 SUM(Profits) AS HIHG_SALES,Product FROM fins_sales GROUP BY Product ORDER BY SUM(Profits) ASC;

-- 7.Find total units sold by each product.
SELECT Product,SUM(Units_Sold) AS Total_units_sold FROM fins_sales GROUP BY Product;

-- 8.Which segment sold the most units.
SELECT Segment,SUM(Units_Sold) AS Total_units_sold FROM fins_sales GROUP BY Segment ORDER BY SUM(Units_Sold) DESC;

-- 9.Which segment generated the highest profit.
SELECT Segment,SUM(Profits) AS HIGH_PROFIT FROM fins_sales GROUP BY Segment ORDER BY SUM(Profits) DESC;

-- 10.Find the average sales for each segment.
SELECT Segment,AVG(Gross_Sales) AS AVG_SALES FROM fins_sales GROUP BY Segment ORDER BY AVG(Gross_Sales) DESC;


----------------------------------------- DISCOUNT ANALYSIS ------------------------------------------------------------

SELECT * FROM fins_sales;
-- 11.Which discount band generated the highest sales.
SELECT TOP 1 SUM(Gross_Sales) AS HIGHEST_SALES,Discount_Band FROM fins_sales GROUP BY Discount_Band ORDER BY SUM(Gross_Sales) DESC;

-- 12.Which discount band generated the lowest profit.
SELECT TOP 1 SUM(Profits) AS LOWEST_PROFIT,Discount_Band FROM fins_sales GROUP BY Discount_Band ORDER BY SUM(Profits) ASC;

-- 13.Find average profit for each discount band.
SELECT Discount_Band, AVG(Profits) AS AVG_PROFITS FROM fins_sales GROUP BY Discount_Band;

-- 14.Count how many records exist in each discount band.
SELECT Discount_Band,COUNT(Discount_Band) AS COUNTS FROM fins_sales GROUP BY Discount_Band;

-- 15.Find products where discounts caused negative profits.
SELECT Product, SUM(Profits) AS NEGATIVE_PROFITS FROM fins_sales WHERE Profits < 0 GROUP BY Product;

---------------------------------------- PROFIT ANALYSIS -----------------------------------------------

SELECT * FROM fins_sales;

-- 16. Find all transactions with negative profit.
SELECT * FROM fins_sales WHERE Profits < 0;

-- 17. Which country has the highest number of loss transactions.
SELECT TOP 1 Country, COUNT(*) AS HIGH_LOSS FROM fins_sales WHERE Profits < 0 GROUP BY Country ORDER BY HIGH_LOSS  DESC;

-- 18. Find the total loss amount.
SELECT SUM(Profits) AS TOTAL_LOSS FROM fins_sales WHERE Profits<0;

-- 19. Find products with profit greater than 1 million.
SELECT Product, SUM(Profits) AS TOTAL_PROFITS FROM fins_sales GROUP BY Product HAVING SUM(Profits) > 1000000;

-- 20. Find the average profit by country.
SELECT Country, AVG(Profits) AS AVG_PROFIT FROM fins_sales GROUP BY Country;


-------------------------------------- DATE ANALYSIS ---------------------------------------------------
SELECT * FROM fins_sales;

-- 21. Find total sales year-wise.
SELECT Year, SUM(Gross_Sales) AS TOTAL_SALES FROM fins_sales GROUP BY Year;

-- 22. Find total profit month-wise.
SELECT Month_Name, SUM(Profits) AS TOTAL_PROFITS FROM fins_sales GROUP BY Month_Name, Month_Number ORDER BY Month_Number;

-- 23.Which month had the highest sales.
SELECT TOP 1 Month_Name, SUM(Gross_Sales) AS HIGH_SALES FROM fins_sales GROUP BY Month_Name ORDER BY SUM(Gross_Sales) DESC;

-- 24. Which year had the best overall profit.
SELECT TOP 1 Year, SUM(Profits) AS overall_profit FROM fins_sales GROUP BY Year ORDER BY SUM(Profits) DESC;

-- 25. Compare 2013 vs 2014 total profits.
SELECT Year, SUM(Profits) AS TOTAL_PROFITS FROM fins_sales WHERE Year IN (2013, 2014) GROUP BY Year;


---------------------------------------- ADVANCE FILTERING ------------------------------------------------
SELECT * FROM fins_sales;

-- 26. Find Enterprise segment transactions where profit is negative.
SELECT * FROM fins_sales WHERE Segment = 'Enterprise' AND Profits < 0;

-- 27.Find Government segment sales above 500000.
SELECT * FROM fins_sales WHERE Segment = 'Government' AND Gross_Sales > 500000

-- 28. Find records where : Units sold > 1000 AND profit < 0.
SELECT * FROM fins_sales WHERE Units_Sold > 1000 AND Profits < 0;

-- 29. Find products sold in Germany with high discounts.
SELECT Product, Discount_Band FROM fins_sales WHERE Country = 'Germany' AND Discount_Band = 'High';

-- 30. Find transactions where manufacturing cost is greater than gross sales.
SELECT  * FROM fins_sales WHERE Manufacturing_Cost > Gross_Sales;


------------------------------------------ GROUP BY + HAVING -----------------------------------------
SELECT * FROM fins_sales;

-- 31. Find countries whose total profit is greater than 5 million.
SELECT Country, SUM(Profits) AS TOTAL_PROFITS FROM fins_sales GROUP BY Country HAVING SUM(Profits) > 5000000 ;


-- 32. Find products whose average sales exceed 100000.
SELECT Product, AVG(Gross_Sales) AS AVG_SALES FROM fins_sales GROUP BY Product HAVING AVG(Gross_Sales) > 100000;

-- 33. Find segments with total units sold less than 5000.  HAVING SUM(Units_Sold) < 5000
SELECT Segment, SUM(Units_Sold) AS TOTAL_UNITS FROM fins_sales GROUP BY Segment;

-- 34. Find countries having more than 10 transactions.
SELECT Country, COUNT(*) AS TRAN_SACTION FROM fins_sales GROUP BY Country HAVING COUNT(*) > 10;

-- 35. Find products with negative total profit.
SELECT Product, SUM(Profits) AS NVE_PROFIT FROM fins_sales GROUP BY Product HAVING SUM(Profits) < 0 ;


----------------------------------------- CASE STATEMENT --------------------------------------------------
SELECT * FROM fins_sales;

-- 36. Create a column: "Profit" if profits > 0, "Loss" if profits < 0
SELECT Profits, Product,
CASE 
WHEN Profits > 0 THEN 'Profit'
WHEN Profits < 0 THEN'Loss' 
END AS PROFIT_STATUS
FROM fins_sales;

-- 37. Categorize sales:LOW, MEDIUM, HIGH.
SELECT Gross_Sales,
CASE
WHEN Gross_Sales < 500000 THEN 'LOW'
WHEN Gross_Sales BETWEEN 500000 AND 1000000 THEN 'MEDIUM'
ELSE 'HIGH'
END AS RANGES
FROM fins_sales ORDER BY Gross_Sales;

-- 38. Create customer performance categories based on units sold.
SELECT Product, SUM(Units_Sold) AS TOTAL_UNITS,
CASE
WHEN  SUM(Units_Sold) < 300000 THEN 'LOW PERFORMANCE'
WHEN  SUM(Units_Sold) BETWEEN 300000 AND 400000 THEN 'MEDIUM PERFORMANCE'
ELSE 'HIGH PERFORMANCE'
END AS PRODUCT_PERFORMANCE
FROM fins_sales GROUP BY Product;

-- 39. Create a risk category using discount bands.
SELECT Discount_Band,
CASE
WHEN  Discount_Band = 'Low' THEN 'LOW RISK'
WHEN  Discount_Band = 'Medium' THEN 'MEDIUM RISK'
WHEN  Discount_Band = 'High' THEN 'HIGH RISK'
ELSE 'MODERATE RISK'
END AS RISK_CATEGORY
FROM fins_sales;

-- 40. Create a profit status column.
ALTER TABLE fins_sales ADD Profit_Status AS (
CASE 
WHEN Profits > 0 THEN 'Profit'
WHEN Profits < 0 THEN'Loss' 
END);

select Product,
Country,
Profits,
case 
when profits > 0 then 'Profit'
when profits < 0 then 'Loss'
else 'Break-even'
end as Profit_Status
from fins_sales;

--Find the country that contributed the highest total losses Requirements:
-- only loss transactions show country, show total loss amount, highest loss contributor only
--Write the SQL query.

select country, sum(profits) as total_profits, 
count(*) as loss_transaction
from fins_sales
group by country
having sum(profits) < 0 
order by sum(profits) asc;
-- correct query
SELECT TOP 1
       Country,
       SUM(Profits) AS total_loss
FROM fins_sales
WHERE Profits < 0
GROUP BY Country
ORDER BY SUM(Profits) ASC;

----------------------------------- RANK ---------------------------------------
SELECT * FROM fins_sales;

SELECT Country,SUM(Gross_Sales) AS TOTAL_SALES,
RANK() OVER(
ORDER BY SUM(Gross_Sales) DESC) AS RANKING
FROM fins_sales
GROUP BY Country;











