-- Function::~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- The function is a PL/SQL Block that Returns a Single value.

-- Function can accept one or more parameters or no parameters.
-- function must hava a Return clause in the executable section of a function.
-- it is called part of expression.
-- it is used for calculation of  a value.
-- function can user with the select stmt.
-- function cannot use with select stme when it has a outmode,inout mode parameters.

-- Syntax:

create or replace function <fname>
(parameter name[mode] datatype,------)
Return <datatype>
is/as
[local variable]
Begin
<executable stmts>;
Return <variable/value>;
Exception
<executable stmts>;
end <function name>;


-- Execution:
select <function name>(argments) from dual;
pl/sql:  begin
          <sql stmts>;
         end;
           
           
-- write a pl/sql function to calculate the compound intrest.

create or replace function comintr
(p in number,n in number,r in number)
return number
is 
ci number;
begin
ci:=p*power((1+r/100),n);
return(ci);
end comintr;

select comintr(100,40,60) "commintr" from dual;

var ci number
exec :ci:=comintr(100,23,4)
print :ci

call this function in a different pl/sql function.

begin
display('the comm intr is:'||round((comintr(1000,12,2)));
end;

-- write a function accept the deptno as input and display the no of emps through the return by using this function.
-- display the deptno,and no.of employees the dept which is having morethan 3 employees.


create or replace function
noe(pdno in number)
return number
is
vnoe number;
begin
(select count(empno)into vnoe from emp
where deptno=pdno;)
return (vnoe);
end noe;

select unique deptno,noe(deptno) "noe"from emp
where noe(deptno)>3;

