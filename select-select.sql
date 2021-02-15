-- Completed Tutorial Exercises from SQL Zoo.
-- This tutorial looks at how we can use SELECT statements
-- within SELECT statements to perform more complex queries
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

-- Q3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent FROM world 
WHERE continent IN 
(SELECT continent FROM world 
WHERE name IN ('Argentina', 'Australia')) 
ORDER BY name;

-- Q4. Which country has a population that is more than Canada but less than Poland? Show the name and the population.
SELECT name, population FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada')
AND population < (SELECT population FROM world WHERE name = 'Poland');



