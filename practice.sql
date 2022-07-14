USE store;
SELECT customer_id, firname;
SELECT * -- select everythin 
FROM customers -- select the table you want to query
WHERE customer_id = 1
ORDER BY first_name -- sort the orders



SELECT 
	last_name, 
	first_name, 
	points + 10 AS discount_factor -- can do math calculation, AS is give it a name

FROM customers -- select the table you want to query



SELECT DISTINCT state -- remove duplicated 
FROM customers



-- return all products
-- name
-- unit price
-- new price (unit price * 1.1)

SELECT name, unit_price, unit_price * 1.1 AS new_price
FROM products



SELECT *
FROM Customers
WHERE points > 3000


SELECT *
FROM Customers
WHERE state = 'VA'


SELECT *
FROM Customers
WHERE birth_date > '1990-01-01' -- always quote date


-- get the orders placed this yr
SELECT *
FROM orders
WHERE order_date >= '2019-01-01'


SELECT *
FROM orders
WHERE order_date >= '2019-01-01' AND points > 1000
WHERE order_date >= '2019-01-01' OR points > 1000
WHERE order_date >= '2019-01-01' OR points > 1000 AND state = 'VA'
-- AND is always runs first


SELECT *
FROM orders
WHERE order_date >= '2019-01-01' AND points > 1000
WHERE order_date >= '2019-01-01' OR points > 1000
WHERE order_date >= '2019-01-01' OR (points > 1000 AND state = 'VA')
-- use ( ) to prioritize the query


SELECT *
FROM orders
WHERE NOT order_date >= '2019-01-01' OR points > 1000 
-- not is not easy to read




-- From the order_items table, get the items 
-- for order #6
-- where the total price is greater than 30
SELECT *
FROM order_items
WHERE order_id = 6 AND unit_price * quantity > 30



SELECT *
FROM Customers
WHERE state = 'VA' OR state = 'GA' OR state = 'FL'


SELECT *
FROM Customers
WHERE state = 'VA' OR state = 'GA' OR state = 'FL'
-- simplified
WHERE state IN ('VA', 'FL', 'GA')
WHERE state  NOT IN ('VA', 'FL', 'GA')



SELECT *
FROM products
WHERE quantity_in_stock IN (49,38, 72) 


SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000


-- return born bw 1990 and 2000
SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01'


SELECT *
FROM customers
WHERE last_name LIKE 'b%' -- start with b, use % to indicate any number of characters


WHERE last_name LIKE '%b%' -- means having b at somewhere
WHERE last_name LIKE '%b' -- means having b at last
WHERE last_name LIKE '_b' -- means with two exact characters and last is b, ____ for more
-- % to present any # of characters
-- _ to present single character



-- get the customers whose address contain TRAIL or AVENUE
SELECT * 
FROM customers
WHERE address LIKE '%trail%' OR -- anywhere has trail
	  address LIKE '%avenue%'


-- phone # end with 9
SELECT * 
FROM customers
WHERE address LIKE '%9'

SELECT * 
FROM customers
WHERE address NOT LIKE '%9'



SELECT * 
FROM customers
WHERE last_name LIKE '%field%'
WHERE last_name REGEXP 'field' -- exact like above
WHERE last_name REGEXP '^field' -- ^ means begining of the string, must start with field
WHERE last_name REGEXP 'field$' -- lastname must ends with field
WHERE last_name REGEXP 'field|mac'
WHERE last_name REGEXP '^field|mac|rose'
WHERE last_name REGEXP '[gim]e' -- match any of the characters that's ge, ie, me
WHERE last_name REGEXP 'e[fmq]'
WHERE last_name REGEXP '[a-h]e' -- any char from a to h
-- ^ beginning
-- $ end
-- | logical or
-- [abcd]
-- [a-f]



--get the customers whose
--first names are ELKA or AMBUR
SELECT *
FROM customers
WHERE first_name REGEXP 'elka|ambur'

