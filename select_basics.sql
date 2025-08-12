-- Population of Germany
SELECT population 
FROM world
WHERE name = 'Germany';

-- Population of Sweden, Norway, and Denmark
SELECT name, population 
FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');

-- Countries with area between 200,000 and 250,000
SELECT name, area 
FROM world
WHERE area BETWEEN 200000 AND 250000;

/* Select Basics Quiz */

/* 1. Countries with population between 1,000,000 and 1,250,000 */
SELECT name, population 
FROM world
WHERE population BETWEEN 1000000 AND 1250000;

/* 2. Countries whose names start with 'Al' */
SELECT name, population 
FROM world
WHERE name LIKE 'Al%';

/*
Expected Output (Table-E):
Albania   3200000
Algeria   32900000
*/

/* 3. Countries ending with 'a' or 'l' */
SELECT name 
FROM world
WHERE name LIKE '%a' OR name LIKE '%l';

/* 4. European countries with 5-letter names */
SELECT name, LENGTH(name) AS name_length
FROM world
WHERE LENGTH(name) = 5 
  AND region = 'Europe';

/* Expected Output:
Italy   5
Malta   5
Spain   5
*/

/* 5. (Query missing, add if needed)
Example: SELECT name, population FROM world WHERE name = 'Andorra';
*/

/* 6. Countries with area > 50,000 and population < 10,000,000 */
SELECT name, area, population
FROM world
WHERE area > 50000 
  AND population < 10000000;

/* 7. Population density for specific countries */
SELECT name, population / area AS density
FROM world
WHERE name IN ('China', 'Nigeria', 'France', 'Australia');
