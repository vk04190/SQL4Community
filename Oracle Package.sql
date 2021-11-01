  -- Packages::~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- Its group of logically Related PL/SQL Types Objects
-- and Subprograms.

-- Package can not be  invoked,parameter and nested.

-- It has usually Two parts
-- i)specification
-- II)Body


-- It allowa the oracle server to read multiple objects into memory at once.

-- means when we call packaged PL/SQL construct for the first time,the whole
-- package is loaded into memory.

-- later calls to construct in the {Devison}e package Require no disk I/O

-- Syntax for specification:
create or replace packbody<packname>
is/as
[public variable declaration];
<subprogram bodies>
End <pack name>;


-- Syntax for The Body:

create or Replace packBody <Pack name>
is/as
[private Variable declaration];
<subprogram bodies>
End [pack name];

Execution: Execute<Packname>.<subProgname>(parameter values);

-- Example
Create or replace package add_mul
As
Procedure add_num(a in number,b in number);
Function mul_num(x in number,y in number)
Return number;
Result number;
End add_mul;

Create or replace packagebody add_mul
As
Procedure add_num(a in number,b in number)
Is
Begin
Result:=a+b;
Dbms_output.put_line("the sum of a and b is:"||Result);
End add_num;
Function mul_num(x in number,y in number)
Return number
Is
Begin
Result:=x*y;
Return(result);
End mul_num;
End add_mul;


-- To invoke the function in Select stmt.

Select add_mul.mul_num(10,5) from dual;

Select add_num.mul_num(20,300)from dual;


Exec add_mul.add_num(100,200);





-- Develop a pl/sql package to display the emp gross salary emp experience in year
-- By  using two functions.

Create or replace package exp_gross
Is
Function gross(psal in number)
Retun number;
Function exp(pdoj in date)
Return number;
End exp_gross;

Create or replace packagebody exp_gross
Is
Function gross(psal in number)
Return number
Is
Begin
Return(round(psal+psal*0.35+psal*0.45-psal*0.15));
End gross;

Function exp(pdoj in date)
Return number;
Is
Begin
Return(round(months_between(sysdate,pdoj)/12));
End exp;
End exp_gross;

-- Package Supports function overloading:

Create or replace package pack_oload
Is
Function fun_load(a in number, b in number)
Return number;
Function fun_load(x in varchar2,y in varchar2)
Return varchar2;
End pack_oload;

Create or replace package pack_oload
Is
Function fun_load(  a in number, b in number) 
Return number;
Is
Begin
Return(a*b);
End fun_load;
Function fun_load(x in varchar2,y in varchar2)
Return varchar2
Is
Begin
Return(x||" "||y);
End fun_load;
End pack_load;

