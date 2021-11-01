-- Special Data Types In Oracle Data base
        -- 1. Anchor Data Types
        --     1. %Type
        --             <new_variable_name> <base_table_name>.<base_variable_name>%type;
        --     2. %rowtype
        --             new_variable_name base_table_name%rowtype --example v_emp employee_table%rowtype
        --             new_variable_name Cursor_name%rowtype
        -- 2. Record Data Types Based variable
        --     1. Table Based Record
        --     2. Cursor Based Record
        --     3. User Defined Record

-- PL/SQL Notes:

It is a programming language which is developed by oracle company.
It is a procedural language it is used to process only a row at a time where
as non procedural laguage process a set of rows at a time.

It support to execute a bloc of stmts at once.
Block: collection of executable statements.

-- struture of block:
Declare
[variable Declaration];
Begin
<executable statements>;
[exception
executable statements];
End;

There are two types of blocks
I) Anonoums block
II) named block

Anonmous Blcok:
The Block which is having no name called as anonmous Block
This block cannot call any other programs.
used in D2K forms.

-- Named Block:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The Block which is having a named called as named block.
This block can call in other PL/SQL programs.
eg: procedure
     function
     Trigger
      package

PL/SQL supports the variables&constraints
SQL will supports the Bind variables only.
eg\; var a number
exec a:=1000
print :a

PL/SQL will support bind variables &list variables.

It support the Error handlings.

In SQL we can see the errors on the program Or select stmt,
But we cannot handle&provide the solution.

Where as in PL/SQL we can handle that errors and provides the 
Appropriate actions.

It supports conditional constructs.
It supports the Iteration controls
                i)simple loop
                ii)while loop
                iii)for loop
It supports the sub programs
There are Two types of sub programs:
                  i)function
                  ii)proedure


EG:
declare
Begin
null;
end;

-- Data types in PL/SQL:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Scalar
Composite
Eg: Table
       Record
      varray
Reference:
Ref cursor
Ref object_type
LOB

-- Variable:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

variables are used to store datavalues that are used by pl/sql
variables are represents memory locations used to store user or database data.
variables supports the simple data types and composite data types.

Host variables are supports the Boolean Datatypes where as
Bind variables are not supports the Boolean Datatypes.

Syntax:  <variable name> datatype(size);

declaration part only u declare the variables.

eg: declare
       v_empno number(4):=7902;
       v_name varchar2(20) not null;
note: we should not assign  the null values.

-- Assignment operators:
Into: This operator for internal values
:= This operator any external values.

Executable sub languages are:
DQL
DML
TCL

We cannot use DDL,DCL directely in PL/SQL by using dynamic SQL.

Syntax of Select statement:
Select <column list>into <variable list>
from <table name>
where <condition>;

-- Comments in PL/SQL:

There are Two types of comments:
i)--single line comment
ii) /* multi line comment */

DBMS_OUT.PUT_LINE('Message'||Variable); -- it is used to print the msg and variable  value on the screen.

Set serveroutput on -- It is environment command used to activates DBMS Statemens.

SQL> declare
  2  v_sal number(7,2);
  3  v_comm number(7,2);
  4  net number(7,2);
  5  begin
  6  v_sal:=&salary;
  7  v_comm:=&comm;
  8  net:=v_sal+nvl(v_comm,0);
  9  dbms_output.put_line('the net sal is:'||net);
 10  end;


  1  declare
  2  v_sal number(7,2);
  3  v_comm number(7,2);
  4  net number(7,2);
  5  begin
  6  dbms_output.put_line('the net sal is:'||(&sal+nvl(&comm,0)));
  7* end;

 1  declare
  2  vempno number(4):=&empno;
  3  vename varchar2(20);
  4  vsal number(7,2);
  5  vcomm number(7,2);
  6  netsal number(7,2);
  7  begin
  8  select ename,sal,comm into vename,vsal,vcomm from emp
  9  where empno=vempno;
 10  netsal:=vsal+nvl(vcomm,0);
 11  dbms_output.put_line('ename'||' '||'sal'||' '||'comm'||' '||'netsal');
 12  dbms_output.put_line(rpad(vename,7)||' '||rpad(vsal,7)||' '||rpad(vcomm,7)||' '||n
 13* end;





-- Nested Block:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PL/SQL block can be nested the block which is declarew in another
Block called as nested block or inner block or child block.

Declare
Begin
Declare
Begin
end;
end;                        
note: variable forward Reference  is possible the backword reference may not possible. 


1  declare
  2  m number:=100;
  3  begin
  4  m:=500;
  5  declare
  6  n number:=400;
  7  total number;
  8  begin
  9  m:=600;
 10  total:=m+n;
 11  dbms_output.put_line('the sum of m,n is:'||total);
 12  end;    --end the inner block
 13  dbms_output.put_line('the m value is:'||m);
 14* end;



Variable Attributes:
There are Two types of variable attributes.

By using this variable attributes we can Make the Datatype,size
 independentely for a variable..

Column Type Attribute:
Syntax:
<variable name> <table name>.<column name>%type;
Percentile type(%):- used to declare column type variables.
eg: vename emp.ename%type;

declare 
  2  vname emp.ename%type;
  3  begin
  4  select ename into vname from emp
  5  where empno=&eno;
  6  dbms_output.put_line('the ename:'||vname);
  7  end;



declare
  2  vname emp.ename%type;
  3  vdeptno emp.deptno%type;
  4  begin
  5  select ename,deptno into vname,vdeptno from emp
  6  where empno=&eno;
  7  dbms_output.put_line('the ename,deptno:'||vname||vdeptno);
  8* end;


Row Type variable attribute:
It is used to declare a record type variable
Syntax:
<variable name> <table name>%row type;
eg: i emp%row type;
note:in emp table how many columns are there all are represent or available in i variable.


  1  declare
  2  i emp%rowtype;
  3  begin
  4  i.empno:=&eno;
  5  select ename,sal,comm,deptno into i.ename,i.sal,i.comm,i.deptno from emp
  6  where empno=i.empno;
  7  dbms_output.put_line('the emp details are:'||i.ename||'   '||i.sal||' '||i.comm||i.deptno);
  8* end;

create or replace procedure
display(s varchar2)
is
begin
dbms_output.put_line(s);
end;



Flow control statements:
By using flow control statements we can manipulates and process oracle data.
The categery of flow control statements are:

conditional control
iterative control

conditional controls:
sequences of statements can be executed based on certain conditions using the if stmt.

There are three form of if statements.
i)IF_THEN_ENDIF
II)IF_THEN-ELSE-ENDIF
III)IF-THEN-ELSIF-ENDIF