--last name end with EY or ON
SELECT *
FROM customers
WHERE first_name REGEXP 'ey$|on$'

--last names start with MY or contains SW
SELECT *
FROM customers
WHERE first_name REGEXP '^my|se'

--last names contain B followed by R or U
SELECT *
FROM customers
WHERE first_name REGEXP 'b[ru]'



--The is null operator
SELECT *
FROM customers
WHERE phone IS NULL


--GET THE ORDERS THAT ARE NOT SHIPPED
SELECT *
FROM orders
WHERE shipped_date IS NULL

--1:15:00 talks about the relation bw database

--customer_id is the default column
--sort by other column
SELECT * 
FROM customers
ORDER BY first_name
ORDER BY first_name DESC --descending order
ORDER BY state, first_name --if two same states, sort by first_name

SELECT first_name, last_name, 10 AS points --AS alias (not an actual thing in data)
FROM customers
ORDER BY points, birth_date
ORDER BY 1, 2 -- (first_name, last_name, try to avoid this)



SELECT *
FROM order_items
WHERE order_id = 2
ORDER BY quantity * unit_price DESC --sort by total price

SELECT *, quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC --sort by total price


--how to mimic records returned from the query
SELECT * 
FROM customers
LIMIT 300

-- if we have customer on different pagination
SELECT * 
FROM customers
LIMIT 6 ,3 --skip first 6 records then pick 3 records (7,8,9)


-- get the top three loyal customers
SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3 -- should always be at the end



SELECT order_id, orders.customer_id, first_name, last_name --select only order id, first name, last name
--important needs to specify customer_id from order or customer
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
-- join orders table with customers table, and make sure customers on ...order id = ...customer.id

SELECT order_id, o.customer_id, first_name, last_name 
FROM orders o --o is the alias 
JOIN customers c
	ON o.customer_id = c.customer_id




SELECT order_id, oi.product_id, quantity, oi.unit_price -- because product_id appear both tables, need to add oi
FROM order_items oi --select evetythings from items, oi is the alias
JOIN products p ON oi.product_id = p.product_id -- and joining with products table



--combine tables across from multiple data bases
SELECT *
FROM order_items oi 
JOIN sql_inventory.products p --different database, need to add sql_ before
	ON oi.product_id = p.product_id



-- find manager
USE sql_hr;
SELECT 
	e.employee_id,
	e.first_name,
	m.first_name AS manager
FROM employees e --select everything from employee table
JOIN employees m-- join the table by itself so can find manager
 ON e.reports_to = m.employee_id


-- more than two tables
SELECT 
	o.order_id,
	o.order_date,
	c.first_name,
	c.last_name,
	os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id


USE sql_invoicing;

SELECT *
FROM payments p
JOIN clients c
	ON p.client_id = c.client_id



USE sql_invoicing;

SELECT 
	p.date,
	p.invoice_id,
	p.amount
FROM payments p
JOIN clients c
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON p.payment_methods = pm.payment_method_id



--1:47:00, talks about compound order keys
SELECT *
FROM order_items oi --table
JOIN order_item_notes oin --table
	ON oi.order_id = oin.order_id
	AND oi.product_id = oin.product_id --compound join condition


--implicity join syntax
SELECT *
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id


--implicity join syntax, implemented (not recommend)
SELECT * 
FROM orders o, customers c
WHERE o.customer_id = c.customer_id


--outer join

--inner join
SELECT 
	c.customer_id,
	c.first_name,
	o.order_id
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id

--outer, to see customer whether they have an order or not
SELECT 
	c.customer_id,
	c.first_name,
	o.order_id
FROM customers c
LEFT JOIN orders o -- from the left point our customer is returned regardless condition is true or not (showing null)
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id

--practice
SELECT 
	p.product_id,
	p.name,
	oi.quantity
FROM products p
LEFT JOIN order_items oi
	ON p.product_id = oi.product_id

