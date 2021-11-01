select session_no, avg(diff_secs) from (
select to_char(log_date,'yyyymmdd hh24:mi:ss'),session_no,to_char(sysdate-1,'yyyymmdd hh24:mi:ss') started,
to_char(archive_date,'yyyymmdd hh24:mi:ss') ended,(archive_date-start_date)*24*60*60 diff_secs
from dual where trunc(start_date) = '07-OCT-18' order by end_date desc);

SELECT to_date(DATE_CHAR,'YYYY/MM/DD'),to_char(to_date(DATE_CHAR,'YYYY/MM/DD'),'YYYYMMDD'),REPLACE(DATE_CHAR, '/', ''),TRIM(REPLACE(DATE_CHAR, '/', '')) ,DATE_CHAR FROM  OR_DB_SCHEMA.Any_Random_Table


-- Get Date and time 
SELECT sysdate FROM dual;
