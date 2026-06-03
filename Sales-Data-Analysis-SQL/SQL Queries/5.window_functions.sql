USE Finance;

SELECT * FROM fins_sales;

--=================================== Window_Functions =================================

-- 1.Rank Countries by Total Profit.
WITH country_ranks AS 
(
	SELECT 
		Country,
		SUM(Profits) AS total_profits,
		RANK() OVER(
			ORDER BY SUM(Profits) DESC) AS ranks
	FROM fins_sales
	GROUP BY Country
)
SELECT * 
FROM country_ranks;

-- 2.Assign ROW_NUMBER to Products based on Gross Sales.
SELECT 
	Product,
	SUM(Gross_Sales) AS Sales,
	ROW_NUMBER() OVER(
		ORDER BY SUM(Gross_Sales) DESC) AS Sales_Rank
FROM fins_sales
GROUP BY Product;

-- 3.Assign DENSE_RANK to Products based on Profit.
SELECT 
	Product,
	SUM(Profits) AS Profits,
	DENSE_RANK() OVER(
		ORDER BY SUM(Profits) DESC) AS Profits_rnk
FROM fins_sales
GROUP BY Product;

-- 4.Find Top 2 Products in each Country using PARTITION BY.
WITH top_prod AS 
(
	SELECT 
		Country,
		Product,
		SUM(Gross_Sales) AS Sales,
		RANK() OVER(
			PARTITION BY Country 
			ORDER BY SUM(Gross_Sales) DESC)
		AS Ranks
	FROM fins_sales
	GROUP BY Country, Product
)
SELECT * 
FROM top_prod 
WHERE Ranks <= 2;

-- 5.Find Bottom 2 Products in each Country using PARTITION BY.
WITH bottom_prod AS 
(
	SELECT 
		Country,
		Product,
		SUM(Gross_Sales) AS Sales,
		RANK() OVER(
			PARTITION BY Country 
			ORDER BY SUM(Gross_Sales) ASC)
		AS Ranks
	FROM fins_sales
	GROUP BY Country, Product
)
SELECT * 
FROM bottom_prod 
WHERE Ranks <= 2;

-- 6.Calculate Running Total of Gross Sales by Month.
SELECT 
	MONTH(Date) AS MONTHS_NUM,
	SUM(Gross_Sales) AS Gross_sales,
	SUM(SUM(Gross_Sales)) OVER(
		ORDER BY MONTH(Date)) AS running_total
FROM fins_sales
GROUP BY MONTH(Date);

-- 7.Calculate Running Profit by Year.
SELECT 
	YEAR(Date) AS Years,
	SUM(Profits) AS Profits,
	SUM(SUM(Profits)) OVER(
		ORDER BY YEAR(Date)) AS running_total
FROM fins_sales
GROUP BY YEAR(Date);


























