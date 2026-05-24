-- Databricks notebook source
SELECT * FROM `retail-sales`.sales.dataset;
--Q1 Which store sell the most and where is it located and it;s name

SELECT "Store ID","Store Name","City","Country","Continent",
SUM(`Net Sales`) AS total_revenue
FROM `retail-sales`.`sales`.`dataset`
GROUP BY "Store ID", "Store Name", "City", "Country", "Continent"
ORDER BY total_revenue DESC;


--Q2 What is the most soled/purchased product
SELECT "Product ID", "SKU", "Product Name",
SUM('Quantity') AS total_units_sold
FROM `retail-sales`.`sales`.`dataset`
GROUP BY "Product ID", "SKU", "Product Name"
ORDER BY total_units_sold DESC;

--Q3 Which store sells the least and where is it located? Also provide the store name.

SELECT "Store ID","StoreName","City", "Country","Continent",
SUM(`Net Sales`) AS total_revenue
FROM `retail-sales`.`sales`.`dataset`
GROUP BY "Store ID", "Store Name", "City", "Country", "Continent"
ORDER BY total_revenue ASC;

--Q4 What is the purchase date of a product, the date on which it was shipped, and its return date if returned?

SELECT "Order ID","Product Name","Product ID","SKU","Purchase Date","Ship Date",
CASE WHEN "Returned" ='Yes'THEN "Return Date" ELSE "Returned" ='NO' 
END AS  return_date
FROM `retail-sales`.`sales`.`dataset`
ORDER BY "Purchase Date";

--Q5 Which payment method do customers mostly prefer, and which age group uses it the most?

SELECT "Payment Method",
COUNT(*) AS transaction_count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM `retail-sales`.`sales`.`dataset`
GROUP BY "Payment Method"
ORDER BY transaction_count DESC;

--(Age group) — The agent said no age data and stopped it Should have used Customer Segment instead and reported that the Family segment uses Card the most.

--Q6 What is the priority of the customers according to their loyalty tier and age?

SELECT "Loyalty Tier", "Priority", "Customer Segment",
COUNT(DISTINCT "Customer ID") AS customer_count
FROM `retail-sales`.`sales`.`dataset`
GROUP BY "Loyalty Tier", "Priority", "Customer Segment"
ORDER BY CASE "Loyalty Tier" WHEN 'Gold' THEN 1 WHEN 'Silver' THEN 2 WHEN 'Bronze' THEN 3 ELSE 4 END,
  "Priority";
  
  --(Priority by age) — The agent ignored the missing age column with no alternative It should have used Customer Segment to show Family and the Normal priority dominates across all loyalty tiers.

--Q7 Rank all customers according to their loyalty tier and age.
SELECT `Customer ID`, `Customer Segment`, `Loyalty Tier`,
COUNT(*) AS transactions,
SUM(`Net Sales`) AS total_spent
FROM `retail-sales`.`sales`.`dataset`
GROUP BY `Customer ID`, `Customer Segment`, `Loyalty Tier`
ORDER BY CASE `Loyalty Tier` WHEN 'Gold' THEN 1 WHEN 'Silver' THEN 2 WHEN 'Bronze' THEN 3 ELSE 4 END,
total_spent DESC;


--Q8 What is the content of the store analysis?
SELECT "Continent",
COUNT(DISTINCT "Store ID") AS store_count
FROM `retail-sales`.`sales`.`dataset`
GROUP BY "Continent"
ORDER BY store_count DESC;

--Q9 Provide an overall analysis showing the relationship between store revenues.

SELECT `Continent`,
COUNT(DISTINCT `Store ID`) AS num_stores,
SUM(`Net Sales`) AS total_revenue
FROM `retail-sales`.`sales`.`dataset`
GROUP BY `Continent`
ORDER BY total_revenue DESC;
--Rounding error the agent reported $395,129 but actually should be $394,986

--Q10 What is the overall revenue of the retail sales business?
SELECT 
SUM("Gross Sales")  AS total_gross_sales,
SUM("Net Sales")    AS total_net_sales,
SUM("Gross Profit") AS total_gross_profit,
SUM("COGS")         AS total_cogs,
SUM("Tax Amount")   AS total_tax,
SUM("Shipping Cost") AS total_shipping
FROM `retail-sales`.`sales`.`dataset`;



