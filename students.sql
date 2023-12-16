USE datawinter;

SELECT * FROM student;

SELECT lname, fname, major
FROM student
WHERE major = 'CIT'
ORDER BY lname;

SELECT lname, fname
FROM student
WHERE worry_category = 'family';

SELECT worry_category, COUNT(*)
FROM student
GROUP BY worry_category
ORDER BY COUNT(*) DESC;