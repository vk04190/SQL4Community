SELECT * FROM dba_jobs; 

-- to kill any job--------------------------------------------------------------
select   vs.sid,va.sid ,va.object,vs.serial# FROM gv$session vs, gv$access va where va.object like '%ODI%'  AND ROWNUM<10;
-- Generate session kill statement
SELECT 'alter system kill session ''' || vs.sid || ',' || vs.serial# || ''' IMMEDIATE ;' cmd
  FROM gv$session vs, gv$access va
 WHERE vs.sid = va.sid
       AND va.object = UPPER( :v_object )
      AND username = 'OR_DB_SCHEMA'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- To Kill Any Job 

SELECT * FROM dba_jobs_running ; --- get sid

SELECT * FROM v$session WHERE sid=4261; --pass sid and get serial#

alter system kill session '4261,17513' IMMEDIATE; --pass sid and serial id  to kill that job
-------------------------------------------------------------------------------------------------------------
       
-- If you want to kill a running job, do it in 3 steps. First find the job's running related session.

SELECT /*+ RULE */ D.JOB, V.SID, V.SERIAL#, LOG_USER USERNAME, WHAT,
DECODE(TRUNC(SYSDATE - LOGON_TIME), 0, NULL,
TRUNC(SYSDATE - LOGON_TIME) || ' Days' || ' + ') ||
TO_CHAR(TO_DATE(TRUNC(MOD(SYSDATE-LOGON_TIME,1) * 86400), 'SSSSS'), 'HH24:MI:SS') RUNNING,
D.FAILURES, 'alter system kill session ' || '''' || V.SID || ', ' || V.SERIAL# || '''' || ' immediate;' KILL_SQL
FROM DBA_JOBS_RUNNING D, V$SESSION V, DBA_JOBS J
WHERE V.SID = D.SID
AND D.JOB = J.JOB;

--Second login as the owner of the job and mark it BROKEN

BEGIN
 DBMS_JOB.BROKEN(JOB,TRUE);
END;
COMMIT;

--Third as sysdba kill the related session

ALTER SYSTEM KILL SESSION 'SID, SERIAL#' IMMEDIATE;
Tip : Marking the job as Broken is necessary; otherwise, the job queue process will restart the job as soon as it notices the session has been killed. 
-- Submit the job of any procdure to do something in background to get the output to run immediately
BEGIN
    DECLARE
        vjob          INTEGER;
    BEGIN
        DBMS_JOB.submit( vjob, 'OR_DB_SCHEMA.any_complex_package_pkg.any_procedure_prc( ''Variables'', ''20210101'', ''20210301'' );', SYSDATE );
        DBMS_OUTPUT.put_line( 'Job id : ' || vjob );
        COMMIT;
    END;
END;

-- A Sample Procedure which is getting extecuted in job
PROCEDURE any_procedure_prc( p_variables IN VARCHAR2, p_start_date IN VARCHAR2, p_end_date IN VARCHAR2 )
    IS
        -- Declare cursors
        CURSOR cur
        IS
            SELECT date
              FROM OR_DB_SCHEMA.date_d
             WHERE full_date BETWEEN TO_DATE( p_start_date, 'YYYYMMDD' ) AND TO_DATE( p_end_date, 'YYYYMMDD' )
            ORDER BY 1;

        v_date            VARCHAR2( 8 );
        v_code          VARCHAR2( 8 );
        v_id            NUMBER;
        v_sid          NUMBER;

        -- Declare Out and exception variables
        l_errmsg               VARCHAR2( 10000 ) := NULL;
        excp_skip              EXCEPTION;
    -- Declare Varibales

    BEGIN
        -- Initializing out parameters
        g_proc_name            := 'any_procedure_prc';

        v_code          := p_variables;

        IF v_code IS NOT NULL THEN
            SELECT v_id
                 , v_sid
              INTO v_id
                 , v_v_sid
              FROM OR_DB_SCHEMA.any_random_table a;

        END IF;

        FOR rec IN cur
        LOOP

            v_date          := rec.date;

            DELETE FROM OR_DB_SCHEMA.validate_temp
             WHERE date = v_date;

            INSERT INTO OR_DB_SCHEMA.validate_temp
                ( SELECT column1,column2 ..
                   FROM OR_DB_SCHEMA.any_random_table
                  WHERE date = v_date
                        AND v_id = v_v_id
                 GROUP BY column1,column2 ..
                 UNION
                 SELECT column1,column2 ..
                  WHERE date = v_date
                 GROUP BY column1,column2 ..
                 ;


            DELETE FROM OR_DB_SCHEMA.any_random_table
             WHERE date = v_date;

            INSERT INTO OR_DB_SCHEMA.any_random_table
                SELECT column1,column2 .., SYSDATE
                  FROM OR_DB_SCHEMA.any_random_table
                 WHERE     t2.date = v_date
                       AND t1.date = t2.date;

            COMMIT;

        END LOOP;

    EXCEPTION -- Exception block of Procedure
        WHEN excp_custom THEN
            ROLLBACK;
            printlog( l_errmsg );
            raise_application_error( -20000, l_errmsg );
        WHEN OTHERS THEN
            ROLLBACK;
            l_errmsg          := get_errmsg;
            printlog( l_errmsg );
            raise_application_error( -20000, l_errmsg );
    END topup;