SELECT first_name, last_name, salary, dept_name
FROM employees e
	JOIN dept_emp de
    ON e.emp_no = de.emp_no
    JOIN salaries s
    ON e.emp_no = s.emp_no
    JOIN departments d
    ON de.dept_no = d.dept_no
WHERE salary = MAX(salary);