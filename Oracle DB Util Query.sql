
-- find any table in DB using DB Link
select * from dba_tables@ANY_DB_LINK.link where table_name like '%Any_table_name_string%' and owner = 'OR_DB_SCHEMA';
SELECT * FROM OR_DB_SCHEMA.OR_DB_SCHEMA.any_random_table WHERE TABLE_NAME= 'DB@Link' ORDER BY  TABLE_name ;
-- Table Truncation details
select * from dba_TAB_MODIFICATIONS WHERE TABLE_NAME='ANY_TABLE_NAME' and table_owner='OR_DB_SCHEMA' order by TIMESTAMP;

select table_name,inserts,updates,deletes,truncated,timestamp
  from sys.dba_tab_modifications
  where  table_name LIKE 'KeyWords%'


  -- Following is more effecent  
SELECT * FROM
	sys.dba_tab_modifications
WHERE
	table_name LIKE 'KeyWords%' AND TRUNCATED='YES' ORDER BY "TIMESTAMP" desc;

      -- Table Truncation details
select * from dba_TAB_MODIFICATIONS WHERE TABLE_NAME='MSC_CDR_F' and table_owner='OR_DB_SCHEMA' order by TIMESTAMP;

select table_name,inserts,updates,deletes,truncated,timestamp
  from sys.dba_tab_modifications
  where  table_name LIKE 'KeyWords%'

-- to view current user
SELECT USER FROM dual;


-- Commit to free up undo segment and make changes permanant
COMMIT;

-- Describe any table
DESC OR_DB_SCHEMA.any_random_table 

-- to view running jobs
SELECT * FROM dba_jobs ORDER BY job;

select * from OR_DB_SCHEMA.debug_log WHERE LOG_ID>1730 ORDER by log_date desc;

SELECT DISTINCT table_name FROM OR_DB_SCHEMA ORDER BY  TABLE_name ;

 SELECT 
              FROM OR_DB_SCHEMA.im.stream_tables_d std
              WHERE table_name LIKE  'TEST_BSS_SRC';

-- Find any table with keywords
SELECT
      owner||'.'||OBJECT_NAME
FROM
      all_objects
WHERE OBJECT_type LIKE '%TABLE' AND 
      OBJECT_NAME LIKE '%STUD%' ORDER BY OBJECT_NAME;

-- Case statement
CASE
            WHEN COUNTRY  = 1 THEN 206
            WHEN COUNTRY  = 2 THEN 270
            WHEN COUNTRY  = 3 THEN 303
            WHEN COUNTRY  = 6 THEN 218
            WHEN COUNTRY  = 4 THEN 258
            WHEN COUNTRY  = 7 THEN 346
      END CODE




