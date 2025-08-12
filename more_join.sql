-- 1. Movies from 1962
SELECT id, title
FROM movie AS m
WHERE yr = 1962;

-- 2. Year of 'Citizen Kane'
SELECT yr
FROM movie AS m
WHERE title = 'Citizen Kane';

-- 3. All 'Star Trek' movies by year
SELECT id, title, yr
FROM movie AS m
WHERE title LIKE 'Star Trek%'
ORDER BY yr;

-- 4. Actor ID for 'Glenn Close'
SELECT id
FROM actor AS a
WHERE name = 'Glenn Close';

-- 5. Movie ID for 'Casablanca'
SELECT id
FROM movie AS m
WHERE title = 'Casablanca';

-- 6. Actors in movie with ID 11768
SELECT a.name
FROM casting AS c
JOIN actor AS a ON a.id = c.actorid
WHERE c.movieid = 11768;

-- 7. Actors in 'Alien'
SELECT a.name
FROM casting AS c
JOIN actor AS a ON a.id = c.actorid
JOIN movie AS m ON m.id = c.movieid
WHERE m.title = 'Alien';

-- 8. Movies with 'Harrison Ford'
SELECT m.title
FROM movie AS m
JOIN casting AS c ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE a.name = 'Harrison Ford';

-- 9. Movies with 'Harrison Ford' but not as lead
SELECT m.title
FROM movie AS m
JOIN casting AS c ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE a.name = 'Harrison Ford'
  AND c.ord <> 1;

-- 10. Lead actors in 1962 movies
SELECT m.title, a.name
FROM movie AS m
JOIN casting AS c ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE m.yr = 1962
  AND c.ord = 1;

-- 11. Years where Rock Hudson acted in more than 2 movies
SELECT m.yr, COUNT(m.title) AS movie_count
FROM movie AS m
JOIN casting AS c ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE a.name = 'Rock Hudson'
GROUP BY m.yr
HAVING COUNT(m.title) > 2;

-- 12. Movies where Julie Andrews was in the cast, showing their leads
SELECT m.title, a.name
FROM movie AS m
JOIN casting AS c ON m.id = c.movieid AND c.ord = 1
JOIN actor AS a ON a.id = c.actorid
WHERE m.id IN (
    SELECT c.movieid
    FROM casting AS c
    JOIN actor AS a ON a.id = c.actorid
    WHERE a.name = 'Julie Andrews'
);

-- 13. Actors with more than 14 lead roles
SELECT a.name
FROM actor AS a
JOIN casting AS c ON a.id = c.actorid
WHERE c.ord = 1
GROUP BY a.name
HAVING COUNT(*) > 14
ORDER BY a.name;

-- 14. Movies in 1978 with actor count, sorted
SELECT m.title, COUNT(*) AS co
FROM casting AS c
JOIN actor AS a ON c.actorid = a.id
JOIN movie AS m ON m.id = c.movieid
WHERE m.yr = 1978
GROUP BY m.title
ORDER BY co DESC, m.title;

-- 15. Co-actors of Art Garfunkel
SELECT a.name
FROM actor AS a
JOIN casting AS c ON a.id = c.actorid
JOIN movie AS m ON m.id = c.movieid
WHERE m.id IN (
    SELECT m.id
    FROM movie AS m
    JOIN casting AS c ON m.id = c.movieid
    JOIN actor AS a ON c.actorid = a.id
    WHERE a.name = 'Art Garfunkel'
)
AND a.name != 'Art Garfunkel';

-- QUIZ

-- Q1. Actors who directed a movie where gross < budget
SELECT a.name
FROM actor AS a
JOIN movie AS m ON a.id = m.director
WHERE m.gross < m.budget;

-- Q2. All actors and their movies
SELECT *
FROM actor AS a
JOIN casting AS c ON a.id = c.actorid
JOIN movie AS m ON m.id = c.movieid;

-- Q3. Actors named 'John%' and their movie counts
SELECT a.name, COUNT(c.movieid) AS movie_count
FROM casting AS c
JOIN actor AS a ON c.actorid = a.id
WHERE a.name LIKE 'John %'
GROUP BY a.name
ORDER BY movie_count DESC;

-- Q4. Movies where Paul Hogan was the lead
SELECT m.title
FROM movie AS m
JOIN casting AS c ON m.id = c.movieid
JOIN actor AS a ON c.actorid = a.id
WHERE a.name = 'Paul Hogan'
  AND c.ord = 1;

-- Q5. Lead actors for movies directed by actor with ID 351
SELECT a.name
FROM movie AS m
JOIN casting AS c ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE c.ord = 1
  AND m.director = 351;

-- Q6. Linking director to actor and casting to movie/actor
-- (Relationship explanation; not a query)

-- Q7. Robert De Niro’s movies where he was the 3rd billed actor
SELECT m.title, m.yr
FROM movie AS m
JOIN casting AS c ON m.id = c.movieid
JOIN actor AS a ON c.actorid = a.id
WHERE a.name = 'Robert De Niro'
  AND c.ord = 3;
