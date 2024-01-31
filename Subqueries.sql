-- Subqueries practice. 

-- Subqueries in the SELECT clause.
--the average price for sales where the price more than 10,000
SELECT 
    s.sales_type_id,
    s.dealership_id,
    (SELECT AVG(price) 
    FROM sales 
    WHERE price > 10000) AS avg_price
FROM 
    sales s;
   

-- This statment finds the ID of the type of sale in both tables Sales and types sale

SELECT s.vehicle_id, s.customer_id, s.sales_type_id, 
       (SELECT SUM(deposit) 
        FROM sales
        WHERE sales_type_id = s.sales_type_id) AS total_deposit
FROM sales s;
   


--Subqueries in the WHERE clause     
--This statement finds the avg price of vehicles in the sales table
SELECT vehicle_id, customer_id, sales_type_id, price
FROM sales
WHERE
price  > (SELECT AVG(price) FROM sales);


--Common Table Expressions (CTE) and how to use it as an alternative to subqueries.
WITH
   name_for_summary_data AS (SELECT Statement)
   SELECT columns
   FROM name_for_summary_data
   WHERE conditions <=> (
      SELECT column
      FROM name_for_summary_data)
   [ORDER BY columns]