Syntax:
IF condition then
seuence of statements;
end if;

declare
begin
if ascii('Allen')=65 then
Display('it is true');
end if;
end;



syntax:
If condition then
sequence of statements;
else
sequence of statements;
end if;


declare
v_num number(2):=&eno;
begin
if mod(v_num,2)=0 then
display(v_num||'is an even number');
else
display(v_num||'is an odd number');
end if;
end;

syntax:

if <condition>then
<executable stmts>
elsif<condition>then
<executstmts>
elsif<condition>then
<exstmts>
else
<exstmts>
end if;


declare
avg_marks number:=&avgmark;
grade varchar2(10);
begin
if avg_marks between 80 and 100 then
grade:='A';
elsif
 avg_marks between 60 and 79 then
grade:='B';
elsif
 avg_marks between 40 and 59 then
grade:='C';
elsif
avg_marks between 0 and 39 then
grade:='D';
else
grade:='unknown';
end if;

Iterative controls:
iterative statements enable you to execute a group of statements many times.

Three Types;
simple loop
for loop
while loop

loop
<executable stmts>;
end loop;

declare
n number:=1;
begin
loop
display(n);
n:=n+1;
end loop;
end;


declare
n number:=1;
begin
loop
display(n);
exit when (n>=10);
n:=n+1;
end loop;
end;

while<conditio>
loop
<executable stmts>;
end loop;



declare
n number(3):=1;
begin
while(n<=10)
loop
display(n);
n:=n+1;
end loop;
end;


FOR loop_counter IN[Reverse]
lower_bound...higer_bound
loop
<excut stmts>;
end loop;

declare
begin
for i in 1..10
loop
display(i);
end loop;
end;

where current of clause to refuse the current record and fetched from the explicit cursor.
for update clause explicitely focus the records stored in the private work area.


Composite data types (collections) :
            These are two types which cannot hold any data physically
                     i) PL/SQL Record
                    ii) PL/SQL Table
 i) PL/SQL Record: 
                                 A   PL/SQL Record is allows you to treat sevaral variables as a unit.
   PL/SQL Records are similar to strutures in C
syntax: 
            Type <Type name> is record (field name1, [field name2]---);
 ii) PL/SQL Table: 
                             It holds the elements of the similar datatypes.
 it is similar like a array concept in C
syntax: 
            type <table name> is table of <data type> index by binary-integer;
here table name is collection name
data type---> what type of data can plce in a index
index by---> perform the no.of indexes which can hold the data temporarly
binary-integer---> it is a system datatype





Exception:
                  An exception in pl/sql block is raised during exception of block.
---> it terminates the main body of the action means a block always terminates when pl/sql raised an exception.
---> if the exception is handled then the pl/sql block terminates successfully.

Types of Exceptions:
 Raised implicity: (predefined exceptions)
                          The exceptions which are declared by the oracle and raised implicity these exceptions are called Raised implicity.
Raised explicity:
                          Defined by the user handle by the user according to the requirement.

Predefined exception list:

   Exception Name              Exception                  Description
i)   Dup_Val_On_Index      Ora_0001              Unique constraint violated
ii)  Invalid cursor                Ora_1001                 Illigal cursor operation
iii) Login_Denied                Ora_01017            Incase of invalid username and password
iv) No_Data_Found            Ora_01403            Data is not exist in the table
v) To_Many_Rows            Ora_1422              A select ---into stmt matches more                                                                                                                 than one row
vi) Invalid_Number             ora_1722              Conversion to a number failed       

syntax: 
             Exception
             When <exception_name> Then
                 Sql stmt
             When <exception_name> Then
                 Sql stmt
             When Others Then
                 Sql stmt
  
Raise Application Error:
                                     It is built in function 
                                     It is used in pl/sql
This enable due to specified user defined error message and suspend the task.
syntax:
           Raise_Application_Error <error_num> <error_msg>;
             Error num limit is(-20,000 and -20,999)

User Defined Exception:
                                    The exception which is defined by user called as a User Defined Exception. This exception can invoked by the user by raised stmt.
steps:
i) declare the exception (in declare function)
ii) raise in executable section (explicitly using raise stmt)
iii) handled the raised exception

Sql Code: 
                It holds the currently raised error numbers
Sql Error: 
                It holds the currently raised error msgs
syntax:
            display (Sql Code || Sql Error);

Prgama Exception-init:
                                   I need to display my our message,
---> it is used to handle the     error just like a exception
---> to associate exception in the error code the pragma exception init is defected.
---> it contains two parameters
          i) exception name  ii) error number(or)code


Sub Prgrams
A set of PL/SQL stmts with a name stored permentely in database Called
Two types:
Procedures
Functions

