-- 1. Total world population
SELECT SUM(population) AS total_population
FROM world;

-- 2. List of continents
SELECT DISTINCT continent
FROM world;

-- 3. Total GDP of Africa
SELECT SUM(gdp) AS total_gdp_africa
FROM world
WHERE continent = 'Africa';

-- 4. Number of countries with area >= 1,000,000
SELECT COUNT(*) AS total_large_countries
FROM world
WHERE area >= 1000000;

-- 5. Population sum for Estonia, Latvia, and Lithuania
SELECT SUM(population) AS baltic_population
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

-- 6. Number of countries per continent
SELECT continent, COUNT(*) AS country_count
FROM world
GROUP BY continent;

-- 7. Continents with country counts using a subquery
SELECT DISTINCT continent,
       (SELECT COUNT(*) 
        FROM world 
        WHERE continent = w.continent) AS country_count
FROM world AS w;

-- 8. Continents with more than 10M population in some countries
SELECT continent, COUNT(*) AS country_count
FROM world
WHERE population > 10000000
GROUP BY continent;

-- 9. Continents with total population >= 100M
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;

---------------------------------------------------
-- QUIZ SECTION
---------------------------------------------------

-- 1. Total population in Europe
SELECT SUM(population) AS total_population_europe
FROM bbc
WHERE region = 'Europe';

-- 2. Countries with population < 150,000
SELECT COUNT(name) AS small_country_count
FROM bbc
WHERE population < 150000;

-- 3. Core SQL aggregate functions (reference)
-- AVG(), COUNT(), MAX(), MIN(), SUM()

-- 4. Total area by region (only regions > 15M area)
SELECT region, SUM(area) AS total_area
FROM bbc
GROUP BY region
HAVING SUM(area) > 15000000;

-- 5. Average population for selected countries
SELECT AVG(population) AS avg_population
FROM bbc
WHERE name IN ('Poland', 'Germany', 'Denmark');

-- 6. Population density by region
SELECT region, SUM(population) / SUM(area) AS density
FROM bbc
GROUP BY region;

-- 7. Country with highest population density
SELECT name, population / area AS density
FROM bbc
WHERE population = (SELECT MAX(population) FROM bbc);

-- 8. Regions with total area <= 20M
SELECT region, SUM(area) AS total_area
FROM bbc
GROUP BY region
HAVING SUM(area) <= 20000000;
