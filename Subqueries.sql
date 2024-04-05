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

-- Another CTE that can be used to filter down the results to get the info about the last purchase only.
SELECT 
	vs.vehicle_id,
	vs.miles_count,
	s.purchase_date,
	e.first_name || ' ' || e.last_name seller,
	c.first_name || ' ' || c.last_name purchaser,
	c.email
FROM vehicles_needing_service vs -- Use the CTE
JOIN sales s
	ON s.vehicle_id  = vs.vehicle_id
JOIN employees e
	ON  s.employee_id = e.employee_id
JOIN  customers c
	ON s.customer_id = c.customer_id
ORDER BY
	vs.vehicle_id,
	s.purchase_date DESC
;

-- For the top 5 dealerships, which employees made the most sales? 
--*Note: to get a list of the top 5 employees with the associated dealership, 
--you will need to use a Windows function (next chapter). 
--There are other ways you can interpret this query to not return that strict of data.

WITH CumulativeSales AS (
    SELECT 
        sale_id,
        dealership_id,
        SUM(price) OVER (PARTITION BY dealership_id ORDER BY sale_id) AS cumulative_sum
    FROM sales
)
SELECT 
    ID.dealership_id,
    ID.employee_id,
    dlsp.business_name,
    cs.cumulative_sum
FROM 
    dealershipemployees AS ID
JOIN 
    dealerships AS dlsp ON ID.dealership_id = dlsp.dealership_id 
JOIN 
    CumulativeSales AS cs ON ID.dealership_id = cs.dealership_id 
ORDER BY 
    dlsp.business_name
LIMIT 5;

--For the top 5 dealerships, which vehicle models were the most popular in sales?
-- The first step is to create a CTE with the sales table

WITH topsales AS (
SELECT	SUM(sale_id) AS sales, sales_type_id, vehicle_id, dealership_id
FROM sales 
GROUP BY sales_type_id, vehicle_id, dealership_id
),

-- Joining CTEs after creating a CTE on the vehicles table
topvehicles AS(
SELECT v.vehicle_id, vt.vehicle_type_id, vt.model, top.*
FROM vehicles v 
JOIN vehicletypes vt
	ON v.vehicle_type_id = vt.vehicle_type_id 
JOIN topsales AS top
	ON top.vehicle_id = v.vehicle_id

)

SELECT topv.dealership_id, d.dealership_id, d.business_name
FROM dealerships d 
JOIN topvehicles AS topv 
	ON topv.dealership_id = d.dealership_id 
ORDER BY sales DESC 
LIMIT 5;

-- For the top 5 dealerships, were there more sales or leases?


WITH topleases AS(
SELECT	SUM(d.dealership_id) AS dealership, d.business_name, s.sales_type_id 
FROM dealerships d 
JOIN sales s 
ON d.dealership_id = s.dealership_id
GROUP BY business_name, sales_type_id 
)
SELECT st.sales_type_name, tp.dealership, tp.business_name, tp.sales_type_id 
FROM topleases tp
INNER JOIN salestypes st
ON tp.sales_type_id = st.sales_type_id 
ODER BY 

