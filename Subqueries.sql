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
SELECT 
    s.vehicle_id,
    s.customer_id,
    s.sales_type_id,
    SUM(s1.deposit) AS total_deposit
FROM 
    sales s
JOIN 
    sales s1 ON s.sales_type_id = s1.sales_type_id
GROUP BY 
    s.vehicle_id, s.customer_id, s.sales_type_id;
   
   

