-- All Nobel Prize winners from 1950
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;

-- Winner of the Literature prize in 1962
SELECT winner
FROM nobel
WHERE yr = 1962
  AND subject = 'Literature';

-- Years and subjects where the winner's name starts with "Albert E"
SELECT yr, subject
FROM nobel
WHERE winner LIKE 'Albert E%';

-- Peace prize winners from 2000 onward
SELECT winner
FROM nobel
WHERE subject = 'Peace'
  AND yr >= 2000;

-- Literature prizes in the 1980s
SELECT *
FROM nobel
WHERE subject = 'Literature'
  AND yr BETWEEN 1980 AND 1989;

-- Specific US presidents who won Nobel Prizes
SELECT *
FROM nobel
WHERE winner IN (
  'Theodore Roosevelt',
  'Woodrow Wilson',
  'Jimmy Carter',
  'Barack Obama'
);

-- Winners whose names start with "John"
SELECT winner
FROM nobel
WHERE winner LIKE 'John %';

-- Physics in 1980 or Chemistry in 1984
SELECT *
FROM nobel
WHERE (subject = 'Physics' AND yr = 1980)
   OR (subject = 'Chemistry' AND yr = 1984);

-- All 1980 prizes except Chemistry and Medicine
SELECT *
FROM nobel
WHERE subject NOT IN ('Chemistry', 'Medicine')
  AND yr = 1980;

-- Medicine before 1910 or Literature from 2004 onward
SELECT *
FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910)
   OR (subject = 'Literature' AND yr >= 2004);

-- Winners starting with "PETER GR"
SELECT *
FROM nobel
WHERE winner LIKE 'PETER GR%';

-- Winners starting with "EUGENE O"
SELECT *
FROM nobel
WHERE winner LIKE 'EUGENE O%';

-- Winners starting with "Sir", ordered by year descending then name
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner;

-- Winners from 1984, ordering Physics and Chemistry first
SELECT winner, subject
FROM nobel
WHERE yr = 1984
ORDER BY subject IN ('Physics', 'Chemistry'),
         subject,
         winner;

--------------------------------------
-- QUIZ QUERIES
--------------------------------------

-- 1. Winners starting with C and ending with n
SELECT winner
FROM nobel
WHERE winner LIKE 'C%'
  AND winner LIKE '%n';

-- 2. Count Chemistry prizes from 1950 to 1960
SELECT COUNT(subject) AS chemistry_count
FROM nobel
WHERE subject = 'Chemistry'
  AND yr BETWEEN 1950 AND 1960;

-- 3. Count distinct years with no Medicine prize
SELECT COUNT(DISTINCT yr) AS years_without_medicine
FROM nobel
WHERE yr NOT IN (
  SELECT DISTINCT yr
  FROM nobel
  WHERE subject = 'Medicine'
);

-- 4. Winners with "Sir" in the 1960s
SELECT subject, winner
FROM nobel
WHERE winner LIKE 'Sir%'
  AND yr BETWEEN 1960 AND 1969;

-- 5. Years without Chemistry or Physics prizes
SELECT yr
FROM nobel
WHERE yr NOT IN (
  SELECT yr
  FROM nobel
  WHERE subject IN ('Chemistry', 'Physics')
);

-- 6. Years with Medicine but without Literature or Peace
SELECT DISTINCT yr
FROM nobel
WHERE subject = 'Medicine'
  AND yr NOT IN (
    SELECT yr FROM nobel WHERE subject = 'Literature'
  )
  AND yr NOT IN (
    SELECT yr FROM nobel WHERE subject = 'Peace'
  );

-- 7. Count prizes by subject for 1960
SELECT subject, COUNT(subject) AS prize_count
FROM nobel
WHERE yr = 1960
GROUP BY subject;
