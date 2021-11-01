-- Query the list of CITY names Starting with vowels (a, e, i, o, u) from STATION. 
select distinct city from station where  REGEXP_LIKE(city, '^[AEIOU]');

-- Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. 
select distinct city from station where  REGEXP_LIKE(city, '[aeiou]$');

-- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. 
-- select distinct city from station where left(city,1) in ('a','e','i','o','u') and right(city, 1) in ('a','e','i','o','u')
select distinct city from station where  REGEXP_LIKE(city, '[aeiou]$') and  REGEXP_LIKE(city, '^[AEIOU]');
-- Query the list of CITY names from STATION that do not start with vowels. 
select distinct city from station where  REGEXP_LIKE(city, '^[^AEIOU]');
-- Query the list of CITY names from STATION that do not end with vowels. 
select distinct city from station where  REGEXP_LIKE(city, '[^aeiou]$');

-- Find File name with Node Details
SELECT
      REGEXP_SUBSTR(FILENAME, '[^_]+', 1, 6) DATE_CODE,
      REGEXP_SUBSTR(FILENAME, '[^_]+', 1, 4) NODE,
      COUNT(1)
FROM
      ORDB.Log_Table
WHERE STATUS LIKE 'A%'
GROUP BY
      REGEXP_SUBSTR(FILENAME, '[^_]+', 1, 6),
      REGEXP_SUBSTR(FILENAME, '[^_]+', 1, 4)
ORDER BY
      REGEXP_SUBSTR(FILENAME, '[^_]+', 1, 4) ,
      REGEXP_SUBSTR(FILENAME, '[^_]+', 1, 6)