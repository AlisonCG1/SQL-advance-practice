
--Produce a report that lists every dealership, the number of purchases done by each, 
--and the number of leases done by each.
SELECT 
    s.dealership_id,
    d.business_name,
    SUM(CASE WHEN s2.sales_type_id = 1 THEN 1 ELSE 0 END) AS num_purchases,
    SUM(CASE WHEN s2.sales_type_id = 2 THEN 1 ELSE 0 END) AS num_leases
FROM 
    sales s
INNER JOIN 
    salestypes s2 ON s.sales_type_id = s2.sales_type_id
INNER JOIN 
    dealerships d ON d.dealership_id = s.dealership_id
GROUP BY 
    s.dealership_id, d.business_name;


-- Other perspective of the same issue. Instead of using case when, use COUNT to get the same results.    
SELECT 
    s.dealership_id,
    d.business_name,
    COUNT(s.sales_type_id = 1 OR NULL) AS num_purchases,
    COUNT(s.sales_type_id = 2 OR NULL) AS num_leases
FROM 
    sales s
INNER JOIN 
    salestypes s2 ON s.sales_type_id = s2.sales_type_id
INNER JOIN 
    dealerships d ON d.dealership_id = s.dealership_id
GROUP BY 
    s.dealership_id, d.business_name;   

--Produce a report that determines the most popular vehicle model that is leased.
SELECT COUNT(s2.sales_type_name) AS leased_type, v2.body_type, v2.model   
FROM sales s1
INNER JOIN salestypes s2 
ON s1.sales_type_id = s2.sales_type_id 
LEFT JOIN vehicles v 
ON s1.vehicle_id = v.vehicle_id 
INNER JOIN vehicletypes v2 
ON v.vehicle_type_id  = v2.vehicle_type_id 
WHERE s2.sales_type_name LIKE 'L%'
GROUP BY v2.body_type, v2.model
ORDER BY leased_type DESC
LIMIT 1;

--What is the most popular vehicle make in terms of number of sales?
SELECT SUM(s2.sales_type_id) AS number_of_sales, v2.make   
FROM sales s1
INNER JOIN salestypes s2 
ON s1.sales_type_id = s2.sales_type_id 
LEFT JOIN vehicles v 
ON s1.vehicle_id = v.vehicle_id 
INNER JOIN vehicletypes v2 
ON v.vehicle_type_id  = v2.vehicle_type_id 
WHERE s2.sales_type_id = 1
GROUP BY v2.make 
ORDER BY number_of_sales DESC
LIMIT 1;

--Which employee type sold the most of that make?
SELECT SUM(s2.sales_type_id) AS number_of_sales, v2.make, e2.employee_type_name    
FROM sales s1
INNER JOIN salestypes s2 
ON s1.sales_type_id = s2.sales_type_id 
LEFT JOIN vehicles v 
ON s1.vehicle_id = v.vehicle_id 
INNER JOIN vehicletypes v2 
ON v.vehicle_type_id  = v2.vehicle_type_id 
LEFT JOIN employees e 
ON s1.employee_id = e.employee_id 
INNER JOIN employeetypes e2 
ON e.employee_type_id = e2.employee_type_id 
WHERE s2.sales_type_id = 1
GROUP BY v2.make, e2.employee_type_name  
ORDER BY number_of_sales DESC
LIMIT 1;
