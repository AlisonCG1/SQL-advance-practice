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
WITH average_price AS (
   SELECT MAX(price) AS avg_price
   FROM sales
)
SELECT vehicle_id AS vehicle, customer_id, sales_type_id
FROM sales
WHERE price = (SELECT avg_price FROM average_price);
   
 
--Joint CTEs. 

INSERT INTO oilchangelogs
	(date_occured, vehicle_id)
VALUES
	('2020-01-09', 1),
	('2021-10-30', 2),
	('2019-02-20', 3),
	('2022-03-17', 4)
;

WITH vehicles_needing_service AS
(
    SELECT
        v.vehicle_id,
        v.year_of_car,
        v.miles_count,
        TO_CHAR(o.date_occured, 'YYYY-MM-DD') date_of_last_change
    FROM vehicles v
    JOIN oilchangelogs o
        ON v.vehicle_id = o.vehicle_id
    WHERE o.date_occured < '2022-01-01'
)

