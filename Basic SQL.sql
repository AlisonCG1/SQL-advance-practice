-- Basic SQL Queries
SELECT * FROM Vehicles;

SELECT
    v.engine_type,
    v.floor_price,
    v.msr_price
FROM Vehicles v

SELECT business_name, 
	   city,
	   state,
	   website
FROM dealerships d 

SELECT first_name,
	   last_name,
	   email
FROM customers c 

--Filtering data
--Customers who are from Texas:
SELECT
	last_name, first_name, city, state
FROM
	customers
WHERE
	state = 'TX';
	
-- Customers who are from Houston, TX:
SELECT
	c.last_name, c.first_name, c.city, c.state
FROM
	customers c
WHERE
	c.city = 'Houston' AND state = 'TX';

--Customers who are from Texas or Tennessee:

SELECT
	c.last_name, c.first_name, c.city, c.state
FROM
	customers c
WHERE
	c.state = 'TX' OR c.state = 'TN';

--Customers who are from Texas, Tennessee or California:

SELECT
	c.last_name, c.first_name, c.city, c.state
FROM
	customers c
WHERE
	c.state IN ('TX', 'TN', 'CA');

--Customers who are from states that start with the letter C:
SELECT
	c.last_name, c.first_name, c.city, c.state
FROM
	customers c
WHERE
	c.state LIKE 'C%';

-- Customers whose last name is greater than 5 characters and first name is less than or equal to 7 characters:
SELECT
	c.last_name, c.first_name
FROM
	customers c
WHERE
	LENGTH(c.last_name) > 5 AND LENGTH(c.first_name) <= 7;

--Customers whose company name has between 10 and 20 characters (greater than or equal to 10 and less than or equal to 20):
SELECT
	c.last_name, c.first_name, c.company_name
FROM
	customers c
WHERE
	LENGTH(c.company_name) BETWEEN 10 AND 20;

--Because NULL is not equal to any value (even itself), this will not work.
SELECT
	c.last_name, c.first_name, c.company_name
FROM
	customers c
WHERE
	c.company_name = NULL;

--Instead, we do the following.
SELECT
	c.last_name, c.first_name, c.company_name
FROM
	customers c
WHERE
	c.company_name IS NULL;	

--Get a list of sales records where the sale was a lease.
SELECT s.sale_id, s.sales_type_id 
FROM sales s 
WHERE s.sales_type_id = 2;

-- Get a list of sales where the purchase date is within the last five years.
SELECT sale_id, purchase_date
FROM sales s 
WHERE purchase_date >= CURRENT_DATE - INTERVAL '5' YEAR;

--Get a list of sales where the deposit was above 5000 or the customer payed with American Express.
SELECT sale_id, deposit, payment_method 
FROM sales s
WHERE deposit > 5000 AND payment_method = 'americanexpress';

--Get a list of employees whose first names start with "M" or ends with "d"
SELECT first_name
FROM employees e 
WHERE first_name LIKE 'M%' OR first_name LIKE '%d';

--Get a list of employees whose phone numbers have the 604 area code.
SELECT employee_id, phone
FROM employees e 
WHERE phone LIKE '604%';


