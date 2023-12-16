-- 1. Get the average quantity that we have in all our bike stocks. Round to the nearest whole number. 
-- QUERY 1

USE bike;

SELECT ROUND(AVG(quantity),0) AS "Stock Average"
FROM stock;

-- 2. Show each bike that needs to be reordered.
-- Filter the results to only the lowest quantity of zero.
-- Order by product_name The image below show the first 12 of 24 rows total.
-- You don't need to use a LIMIT.  (Hint for this one: Two different stores have the same bike that needs to be reordered. You only need it to show up once.)
-- QUERY 2

USE bike;

SELECT product_name
FROM product p 
	JOIN stock s
		ON p.product_id = s.product_id
WHERE quantity = 0
GROUP BY product_name
ORDER BY product_name;

-- 3. How many of each category of bikes do we have in our "Baldwin Bikes" store, which has the store_id of 2.
-- We need to see the name of the category as well as the number of bikes in the category. Sort it by lowest numbers first. 
-- QUERY 3

USE bike;

SELECT category_name, COUNT(quantity) AS instock
FROM category c 
	JOIN product p
		ON p.category_id = c.category_id
	JOIN stock s
		ON p.product_id = s.product_id
WHERE store_id = 2
GROUP BY p.category_id
ORDER BY instock;

-- 4. How many employees do we have? (3 points)
-- QUERY 4

USE employees;

SELECT COUNT(emp_no) AS "Number of Employees"
FROM employees;

-- 5. Get the average salaries in each department.
-- We only need those departments that have average salaries that are below 60,000.
-- Format the salary to 2 decimal places and a comma in the thousands place. 
-- QUERY 5

USE employees;

SELECT dept_name, FORMAT(AVG(salary), 2) AS average_salary
FROM departments d
	JOIN dept_emp de
		ON d.dept_no = de.dept_no
	JOIN salaries s
		ON s.emp_no = de.emp_no
GROUP BY d.dept_no
HAVING average_salary < "60,000";

-- 6. Find out how many females work in each department. Sort by department name.
-- QUERY 6

USE employees;

SELECT dept_name, COUNT(e.emp_no) AS "Number of Females"
FROM departments d
	JOIN dept_emp de
		ON d.dept_no = de.dept_no
	JOIN employees e
		ON de.emp_no = e.emp_no
WHERE gender = 'F'
GROUP BY dept_name
ORDER BY dept_name;