--This query puts into practice JOINS.

--Get a list of the sales that were made for each sales type.
SELECT s.sale_id, s2.sales_type_id
FROM sales s
INNER JOIN salestypes s2 
ON s.sales_type_id = s2.sales_type_id;

--Get a list of sales with the VIN of the vehicle, the first name and last name of the customer, 
--first name and last name of the employee who made the sale and the name, 
--city and state of the dealership.
SELECT s.sale_id, v.vin, c.first_name, c.last_name, c.city, c.email, c.state, s.dealership_id  
FROM vehicles v
INNER JOIN sales s
ON v.vehicle_id = s.vehicle_id 
INNER JOIN customers c 
ON s.customer_id = c.customer_id; 

--Get a list of all the dealerships and the employees, if any, working at each one.
SELECT *
FROM dealershipemployees d 
INNER JOIN employees e 
ON d.employee_id = e.employee_id;

--Get a list of vehicles with the names of the body type, make, model and color.
SELECT v1.vehicle_id, v1.exterior_color, v2.body_type, v2.make, v2.model  
FROM vehicles v1
RIGHT JOIN vehicletypes v2 
ON v1.vehicle_type_id = v2.vehicle_type_id; 