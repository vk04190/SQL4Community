You need to Manually startup the database


check ORACLE_SID has value

sqlplus "sys/password as sysdba"
startup;
Connected to an idle instance.

SQL> startORACLE instance started.
SQL> exit

$ export ORACLE_SID=ANOTHER_SID
$ sqlplus "sys/password as sysdba"

SQL> startup;
SQL> exit

$ export ORACLE_SID=jcrdb
$ sqlplus "sys/password as sysdba"
SQL> startup;
SQL> exit
