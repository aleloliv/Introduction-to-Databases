USE world;

SELECT Name, Population
FROM country
WHERE Population < 5000000
ORDER BY Population DESC;

-- -----------------------------------------------------
USE world;

SELECT DISTINCT(Language) AS "Unique Languages"
FROM countrylanguage
GROUP BY Language
ORDER BY Language;

-- ------------------------------------------------------
USE world;

SELECT DISTINCT(Continent) AS Continents, COUNT(Name) AS "Number of Countries"
FROM country
GROUP BY Continent;

-- ------------------------------------------------------
USE world;

SELECT co.Name AS "Country Name", AVG(city.Population) AS "Average Population of City"
FROM country co
	JOIN city
		ON Code = CountryCode
GROUP BY CountryCode
ORDER BY AVG(city.Population) DESC;





