
-- Cursors:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cursors are variables that we can define and declare section of pl/sql Block.

A cursor is apl/sql construct and allows you to
name of the work area
access their stored information
process the multiple Records

note: manipulate the more than one record that time used cursor stmts.

Types of cursors:
two types:
1)Static cursor
a)Explicit cursor
b)Implicit cursor

2)Dynamic cursor (Ref cursor)

Explicit cursor:
It is declared by the user and manipulated by theuser and valide only in pl/sql.


the life cycle of Explicit cursor goes through four stages
 i) declare  ii)open  iii)fetch  iv)close
i)Declare: The cursor stmt is declared explicitely in declarative section
syntax:  Declare cursor<cursor name> is
                         select<list of columns>
                         from <table name>
                          [where condition];
                            Begin
                              ----
                              ----
                             End;


SQL> declare 
  2  cursor c1 is
  3  select empno,ename,sal,deptno
  4  from emp
  5  where deptno=20;
  6  begin
  7  null;
  8  end;





ii) open:  Here the query execution done now we can fetch the data. 

syntax:  open<cursor name>

iii) fetch: The retrieves of data into the pl/sql variables or host variable is done through the fetch stmt.
             The fetch stmt is a simple loop to fetch the all the cursor stmt.

syntax:  fetch<cursor name> into <variables>;

iv) close: Explicitely closes the cursor
 syntax:  close <cursor name>

Cursor Attributes:
i) % found: it rerurns true if fetch is success
ii) % not found: it rerurns true if fetch is not success
iii) % is open: it returns true if cursor is open successfully
iv) % row count: it returns no.of rows fetched 

Eg:
1  declare cursor c1 is
  2  select empno,ename,sal
  3  from emp
  4  where deptno=30;
  5  vempno emp.empno%type;
  6  vename emp.ename%type;
  7  vsal emp.sal%type;
  8  begin
  9  open c1;
 10  loop
 11  fetch c1 into vempno,vename,vsal;
 12  exit when c1%notfound;
 13  dbms_output.put_line(vempno||' '||vename||' '||vsal);
 14  end loop;
 15  close c1;
 16* end;

1  declare
  2  cursor c_sal is
  3  select empno,ename,sal,job,deptno
  4  from emp;
  5  i emp%rowtype;
  6  begin
  7  open c_sal;
  8  loop
  9  fetch c_sal into i.empno,i.ename,i.sal,i.job,i.deptno;
 10  exit when c_sal%notfound;
 11  if i.job='clerk'then
 12  i.sal:=i.sal+i.sal*0.25;
 13  elsif i.job='manager'then
 14  i.sal:=i.sal+i.sal*0.35;
 15  else
 16  i.sal:=i.sal+i.sal*0.15;
 17  end if;
 18  update emp set sal=i.sal
 19  where empno=i.empno;
 20  dbms_output.put_line(rpad(i.ename,8)||''||rpad(i.sal,6)||''||rpad(i.deptno,10));

Types of explicit cursor:
                      Explicit cursor with simple loop  
                      Explicit cursor with for loop
Advantages:  
                 no need to declare variables
                 no need to open the cursor explicitely
                 no need to fetch the data
                 no need to explicitely stop the loop
                 no need to close the cursor

syntax: for <variable> in <cursor name>
              loop
              stmts;
              end loop;



  1  declare
  2  cursor
  3  comm_cur is
  4  select empno,ename,sal,comm,deptno
  5  from emp;
  6  begin
  7  for k in comm_cur
  8  loop
  9  if k.comm is null then
 10  k.comm:=300;
 11  elsif k.comm=0 then
 12  k.comm:=250;
 13  else
 14  k.comm:=k.comm+k.sal*0.15;
 15  end if;
 16  update emp set comm=k.comm
 17  where empno=k.empno;
 18  dbms_output.put_line(rpad(k.empno,8)||''||k.comm||
 19  ''||k.deptno);
 20  end loop;
 21* end;


  1  declare
  2  cursor dnoc is
  3  select deptno,min(sal) low_pay,
  4  max(sal) high_pay,sum(sal) tot_pay,
  5  count(empno)noe
  6  from emp
  7  group by deptno;
  8  begin
  9  for i in dnoc
 10  loop
 11  dbms_output.put_line(i.deptno||''||i.low_pay||''||i.high_pay||''||i.tot_pay||''||i.noe);
 12  end loop;
 13* end;


Implicit cursor:
Define by the oracle when everDml is performed in pl/sql program.

Implicit cursor:
                        An implicit cursor craete and erased by automatically.
---> During the process of an implicit cursor oracle automatically perform the operations like open , fetch and close.

---> Attributes are
    i) Sql % found
   ii) Sql % not found
  iii) Sql % is open
  iv) Sql % row count

 1  begin
  2  for i in(select empno, ename,sal,deptno from emp)
  3  loop
  4  if i.deptno=10 then
  5  i.sal:=i.sal+500;
  6  elsif
  7   i.deptno=20 then
  8  i.sal:=i.sal+600;
  9  else
 10   i.sal:=i.sal+700;
 11  end if;
 12  update emp set sal=i.sal
 13  where empno=i.empno;
 14  dbms_output.put_line(rpad(i.empno,8)||''||i.ename||''||i.sal||''||i.deptno);
 15  end loop;
 16* end;


Ref cursor:
Dynamic cursor is ref cursor it refers different work area in memory.
It is used to declare a cursor w/o select stmt.
A Ref cursor can be reused if it is declared in package.
A Ref cursor can support to return more than one row from subprogram.

Two types of dynamic cursors:
I) Weak Ref cursor: The cursor variable w/o return type called as Weak Ref cursor.

syntax:  >type<typename> is Ref cursor;

II) Strong Ref cursor: The cursor variable with return type called as Strong Ref cursor.

syntax:  >type<typename> is Ref cursor
             [return <tablename>% rowtype]

note: Explicit cursor is a static cursor
          Explicit cursor refers always one work area associated with the cursor.

features of cursors:
               cursor with parameter
                for update as { of column name
                                          now wait  }
               ---> where current of <cursor>
               ---> row id
               ---> sub queries

parametric cursor: 
                A cursor define with parameter is called parametric cursor. 
the default mode of parameter is  " in ".

syntax: 
             cursor <cursor name> (parameter name dtype,---)
                                     is
                           select stmt;
