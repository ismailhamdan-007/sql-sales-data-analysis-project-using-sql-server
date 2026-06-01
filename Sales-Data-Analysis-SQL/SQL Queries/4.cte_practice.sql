USE Finance;

SELECT * FROM fins_sales;

--========================== CTE ==========================

-- 1.Find the Top 3 Countries by Total Profit using a CTE.
WITH total_profit AS (
	SELECT TOP 3
		Country,
		SUM(Profits) AS Total_Profit
	FROM fins_sales 
	GROUP BY Country
	ORDER BY Total_Profit DESC)
SELECT * FROM total_profit;

-- 2.Find Products whose Total Profit is above the Average Product Profit using a CTE.
WITH Product_profits AS 
(
	SELECT 
	Product,
	SUM(Profits) AS Total_Profits
	FROM fins_sales
	GROUP BY Product
)
SELECT * 
FROM Product_profits
WHERE Total_Profits >
	(SELECT AVG(Profits) FROM fins_sales);

-- 3.Find the Segment with the Highest Gross Sales using a CTE.
WITH Highest_Gross_Sales AS
(
	SELECT
		Segment,
		SUM(Gross_Sales) AS Highest_Sales
	FROM fins_sales
	GROUP BY Segment
)
SELECT * 
FROM Highest_Gross_Sales
ORDER BY Highest_Sales DESC;

-- 4.Find Countries contributing more than 20% of Total Profit using a CTE.
WITH country_profit AS 
(
	SELECT 
		Country,
		SUM(Profits) AS Total_Profits
	FROM fins_sales
	GROUP BY Country
)
SELECT 
	Country,
	Total_Profits,
	ROUND(Total_Profits * 100.00 / 
		(SELECT SUM(Profits) AS Total_Profits FROM fins_sales), 2)
		AS Profit_contribution
FROM country_profit
WHERE (Total_Profits * 100.00 / 
		(SELECT SUM(Profits) AS Total_Profits FROM fins_sales)) > 20
ORDER BY Total_Profits DESC;

-- 5.Find the Most Profitable Product in each Country using a CTE.
WITH product_profit AS
(
	SELECT 
	Country,
	Product,
	SUM(Profits) AS most_profit,
	RANK() OVER(
	PARTITION BY Country ORDER BY SUM(Profits) DESC) AS ranks
	FROM fins_sales
	GROUP BY Country, Product
)
SELECT *
FROM product_profit
WHERE ranks = 1;

WITH product_profit AS
(
	SELECT 
	Country,
	Product,
	SUM(Profits) AS most_profit,
	ROW_NUMBER() OVER(
	PARTITION BY Country ORDER BY SUM(Profits) DESC) AS ranks
	FROM fins_sales
	GROUP BY Country, Product
)
SELECT *
FROM product_profit
WHERE ranks = 1;











































