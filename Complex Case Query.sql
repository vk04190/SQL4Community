-- Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:
SELECT
   CASE when a+b<=C or a+c<=b or b+c<=a then 'Not A Triangle'
         when a=b and b=c  then 'Equilateral'
         when a!=b and b=c or a=b and b!=c or a=c and b!=c then 'Isosceles'
         when a!=b and  b!=c and c!=a then 'Scalene'
    END
FROM
    OR_DB_SCHEMA.any_random_table ;