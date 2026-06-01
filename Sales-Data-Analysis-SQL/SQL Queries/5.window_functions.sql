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

-- 3.Assign DENSE_RANK to Products based on Profit.

-- 4.Find Top 2 Products in each Country using PARTITION BY.

-- 5.Find Bottom 2 Products in each Country using PARTITION BY.

-- 6.Calculate Running Total of Gross Sales by Month.

-- 7.Calculate Running Profit by Year.


























