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
    SELECT vt.make, SUM(s.price) AS total_sales
    FROM vehicletypes vt
    INNER JOIN vehicles v ON v.vehicle_type_id = vt.vehicle_type_id
    INNER JOIN sales s ON v.vehicle_id = s.vehicle_id
    GROUP BY vt.make
)

SELECT pv.make, RANK() OVER (ORDER BY pv.total_sales DESC) AS sales_rank
FROM popular_vehicle AS pv;