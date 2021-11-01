
-- Select from DB Links
SELECT * FROM ORDB.any_random_table WHERE  MARKET='IND' AND TABLE_name IN ('DB_link@ORA_BSS_SRC') AND STREAM='STR_1' AND RECORD_COUNT=0;
select * from OR_DB_SCHEMA.debug_log order by log_date desc;

-- Delete from DB Links
DELETE  FROM ORDB.any_random_table WHERE  MARKET='IND' AND TABLE_name IN ('DB_link@ORA_BSS_SRC') AND STREAM='STR_1' AND RECORD_COUNT=0;
-- Insert SYSDATE in the table
insert into OR_DB_SCHEMA.any_random_fact_table values('20250528',25,3,sysdate,'');

-- truncate any_random_table  subpartition
alter table OR_DB_SCHEMA.any_random_table truncate subpartition(part_20180720_{DEVISON});

-- Update any any_random_fact_table
update OR_DB_SCHEMA.any_random_table set aggregate_tab_load_date = '' where  date_code = '20250720';

-- Drop Table with Purge
DROP TABLE OR_DB_SCHEMA.OR_DB_SCHEMA.any_random_table PURGE;

-- TABLE CREATING SCRIPT
CREATE TABLE OR_DB_SCHEMA.any_random_table ( 
											  PROCESSED_DATE DATE
											, NAME		VARCHAR2(8)
											, ID		NUMBER
											, ANY_RANDOM_COLUMN		NUMBER
										);


-- Calling any function which is inside a package
SELECT OR_DB_SCHEMA.Any_utility_pkg.Any_function_like_get_date_to_epoch( '20-Dec-2025', 'Y', 7199500 ) from dual;

-- Insert and Update / Merge Query
merge /*+ parallel(8) */ into OR_DB_SCHEMA.any_random_fact_table subpartition(part_20180601_1100) d
using OR_DB_SCHEMA.any_random_table partition(part_20180601) s
on (d.date = s.date)
when matched then update set d.id = s.id
where d.id is null;

-- Describe any table
DESC OR_DB_SCHEMA.any_random_table 

-- Drop table with cascade constraints
DROP TABLE OR_DB_SCHEMA.any_random_fact_table CASCADE CONSTRAINTS;

-- Create GLOBAL temp table
CREATE GLOBAL TEMPORARY TABLE OR_DB_SCHEMA.any_random_fact_table
   (	
	"TABLE_TYPE" CHAR(2), 
	"TABLENAME" CHAR(30), 
	"DATE_CODE" VARCHAR2(8), 
	"ID" NUMBER, 
	"TYPE" NUMBER
   );

-- Commit to free up undo segment and make changes permanant
COMMIT;
