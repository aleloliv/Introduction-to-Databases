-- 1. When you visit the Virtual Art Gallery DatabaseLinks to an external site.
-- and you search by Period/Style and you choose Impressionism, you get two resulting images 
-- ("Woman in the Garden" and "Irises"). What query would be used in the code here to allow the user to see these images? No join is needed. 
-- QUERY 1

USE v_art;

SELECT artfile
FROM artwork
WHERE period LIKE "impressionism";

-- 2. When you visit the Virtual Art Gallery DatabaseLinks to an external site., 
-- search by Subject and type in the word flower, you get three images. 
-- What query would have allowed the user to get those results (remember, the keyword might have been 'flowers' but they typed 'flower') .
-- QUERY 2

USE v_art;

SELECT artfile
FROM artwork aw
	JOIN artwork_keyword ak 
		ON aw.artwork_id = ak.artwork_id
	JOIN keyword kw 
		ON ak.keyword_id = kw.keyword_id
WHERE keyword LIKE '%flower%';

-- 3. List all the artists from the artist table, but only the related artwork from the artwork table. We need the first name, last name, and artwork title. 
-- QUERY 3

USE v_art;

SELECT fname, lname, title
FROM artist ar
	LEFT JOIN artwork aw
		ON ar.artist_id = aw.artist_id;
        
-- 4. List all subscriptions with the magazine name, last name, first name, and sort alphabetically by magazine name. 
-- QUERY 4

USE magazine;

SELECT magazineName, subscriberLastName, subscriberFirstName
FROM magazine m
	JOIN subscription son
		ON m.magazineKey = son.magazineKey
	JOIN subscriber ser
		ON son.subscriberKey = ser.subscriberKey
ORDER BY magazineName;

-- 5.  List all the magazines that Samantha Sanders subscribes to. 

USE magazine;

SELECT magazineName
FROM magazine m
	JOIN subscription son
		ON m.magazineKey = son.magazineKey
	JOIN subscriber ser
		ON son.subscriberKey = ser.subscriberKey
WHERE subscriberFirstName = "Samantha" AND subscriberLastName = "Sanders";

-- 6. List the first five employees from the Customer Service Department. Put them in alphabetical order by last name.

USE employees;

SELECT first_name, last_name
FROM employees e
	JOIN dept_emp de
		ON e.emp_no = de.emp_no
	JOIN departments d
		ON de.dept_no = d.dept_no
WHERE dept_name = "Customer Service"
ORDER BY last_name
LIMIT 5;

-- 7. Find out the current salary and department of Berni Genin. You can use the ORDER BY and LIMIT to get just the most recent salary.

USE employees;

SELECT first_name, last_name, dept_name, salary, de.from_date
FROM employees e
	JOIN dept_emp de
		ON e.emp_no = de.emp_no
	JOIN departments d
		ON de.dept_no = d.dept_no
	JOIN salaries s
		ON e.emp_no = s.emp_no
WHERE first_name = "Berni" AND last_name = "Genin"
ORDER BY salary DESC
LIMIT 1;