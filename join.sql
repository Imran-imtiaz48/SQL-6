-- 1. All goals by Germany
SELECT matchid, player
FROM goal
WHERE teamid = 'GER';

-- 2. Game info for match with player like '%Bender'
SELECT id, stadium, team1, team2
FROM game
WHERE id = (
    SELECT matchid
    FROM goal
    WHERE player LIKE '%Bender'
);

-- 3. German players with match details
SELECT go.player, go.teamid, g.stadium, g.mdate
FROM goal AS go
JOIN game AS g ON go.matchid = g.id
JOIN eteam AS e ON e.id = go.teamid
WHERE e.teamname = 'Germany';

-- 4. Matches where a player named 'Mario%' scored
SELECT g.team1, g.team2, go.player
FROM game AS g
JOIN goal AS go ON g.id = go.matchid
WHERE go.player LIKE 'Mario%';

-- 5. Goals scored in first 10 minutes
SELECT go.player, go.teamid, e.coach, go.gtime
FROM goal AS go
JOIN eteam AS e ON go.teamid = e.id
WHERE go.gtime <= 10;

-- 6. Matches coached by Fernando Santos
SELECT g.mdate, e.teamname
FROM game AS g
JOIN eteam AS e ON g.team1 = e.id
WHERE e.coach = 'Fernando Santos';

-- 7. Players who scored at 'National Stadium, Warsaw'
SELECT go.player
FROM goal AS go
JOIN game AS g ON go.matchid = g.id
WHERE g.stadium LIKE 'National Stadium, W%';

-- 8. Players who scored against Germany
SELECT DISTINCT go.player
FROM goal AS go
JOIN game AS g ON go.matchid = g.id
WHERE (g.team1 = 'GER' OR g.team2 = 'GER')
  AND go.teamid != 'GER';

-- 9. Goals per team
SELECT e.teamname, COUNT(*) AS goals
FROM eteam AS e
JOIN goal AS go ON e.id = go.teamid
GROUP BY e.teamname;

-- 10. Goals per stadium
SELECT g.stadium, COUNT(*) AS goals
FROM game AS g
JOIN goal AS go ON g.id = go.matchid
GROUP BY g.stadium;

-- 11. Goals in matches involving Poland
SELECT g.id, g.mdate, COUNT(*) AS goals
FROM game AS g
JOIN goal AS go ON g.id = go.matchid
WHERE g.team1 = 'POL' OR g.team2 = 'POL'
GROUP BY g.id, g.mdate;

-- 12. Germany goals in Germany matches
SELECT go.matchid, g.mdate, COUNT(*) AS goals
FROM goal AS go
JOIN game AS g ON go.matchid = g.id
WHERE (g.team1 = 'GER' OR g.team2 = 'GER')
  AND go.teamid = 'GER'
GROUP BY go.matchid, g.mdate;

-- 13. Match results with calculated scores
SELECT g.mdate, 
       g.team1, 
       SUM(CASE WHEN go.teamid = g.team1 THEN 1 ELSE 0 END) AS score1,
       g.team2,
       SUM(CASE WHEN go.teamid = g.team2 THEN 1 ELSE 0 END) AS score2
FROM game AS g
LEFT JOIN goal AS go ON g.id = go.matchid
GROUP BY g.mdate, g.team1, g.team2
ORDER BY g.mdate, g.team1, g.team2;

-- QUIZ ANSWERS

-- Q3. Non-Greek scorers in Greek matches
SELECT go.player, go.teamid, COUNT(*) AS goals
FROM game AS g
JOIN goal AS go ON go.matchid = g.id
WHERE (g.team1 = 'GRE' OR g.team2 = 'GRE')
  AND go.teamid != 'GRE'
GROUP BY go.player, go.teamid;

-- Q4. Teams scoring on 9 June 2012
SELECT DISTINCT go.teamid, g.mdate
FROM goal AS go
JOIN game AS g ON go.matchid = g.id
WHERE g.mdate = '9 June 2012';

-- Q5. Non-Polish scorers in Polish matches at Warsaw stadium
SELECT DISTINCT go.player, go.teamid
FROM game AS g
JOIN goal AS go ON go.matchid = g.id
WHERE g.stadium = 'National Stadium, Warsaw'
  AND (g.team1 = 'POL' OR g.team2 = 'POL')
  AND go.teamid != 'POL';

-- Q6. Scorers in Wroclaw stadium excluding Italy matches
SELECT DISTINCT go.player, go.teamid, go.gtime
FROM game AS g
JOIN goal AS go ON go.matchid = g.id
WHERE g.stadium = 'Stadion Miejski (Wroclaw)'
  AND (
       (go.teamid = g.team2 AND g.team1 != 'ITA') 
       OR 
       (go.teamid = g.team1 AND g.team2 != 'ITA')
      );

-- Q7. Teams with less than 3 goals
SELECT e.teamname, COUNT(*) AS goals
FROM eteam AS e
JOIN goal AS go ON go.teamid = e.id
GROUP BY e.teamname
HAVING COUNT(*) < 3;
