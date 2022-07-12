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