-- to show Duplicacy in a table
SELECT count(1)
  FROM OR_DB_SCHEMA.any_random_table f
 WHERE     EXISTS
               (SELECT 1
                  FROM OR_DB_SCHEMA.any_random_table f1
                 WHERE     f.ID = f1.ID
                       AND f.ROWID < f1.ROWID
                       AND f1.date_code = :date_code)
       AND f.date_code = :date_code;
      
-- to count all rows
SELECT count(1) FROM OR_DB_SCHEMA.any_random_table f WHERE 
                       AND date_code = :date_code;

-- Delete Duplicates from a table
DELETE OR_DB_SCHEMA.any_random_table f
 WHERE     EXISTS
               (SELECT 1
                  FROM OR_DB_SCHEMA.any_random_table f1
                 WHERE     f.ID = f1.ID
                       AND f.ROWID < f1.ROWID
                       AND f1.date_code = :date_code)
       AND f.date_code = :date_code;
       
SELECT count(1) FROM OR_DB_SCHEMA.any_random_table f1 WHERE f1.date_code = :date_code;

-- Submit the job to get the delete Duplicacy from a table
BEGIN
    DECLARE
        vjob          INTEGER;
    BEGIN
        DBMS_JOB.submit( vjob, '
        DECLARE
                l_start		VARCHAR2(100)  := ''20210102'' ;
        BEGIN	   
                WHILE l_start < ''20210112''	LOOP
                DELETE OR_DB_SCHEMA.any_random_table f
                WHERE     EXISTS
                        (SELECT 1
                            FROM OR_DB_SCHEMA.any_random_table f1
                            WHERE     f.id = f1.id
                                AND f.ROWID < f1.ROWID
                                AND f1.date_code = l_start)
                        AND f.date_code = l_start;
                    commit;
                    
                    -- Increment the date
                    l_start := l_start+1;
                END LOOP;
        EXCEPTION --Exception Block	  
           WHEN OTHERS THEN
              OR_DB_SCHEMA.debug_log_pkg.write_log(''BLOCK'',''BLOCK'', sqlerrm);
        END;
        
        ', SYSDATE );
        DBMS_OUTPUT.put_line( 'Job id : ' || vjob );
        COMMIT;
    END;
END;

-- Incide Job Code
DECLARE
    l_start          VARCHAR2( 100 ) := '20210102';
BEGIN 
WHILE l_start <= '20210120'	LOOP
    DELETE OR_DB_SCHEMA.any_random_table f
     WHERE     EXISTS
                   (SELECT 1
                      FROM OR_DB_SCHEMA.any_random_table f1
                     WHERE     f.ID = f1.ID
                           AND f.ROWID < f1.ROWID
                           AND f1.date_code = l_start)
           AND f.date_code = l_start;

    COMMIT;
     -- Increment the date
                    l_start := l_start+1;
                END LOOP;
EXCEPTION --Exception Block
    WHEN OTHERS THEN
        OR_DB_SCHEMA.debug_log_pkg.write_log( 'BLOCK', 'BLOCK', SQLERRM );
END;


DELETE OR_DB_SCHEMA.any_random_fact_table f
 WHERE     EXISTS
               (SELECT 1
                  FROM OR_DB_SCHEMA.any_random_fact_table f1
                 WHERE     f.id = f1.id
                       AND f.ROWID < f1.ROWID
                       AND f1.date_code = :date_code)
       AND f.date_code = :date_code;

SELECT count(1) from OR_DB_SCHEMA.any_random_fact_table f
 WHERE     EXISTS
               (SELECT 1
                  FROM OR_DB_SCHEMA.any_random_fact_table f1
                 WHERE     f.id = f1.id
                       AND f.ROWID < f1.ROWID                       
                       AND f1.date_code = :date_code)
       AND f.date_code = :date_code;
