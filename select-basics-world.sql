-- Completed Tutorial Exercises from SQL Zoo.
-- This tutorial will use the SELECT command
-- on the table world. 
--===========================================
-- Marjan Khamesian
-- Date: February 2021
--===========================================

-- SELECT basics
--==============
-- Q1. Show the population of Germany
SELECT population FROM world
WHERE name = 'Germany';

-- Q2. Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
SELECT name, population FROM world
WHERE name IN ('Sweden', 'Norway','Denmark');

-- Q3. Show the country and the area for countries with an area between 200000 and 250000.
SELECT name, area FROM world
WHERE area BETWEEN 200000 AND 250000;

--==================
-- SELECT from world
--==================
-- Q1. Show the name, continent and population of all countries.
SELECT name, continent, population FROM world;

-- Q2. Show the name for the countries that have a population of at least 200 million.
SELECT name FROM world
WHERE population > 200000000;

-- Q3. Give the name and the per capita GDP for those countries with a population of at least 200 million.
SELECT name, GDP/population FROM world
WHERE population > 200000000;

-- Q4. Show the name and population in millions for the countries of the continent 'South America'.
SELECT name, population/1000000 FROM world
WHERE continent IN ('South America');

-- Q5. Show the name and population for France, Germany, Italy
SELECT name, population FROM world
WHERE name IN ('France', 'Germany','Italy');

-- Q6. Show the countries which have a name that includes the word 'United'
SELECT name FROM world
WHERE name LIKE 'UNITED%';

-- Q7. Show the countries that are big by area or big by population. Show name, population and area.
SELECT name, population, area FROM world
WHERE area > 3000000 OR population > 250000000;

-- Q8. Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.
SELECT name, population, area FROM world 
WHERE ( population > 250000000 or area > 3000000 )
AND NOT ( population > 250000000 and area > 3000000 );

-- Q9. For South America show population in millions and GDP in billions both to 2 decimal places.
SELECT name, ROUND(population/1000000, 2), ROUND(GDP/1000000000, 2)
FROM world
WHERE continent = 'South America';

-- Q10. Show per-capita GDP for the trillion dollar countries to the nearest $1000.
SELECT name, ROUND(GDP/population, -3)
FROM world
WHERE GDP > 1000000000000;

-- Q11. Show the name and capital where the name and the capital have the same number of characters.
SELECT name, capital FROM world
WHERE LEN(name) = LEN(capital);

-- Q12. Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
SELECT name, capital FROM world
WHERE LEFT(name,1) = LEFT(capital,1)
AND name <> capital;

-- Q13. Find the country that has all the vowels and no spaces in its name.
SELECT name FROM world
WHERE name LIKE '%a%'
AND name LIKE '%e%'
AND name LIKE '%i%'
AND name LIKE '%o%'
AND name LIKE '%u%'
AND name NOT LIKE '% %';

