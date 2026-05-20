CREATE DATABASE Finance;

USE Finance;

DROP TABLE fin_sales;

SELECT * FROM dbo.fins_sales;

SELECT TOP 10  * FROM dbo.fins_sales; 

SELECT SUM(COGS) AS COG FROM dbo.fins_sales;

SELECT * FROM dbo.fins_sales WHERE Year = 2014;

SELECT  DISTINCT COUNT(*) FROM dbo.fins_sales WHERE Year = 2014;

SELECT Sales FROM dbo.fins_sales WHERE Discount_Band = 'Low';

SELECT SUM(Sales) AS LOW_Sales FROM dbo.fins_sales WHERE Discount_Band = 'Low';

SELECT SUM(Sales) AS Medium_Sales FROM dbo.fins_sales WHERE Discount_Band = 'Medium';

SELECT SUM(Sales) AS High_Sales FROM dbo.fins_sales WHERE Discount_Band = 'High';

select AVG(Profit) AS AVERAGE FROM dbo.fins_sales WHERE Country = 'Germany';

SELECT * FROM dbo.fins_sales where Segment = 'Enterprise';

SELECT * FROM dbo.fins_sales where Segment = 'Enterprise' AND Units_Sold <= 1500;

SELECT SUM(Profit) as Total_Profits FROM dbo.fins_sales where Segment = 'Enterprise' AND Units_Sold <= 1500;

SELECT SUM(Profit) as Total_Profits FROM dbo.fins_sales where Segment = 'Enterprise' AND Units_Sold >= 1500;

SELECT SUM(Profit) as Total_Profits,Country FROM dbo.fins_sales where Segment = 'Enterprise' group by Country;

SELECT MAX(Profit) AS Maximum_Profit, Country FROM dbo.fins_sales WHERE Segment = 'Midmarket' group by Country;

SELECT MIN(Profit) AS Minimum_Profit, Country FROM dbo.fins_sales WHERE Segment = 'Midmarket' group by Country;

SELECT DISTINCT * FROM dbo.fins_sales;

SELECT * FROM dbo.fins_sales WHERE Profit > 1000000 ORDER BY Profit ASC;

SELECT * FROM dbo.fins_sales WHERE Discount_Band = 'Low';

SELECT * FROM dbo.fins_sales ORDER BY Segment;

alter table dbo.fins_sales drop column Gross_Sales;

alter table dbo.fins_sales drop column Sales;

alter table dbo.fins_sales drop column Profit;

alter table dbo.fins_sales drop column COGS;

alter table dbo.fins_sales drop column Discounts;

ALTER TABLE dbo.fins_sales ADD Manufacturing_Cost as ([Units_Sold] * [Manufacturing_Price]);

ALTER TABLE dbo.fins_sales ADD Gross_Sales as ([Units_Sold] * [Sale_Price]);

SELECT * FROM dbo.fins_sales;

ALTER TABLE dbo.fins_sales ADD Profits as (([Units_Sold] * [Sale_Price])-([Units_Sold] * [Manufacturing_Price]));

SELECT * FROM dbo.fins_sales where Profits < 0 order by Country ASC;





















