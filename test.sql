SELECT product_name
FROM product;

SELECT LEFT(product_name, LOCATE('2016', product_name, 1)) AS 'Year 2016'
FROM product
WHERE product_name LIKE '%girl%'
ORDER BY product_name
LIMIT 14;