BEGIN
 OR_DB_SCHEMA.any_random_prc( 'Any_Condition', '20250720', '20250731');
END;



-- Procedure: A Procedure is a Named PL/SQL Block performing one or more actions associated to business logic.
-- It is also called Stored procedure
-- It accept the parameters
-- It is Explicitely called by using Executives.
-- It may or may not Return values.
-- Procedurre cannot use With Select Statement.

-- Advantages of Procedure:

-- Using Procedure  a programmer to shift the code from the Application side to the database side.
-- Business Rules and Application logic to be stored As Procedures
--  with in the database side.
-- The procedural code stored within the database  can be
-- Reused Anywhere with in the Application.
-- They nednot be rewritten in each code module of the aplication
-- so saves the creation time of the application.
-- Reduce the maintaince effort.


-- Types of Procedures:

-- Stand alone Procedure:
-- The procedure which is created outside of the package called as
-- This procedure will stored in user_procedures.
-- Part of the package:
-- This  Procedure is define in  a package 
-- This procedure is not stored Anywhere.

-- Parts of the Procedure:
-- Specification:  nothing but declaration section
-- here we can give the procedure name
-- parameters and local variables.

-- Body: it contains pl/sql code 
-- based on this PL/SQL only the Action of procedure depend.

-- Syntax:
Create or replace Procedure<procname>
[parameter[mode]datatype,-----)]  is/as
[local variable]
Begin
<executable stmts>;
Exception
<executable stmts>;
End[procedure name];


-- Programs:
-- Write a pl/sql procedure to display the SI AND CI

>set serveroutput on
create or replace procedure simintr
(p in number,n in numbr,r in number)
is
si number;
ci number;
begin
si:=(p*n*r)/100;
ci:=p*power(1+r/100),n);
dbms_output.put_line('The si is '|| si);
                                 ('The ci is'||ci);
End simintr;
syntax:execute<proceduree name><required argments>;
Eg;execute simintr(100,10,12);

PL/SQL:
Begin
procedure name<arg1,arg2,.......>;
End;

Ex:
Begin 
simintr(100,10,12);
end;

o/p:si is=
ci is=


Parameter modes:
Three types of modes
i)IN  ii) OUT iii) INOUT

IN:
It accepts a default type
Always  Accept values into subpgms
It cannot be assigne with values in subpgms

Out:
It returns a value from subpgm
initilizes in subpgm
it cannot carries a value into a subpgm
Inout:
carries a value into a subpgm
Return a value from The subpgm
Max 32 Argments into subpgm

Syntax:
<parameter name> [parameter mode]<datatype>

note: Procedure maynot Return a value but through the outmode 
parameter procedure may Returned

Remove the procedure:
Drop procedure<proc name>;


Eg:
create or replace procedure sp
(m in number, n out number)
is
begin
n:=m*m;
end sp;

using Bind variable
var r number
exec sp(10,:r);
procedure created
print :r


create or replace procedure proc_cal
(m in number,sr out number,cr out number)
is
begin
sr:=m*m
cr:=m*m*m;
end proc_cal;

var sr number
var cr number
exec proc_cal(10,:sr,:cr)
print :sr
Print :cr


Call this procedure in another PL/SQL Block
Declare
sr  number;
cr number;
begin
proc_cal(10,sr,cr);
dbms_output.put_line('the sr is:'||sr);
                                 ('the cr is:'cr);
end;

o/p: sr is:
cr is:


Remove the procedure:
Drop procedure <procedure name>;

Pragma _autonomous transaction:
It is used write the TCL commonds in trigger.
it is used also in nested procedure to make each procedure independently for TCL.


-- write a pl/sql procedure for inserting for records in emp table and commit the transaction.

Create or replace procedure add_emp
Is
Begin
Insert into emp(empno,ename,sal,deptno)
Values(1001,"james",10000,44);
Commit;
End add_emp;

Create or replace procedure add_dept
Is
Begin
Insert into dept values(55,"sss","chicago");
Add_emp;
End add_dept;

-- Note: emp table commit effected to dept table also.
-- Pragma autonomous_transaction:

Create or replace procedure add_empo 
As
Pragma autonomous_transaction;
Begin
Insert into emp(empno,ename,sal,deptno) values(1001,"efford",1000,55);
Commit;
End add_empo;

Create or replace procedure add_depto
As
Begin
Insert into dept values(44,"jjj","chicago");
Add_empo;
End add_depto;

-- Note; commit is effected for only emp transaction


-- Recompile an existing procedure:

Alter procedure <proc-name> compile;



-- Synonyms on procedure:

Create public synonym ad for add_dept
Grant execute on ad to public
