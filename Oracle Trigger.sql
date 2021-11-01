-- Triggers: A set of PL/SQL stmts automatically executed whenever an DML stmts is performed on table.
                                          Or
A Database Trigger is a named PL/SQL Block stored in a database and Executed Implicitely when
Triggering Event occurs.

A Triggering Event  is a Dml stmt Associated with "insert","update" or "delete" stmt
executed againest a database Table.

Advantages of Triggers:

It is used to implement user defined Restriction on table.

used to impose business Rules on data.
Provides high security.

Trigger can fire before or after a Triggering Events.

Before: By using Before we can make the Trigger action Before  performing Transaction.

After: By using After we can execute the Trigger after perform a Transaction.


Defined Trigger :

Row Trigger: This Trigger will be fired for every row manipulated.
               Generaly used for data auditing applications.
By using FOR EACHROW u can make the trigger as Row level.

Statement Triggers: (table level)

The Trigger will be fired only once for Dml stmt.


Types of Triggers:

i) Application level
II) Database Triggers.

Application level Triggers:

The validation or rules different from  each and every application we should use the application trigger.

Eg: D2K forms and Reports:

Database Triggers:

The validation or Rules are common for Every Applicant who are Applicant who are accessing the
Database we can use the Database Triggers.

Trigger Qulifiers:

:New.<colmn name>
:Old.<column name>

Triggers Qulifiers  can use only in Row level.

Syntax:

Create or Replace Trigger <Trigger name>
After/Before <insert/update/delete>
(of <column name>)
on <table name>
[for eachrow]
(when <condition>)
[declare local variable];
Begin
Sql stmts--------
--------------
Exception 
Executable stmts
End [Trigger name];

Difference between Procedure and Triggers.

Procedure                                                            Trigger
i)call explicitely                                               i)call implicitely against the events
II) accept the parameters                                 ii) triggers not accept parameters
iii)Procedure can nested                                  iii)trigger cannot nested
iv)procedure can used for                               iv) triggers cannot used
storing the images            

V) in procedure u can use                                V)Trigger may not give the 
                                                                        the compilation error but gives the                                                                                                                 Run time erro
the TCL command w/o compile
and Runtime errors

Fragma autonoums is optional                          Fragma autonomous is mandatory

Difference  Beteen Triggers and Constraints.

                               
Triggers                                              Constraints

We can create the user define                 constraints are the building programs
Triggers and we can change the                and we cannot change the behavior of the                                                                                                 constraints.
behavior of this trigger. 

Trigger can check only                               it will check the existing data and
future data.                                                   feture data.
                  
                   
we can disable the all                              if may not disable all the
                                                              constraints in a table at once.
the triggers on a table
at a time.


-- 1) write a pl/sql trigger to trace empno,ename,sal,deptno after remove the emp(from emp table) details to store this data in trace table.

create table trace as
select empno ,ename ,sal ,deptno from
emp having 'oracle'='sql server';

create or replacetrigger trg_trace
after delete
on emp
for each row
 begin
insert into trace values
(:old.empno,:old.ename,:old.sal,:old.deptno);
end;


Note:

delete from emp where deptno=20;

select *from trace;


Rollback;
select *from trace;
select *from emp;




-- 2) create pl/sql trigger program after delete the emps
-- from emptable trace the user,date of joining,
-- empno,and sal the information will display in del_trace.


create table del_trace
(userid varchar2(20),
doj timestamp,
ecode number(4),
sal number(10));

create or replace trigger trace_trg
after delete
on emp
for each row
begin
insert into del_trace values(user,sysdate,:old.empno,:old.sal);
end;

Note:
delete from emp where deptno=10;
select *from del_trace;

-- 3) write a pl/sql trigger to insert the empno,enmae,sal,deptno in del_trace after remove the records from emp table the emp's which is having sal above 1500.


create table del_trace
(
empno number(10),ename varchar2(20),sal number(7,2),deptno number(10));

create or replace trigger trace_trg
after delete
on emp
for eachrow
when(old.sal>1500)
begin
insert into del_trace values(:old.empno,:old.ename,:old.sal,:old.deptno);
end;

-- Note:
delete from emp where deptno=30;
2 records insert into del_trace bcz(one record above 1500).


-- 5)write a trigger to insert the data into a bonus table
-- after insert the record into the emp table and save the
-- transaction only bonus table.

create table bonus as
select ename,job,sal,comm from emp
where 'krish'='ravan';

create or replace trigger add_bonus
after insert 
on emp
for each row
declare
pragma autonomous_transaction;
begin
insert into bonus values(:new.ename,:new.job,:new.sal,:new.comm);
commit;
end;

Note:
insert into emp(empno,ename,job,sal,comm)values
(1003,'prakash','softwarew','20000.900');

the above row insert into emp table and bonus table

select *from bonus;
-- note:Bonus table Records save perminently.
-- emp table records will be rollback.


-- write a pl/sql Trigger 
-- i)week ends
-- ii)Before 9 A.M after 7 p.m
-- iii) public Holidays  no transactions


create table h_tab
(
hday date
);

insert into h_tab values('01-jan-11');
insert into h_tab values('14-jan-11');
                                       ('26-jan-11');
                                       ('15-aug-11')
                                       ('25-Dec-11');
 
commit;

 Note:
select count(hday) from h_tab where hday=to_date
(sysdate,'dd-mon-yy');
select *from h_tab;

create or replace Trigger trg_dth
before insert or update or delete
on emp
declare
cnt number;
begin
select count(*)into cnt from h_tab
where hday=to_date(sysdate,'dd-mm-yy');
if to_char(sysdate,'DY') in ('sat','sun') then
Raise_application_error(-23456,'no transaction in week_end');
elsif cnt>0 then
raise_application_error(-20457,'notransaction in hday');
elsif to_char(sysdate,'hh24')not between 9 and 19 then
Raise_application_error (-20456,'notransaction in this time');

end if;
end;
