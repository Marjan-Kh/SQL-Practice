-- This exercise looks at how we can use SELECT statements
-- within SELECT statements to perform more complex queries.
--=========================================================
-- Marjan Khamesian
-- Date: February 2021
--=========================================================

-- SELECT within SELECT
-- Q1. List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
WHERE population >
(SELECT population FROM world
WHERE name='Russia');

-- Q2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name FROM world
WHERE continent = 'Europe' 
AND gdp/population > 
(SELECT gdp/population FROM world
WHERE name='United Kingdom');

-- Q3. List the name and continent of countries in the continents containing either Argentina
-- or Australia. Order by name of the country.
SELECT name, continent FROM world 
WHERE continent IN 
(SELECT continent FROM world 
WHERE name IN ('Argentina', 'Australia')) 
ORDER BY name;

-- Q4. Which country has a population that is more than Canada but less than Poland?
-- Show the name and the population.
SELECT name, population FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada')
AND population < (SELECT population FROM world WHERE name = 'Poland');

-- Q5. Show the name and the population of each country in Europe.
-- Show the population as a percentage of the population of Germany.
SELECT name, CONCAT(CAST(ROUND((population*100)/(SELECT population 
                    FROM world WHERE name='Germany'), 0) as int),'%')
FROM world
WHERE population IN (SELECT population
                     FROM world
                     WHERE continent='Europe');

-- Q6. Which countries have a GDP greater than every country in Europe?
-- (Some countries may have NULL gdp values)
SELECT name FROM world
WHERE gdp > ALL(SELECT gdp FROM world
                WHERE gdp > 0 AND continent = 'Europe');

-- Q7. Find the largest country (by area) in each continent.
-- Show the continent, the name and the area.
SELECT continent, name, area FROM world x
WHERE area >= ALL (SELECT area FROM world y
                   WHERE y.continent = x.continent
                   AND area > 0);
		   
-- Q8. List each continent and the name of the country that comes first alphabetically.
SELECT continent, name FROM world x
WHERE x.name <= ALL (SELECT name FROM world y
                     WHERE x.continent = y.continent);

-- Q9. Find the continents where all countries have a population <= 25000000.
-- Then find the names of the countries associated with these continents.
-- Show name, continent and population.
SELECT name, continent, population FROM world x
WHERE 25000000 >= ALL (SELECT population FROM world y
                       WHERE x.continent = y.continent
                       AND y.population > 0);

-- Q10. Some countries have populations more than three times that of any of
-- their neighbours (in the same continent). Give the countries and continents.
SELECT name, continent FROM world x
WHERE population > ALL(SELECT population*3 FROM world y
                       WHERE x.continent = y.continent
                       AND y.name != x.name);