SELECT 
	p.product_id,
	p.name,
	oi.quantity,
	sh.name AS shipper
FROM products p
LEFT JOIN order_items oi
	ON p.product_id = oi.product_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id


--exercise
SELECT 
	o.order_id,
	o.order_date,
	c.first_name AS customer
	sh.name AS shipper
	os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
JOIN order_statuses os
	ON o.status = os.order_status_id


--self join
USE sql_hr;

SELECT
	e.employee_id,
	e.first_name,
	m.first_name AS manager
FROM employees e
LEFT JOIN employees m
	ON e.reports_to = m.employee_id

--if with same column
SELECT
	o.order_id,
	c.first_name,
	sh.name AS shipper
FROM orders o
JOIN customers c
	--ON o.customer_id = c.customer_id
	USING (customer_id)
LEFT JOIN shippers sh
	USING (shipper_id) --only to use if the column name is exact the same across tables


--
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	USING (order_id, product_id)


--exercise
USE sql_invoicing;

SELECT 
	p.date,
	c.name AS client,
	p.amount,
	pm.name AS payment_method
FROM payments p
JOIN clients c USING (client_id)
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id

--NATURAL JOIN (not recommeneded)
SELECT 
	o.order_id,
	c.first_name
FROM orders o
NATURAL JOIN customers c --nature join, we don't explicit look at data name, join on columns have the same name


--Cross Join
SELECT *
FROM customers c
CROSS JOIN products p --every record in customer table will be combined with products table

--exercie
--Do a cross join bw shippers and products
--using the implicit syntax
--and then using the explicit syntax

--implicit
SELECT
	sh.name AS shipper,
	p.name AS product
FROM shippers sh, products p --combination of all shippers and all products
ORDER BY sh.name

--explicit
SELECT
	sh.name AS shipper,
	p.name AS product
FROM shippers sh
CROSS JOIN products p 
ORDER BY sh.name


--unions
SELECT 
	order_id,
	order_date,
	'Active' AS status --give it an active column showing active
FROM orders
WHERE order_date >= '2019-01-01';
UNION --combine up and down
SELECT 
	order_id,
	order_date,
	'Archived' AS status --give it an active column showing active
FROM orders
WHERE order_date < '2019-01-01'

-- remember, UNION needs two result to have same columnd #


--Exercise
SELECT customer_id, first_name, points, 'Bronze' AS type
FROM customers
WHERE points < 2000
UNION
SELECT customer_id, first_name, points, 'Silver' AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT customer_id, first_name, points, 'Gold' AS type
FROM customers
WHERE points > 3000
ORDER BY first_name



--2:27:00 explains what tool icon is 


-- insert a single row into table
INSERT INTO customers (
	first_name, 
	last_name, 
	birth_date,
	address,
	city,
	state
	) --inside () is the column u want to insert values into, this is only example; no enough columns to match below
VALUES (
	DEFAULT, 
	'John', 
	'Smith', 
	'1990-01-01',
	NULL,
	'address',
	'city',
	'CA',
	DEFAULT
	) --Default means let SQL generates an unique id for you (AL is selected)


	--insert multiple rows
	INSERT INTO shippers (name)
	VALUES ('Shipper1'),
		   ('Shipper2'),
		   ('Shipper3'),


--exercise 
--insert three rows in the products table
INSERT INTO products (name, quantity_in_stock, unit_price)
VALUES ('Product1', 10, 1.95),
	   ('Product2', 11, 1.95),
	   ('Product3', 12, 1.95),


--insert hierarchical rows
--parent/child relationship, orders-table is the parent, order-items is the child
INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-02', 1);

INSERT INTO order_items
VALUES 
	(LAST_INSERT_ID(), 1, 1, 2.95),
	(LAST_INSERT_ID(), 2, 1, 3.95),
--SELECT LAST_INSERT_ID() --need to know the ID for the column we just insert
