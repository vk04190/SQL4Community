
-- find any table in DB using DB Link
select * from dba_tables@ANY_DB_LINK.link where table_name like '%Any_table_name_string%' and owner = 'OR_DB_SCHEMA';

