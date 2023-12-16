USE v_art;

SELECT * FROM artwork;

SELECT title, period, artyear
FROM artwork
WHERE artyear > 1800 AND artyear < 1900;

-- another way to get a filter with range

SELECT title, period, artyear
FROM artwork
WHERE artyear BETWEEN 1800 AND 1900;

SELECT title, period
FROM artwork
WHERE period IN ('Modern', 'Baroque', 'Impressionism');

SELECT title, period
FROM artwork
WHERE period LIKE '_ost-Impression%';

SELECT title, period
FROM artwork
WHERE title REGEXP 'the|in|on';

SELECT fname AS Frist, mname AS Middle, lname AS Last
FROM artist
WHERE mname IS NULL
ORDER BY Middle;

USE bike;

SELECT * FROM product;

SELECT product_name, model_year, list_price + 100 AS marked_up, list_price
FROM product
WHERE list_price + 100 > 1000
ORDER BY marked_up;

SELECT product_name, model_year
FROM product
WHERE (product_name LIKE 'Trek%' OR product_name LIKE 'Surly%') AND model_year <> 2016;

SELECT * FROM customer;

SELECT first_name, last_name, phone, email
FROM customer
WHERE email LIKE '%gmail.com';

SELECT product_name, brand_id, list_price, list_price - (list_price * 0.2) AS Discount_Price
FROM product
WHERE brand_id = 2;

SELECT cust_order_id, order_date, store_id, staff_id
FROM cust_order
WHERE store_id = 1 AND staff_id <> 2;

SELECT cust_order_id, order_date
FROM cust_order
WHERE order_date LIKE '2017-02-%';

SELECT product_name
FROM product
WHERE product_name LIKE '%Frame%' OR product_name LIKE '%Women%';

SELECT product_name, list_price
FROM product
WHERE product_name < 'I' AND list_price >= 299.99
ORDER BY product_name;

SELECT * FROM store;

SELECT * FROM staff;

SELECT * FROM cust_order;

SELECT product_name, list_price FROM product
WHERE product_name between 'A' and 'H' AND list_price >= 299.99
ORDER BY product_name;