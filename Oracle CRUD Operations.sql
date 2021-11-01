
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

-- Drop Table parmantly with Purge
DROP TABLE OR_DB_SCHEMA.OR_DB_SCHEMA.any_random_table PURGE;

--DROP Table with normal
DROP TABLE OR_DB_SCHEMA.any_random_fact_table;

--Drop Table parmantly with safer dependency
DROP TABLE OR_DB_SCHEMA.im.stream_tables_d CASCADE CONSTRAINTS PURGE;

-- Droping a View
DROP VIEW OR_DB_SCHEMA.voice_sms_recon;

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


-- Create GLOBAL temp table
CREATE GLOBAL TEMPORARY TABLE OR_DB_SCHEMA.any_random_fact_table_temp
(
    table_type              CHAR( 2 BYTE )
  , tablename               VARCHAR2( 100 BYTE )
  , date_code               VARCHAR2( 8 BYTE )
  , id               NUMBER
  , desc                VARCHAR2( 200 BYTE )
  , event_count             NUMBER
)
ON COMMIT PRESERVE ROWS
NOCACHE;

--Create Table in normal Condition
CREATE TABLE OR_DB_SCHEMA.any_random_table( 
            DATE_CODE VARCHAR2(50),
            ID NUMBER,
            LAST_UPDATE_DATE DATE
            );
		
--Create TABLE with TABLESPACE
CREATE TABLE OR_DB_SCHEMA.any_random_table
(
    DATE_CODE VARCHAR2(50), 
	ID NUMBER, 
	LAST_UPDATE_DATE DATE
)
TABLESPACE Any_table_space;

-- Select with dynamic filter
SELECT *
  FROM OR_DB_SCHEMA.any_stage_random_table
 WHERE date_code BETWEEN :p_start_datecode AND :p_end_datecode
ORDER BY table_name, date_code;

