-- This exercise introduces JOIN which allows
-- to use data from two or more tables.
--
--===========================================
-- Marjan Khamesian
-- Date: February 2021
--===========================================
--
-- JOIN
--======

-- Q1. Show the matchid and player name for all goals scored by Germany.
SELECT matchid, player FROM goal 
WHERE teamid ='GER';

-- Q2. Show id, stadium, team1, team2 for just game 1012.
SELECT id, stadium, team1, team2 FROM game
WHERE id ='1012';

-- Q3. Show the player, teamid, stadium and mdate for every German goal.
-- ( Combining the two steps into a single query with a JOIN )
SELECT player, teamid, stadium, mdate FROM game
JOIN goal ON (id = matchid AND teamid='GER');

-- Q4. Show the team1, team2 and player for every goal scored by a player called Mario.
SELECT team1, team2, player FROM game
JOIN goal ON (id = matchid AND player LIKE 'Mario%');

-- Q5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes.
SELECT player, teamid, coach, gtime FROM goal
JOIN eteam ON teamid = id WHERE gtime <= 10;

-- Q6. List the dates of the matches and the name of the team in which
-- 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname FROM game
JOIN eteam ON (team1 = eteam.id AND coach LIKE '%Santos');

-- Q7. List the player for every goal scored in a game where
-- the stadium was 'National Stadium, Warsaw'
SELECT player FROM goal
JOIN game ON (id = matchid AND stadium = 'National Stadium, Warsaw');

-- Q8. Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT(player) FROM game
JOIN goal ON matchid = id
WHERE ((team1 = 'GER' OR team2 = 'GER') AND teamid != 'GER');

-- Q9. Show teamname and the total number of goals scored.
SELECT teamname, COUNT(player) FROM eteam
JOIN goal ON id = teamid
GROUP BY teamname;

-- Q10. Show the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(player) AS goals FROM game
JOIN goal ON (id = matchid)
GROUP BY stadium;

-- Q11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, COUNT(player) AS goals FROM game
JOIN goal ON (matchid = id AND (team1 = 'POL' OR team2 = 'POL'))
GROUP BY matchid, mdate;

-- Q12. For every match where 'GER' scored, show matchid, match date and
-- the number of goals scored by 'GER'
SELECT id, mdate, COUNT(player) FROM game
JOIN goal ON (id = matchid AND (team1 = 'GER' OR team2 = 'GER') AND teamid='GER')
GROUP BY id, mdate;

-- Q13. List every match with the goals scored by each team as shown. 
-- mdate	team1	score1	team2	score2
-- 1 July 2012	ESP	4	ITA	0
-- 10 June 2012	ESP	1	ITA	1
-- 10 June 2012	IRL	1	CRO	3
-- ...
-- Sort your result by mdate, matchid, team1 and team2.
SELECT mdate,
       team1, SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) score1, 
       team2, SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) score2
FROM game ga LEFT OUTER JOIN goal go ON (ga.id= go.matchid)
GROUP BY mdate, team1, team2;
