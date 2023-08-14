
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
