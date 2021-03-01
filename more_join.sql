-- This exercise introduces the notion of a join
--
--==============================================
-- Marjan Khamesian
-- Date: March 2021
--==============================================
--
-- JOIN - part 2
--==============

-- Q1. List the films where the yr is 1962 [Show id, title].
SELECT id, title FROM movie
WHERE yr = 1962;

-- Q2. Give year of 'Citizen Kane'.
SELECT yr FROM movie
WHERE title = 'Citizen Kane';

-- Q3. List all of the Star Trek movies, include the id, title and yr
-- (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- Q4. What id number does the actor 'Glenn Close' have?
SELECT id FROM actor
WHERE name = 'Glenn Close';

-- Q5. What is the id of the film 'Casablanca'
SELECT id FROM movie
WHERE title = 'Casablanca';

-- Q6. Obtain the cast list for 'Casablanca'. Use the id value that you obtained in the previous question.
SELECT name FROM actor
JOIN casting ON actor.id = actorid
JOIN movie ON movieid = movie.id
WHERE title = 'Casablanca';


-- Q7. Obtain the cast list for the film 'Alien'
SELECT name FROM actor
JOIN casting ON actor.id = actorid
JOIN movie ON movieid = movie.id
WHERE title = 'Alien';


-- Q8. List the films in which 'Harrison Ford' has appeared
SELECT title from movie
JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE name = 'Harrison Ford';

-- Q9. List the films where 'Harrison Ford' has appeared - but not in the starring role.
-- [Note: the ord field of casting gives the position of the actor.
-- If ord=1 then this actor is in the starring role]
SELECT title from movie
JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE name = 'Harrison Ford'
AND ord<>1;

-- Q10. List the films together with the leading star for all 1962 films.
SELECT title, name FROM movie
JOIN casting ON movieid = movie.id
JOIN actor ON actor.id = actorid
WHERE ord = 1 AND yr = 1962;

-- Q11. Which were the busiest years for 'Rock Hudson'.
-- Show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 WHERE name='John Travolta'
 GROUP BY yr) AS t
);

-- Q12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT title, name FROM movie 
JOIN casting x ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE ord = 1 AND movieid IN
(SELECT movieid FROM casting y
JOIN actor ON actor.id = actorid
WHERE name = 'Julie Andrews');

-- Q13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
SELECT name FROM actor
JOIN casting ON actorid = actor.id
WHERE ord = 1
GROUP BY actor.name
HAVING COUNT(ord)>= 15;

-- Q14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title, count(actorid) FROM movie m
JOIN casting c ON c.movieid = m.id
JOIN actor a ON c.actorid = a.id
WHERE yr = 1978
GROUP BY title
ORDER BY count(actorid) DESC,title;

-- Q15. List all the people who have worked with 'Art Garfunkel'.
SELECT name FROM actor a
JOIN casting c ON a.id = c.actorid
JOIN movie m ON m.id = c.movieid
WHERE name != 'Art Garfunkel' 
and m.id in (
SELECT movieid from casting c 
JOIN movie m ON m.id = c.movieid
JOIN actor a ON c.actorid = a.id
WHERE a.name = 'Art Garfunkel');


