--  Window functions
-- What is the most popular vehicle make in terms of number of sales?

SELECT  *
FROM vehicles v 

SELECT *
FROM sales 

SELECT *
FROM vehicletypes vt

WITH popular_vehicle AS 
( 
	SELECT vt.make, s.sale_id, s.price
	FROM vehicletypes vt
	INNER JOIN vehicles v 
	ON v.vehicle_type_id = vt.vehicle_type_id
	INNER JOIN sales s 
	ON v.vehicle_id = s.vehicle_id

)