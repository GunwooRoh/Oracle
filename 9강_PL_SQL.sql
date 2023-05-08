--9��_PL_SQL.sql
--[2023-05-08 ��]

--PL/SQL
/*
    - Procedural Language extension to Structured Query Language
    - SQL�� �Ϲ� ���α׷��� ����� Ư���� ������ ���
    - ����, ��� ���� ����
    - ���ǹ�, �ݺ��� ��� ����
    
    �����
        - declareŰ���� ���
        - ������ ����� �����ϴ� �κ�
    
    �����
        - begin ~ end Ű���� ���
        - ������ �� �Ҵ�, ���ǹ�, �ݺ���, sql���� ���� ó��
        - �����ؾ� �� ������ �ִ� �κ�
        
    ����ó����
        - exception Ű���� ���
        - ����ο��� ���ܰ� �߻������� ó���ϴ� �κ�        
*/

--�����, �����, ����ó���ΰ� �ϳ��� PL/SQL����� �����ϰ�
--����Ŭ�� �� ��ϴ����� ó����
SET SERVEROUTPUT ON;
declare
    counter number;
begin
    counter := 1;
    
    counter := counter / 10;
    
    if counter is not null then
        dbms_output.put_line('counter => ' || counter);
    end if;
    
    exception when ZERO_DIVIDE then
         dbms_output.put_line('0���� ������ �ȵ˴ϴ�.');
end;         


--1~10���� for���� �̿��Ͽ� �ݺ�ó��
declare
    i   number;
    result number;
begin
    for i in 1..10 loop
        result := i * 2;
        dbms_output.put_line(result);
    end loop;
    
    exception when others then
        dbms_output.put_line('error');
end;


--while �� �̿�
declare
    i number;
    result number;
begin
    i := 1;
    while i <= 10 loop
        result := i * 3;
        dbms_output.put_line(i || '* 3 => ' || result);
        
        i := i + 1;
    end loop;
end;


--����, ��� ����
/*
   ������  ������Ÿ��;  --��������
   ������  constant ������Ÿ��;  --�������
   ������  ���̺��.�÷���%type;  --��������
        => �ش� ���̺��� �ش� �÷��� ������ Ÿ���� ���� ����
        
   ��) name  varchar2(30);
       curYear  constant number := 2019;
       empno    employees.employee_id%type;     
*/

--���ǹ�
/*
    1) if��
    if ����1 then
        ����1;
    elsif ����2 then
        ����2;
    else
        ����3;
    end if;
    
    2) case��
    case
    when ���� then
        ����1;
    else
        ����2;
    end case;
*/
--if �� �̿�
declare
    grade char;
    result varchar2(50);
begin
    grade := 'B';
    
    if grade = 'A' then
        result := 'Excellent';
    elsif grade = 'B' then
        result := 'Good';
    elsif grade = 'C' then
        result := 'Fair';
    elsif grade = 'D' then
        result := 'Poor';
    else
        result := 'Not found';
    end if;
    
    dbms_output.put_Line(grade || ' => ' || result);
    
    exception when others then
        dbms_output.put_Line('error');
end;


--case�� �̿�
declare
    grade char;
    result varchar2(50);
begin
    grade := 'C';
    
    case grade
        when grade = 'A' then
            result := 'Excellent';
        when grade = 'B' then
            result := 'Good';
        when grade = 'C' then
            result := 'Fair';
        when grade = 'D' then
            result := 'Poor';
        else
            result := 'Not found';
        end case;
    dbms_output.put_Line('case : ' || grade || ' => ' result);
    
    excpetion when others then
    dbms_output.put_Line('error');
    
end;   


--�ݺ���
/*
    1) 
        loop
            exit when ����;
            
        end loop;
    
    2)
        for ���� in [reverse] �ʱⰪ..���ᰪ loop
            ó���� ����;
        end loop;
    
    3)
        while ���� loop
            ó���� ����;
        end loop;
*/
--loop�� �̿�
declare
    i   number;
    result number;
begin
    i := 1;
    
    loop
        result := i * 2;
        
        exit when result > 20;
        dbms_output.put_Line(result);
        
        i := i + 1;
    end loop; 

    exception when others then
    dbms_output.put_Line('error');
end;

--for�� �̿�
declare
    i number;
    result number;

begin for i in 1..10 loop
    result := i * 5;
    dbms_output.put_Line('i = ' || i || ', result = ' || result);
   end loop;
   dbms_output.put_Line('-----------------for�� reverse------------------');
   
   result := 0;
   for i in reverse 1..10 loop
        result := i * 4;
        dbms_output.put_Line('i = ' || i || ', result = i ' || result);
    end loop;
    
    exception when others then
        dbms_output.put_Line('error');
end; 

--while �� �̿�
declare
    i   number;
    result number;
begin
    i := 1;
    result := 0;
    
    while result < 20 loop
        result := i * 2;
        dbms_output.put_Line(result);
        
        i := i + 1;
    end loop;
    
    exception when others then
        dbms_output.put_Line('error');
end;

/*
    �ǽ�
    
    [1] 1~20������ �� - for�� �̿�

    [2] if �� �̿�  
    1~3 => 1��б�
    4~6 => 2��б�
    7~9 => 3��б�
    10~12 => 4��б�
*/

--1

declare 
    i   number;
    result number;

begin
    result := 0;
    for i in 1..20 loop
        result := result + i;
    end loop;
    dbms_output.put_line(result);
    
    
    exception when others then
        dbms_output.put_line('error');
end;

--2
declare
    m number;
    result varchar2(50);

begin
    m := 3;
    
    if m between 1 and 3 then
        result := '1�б�';
    elsif m between 4 and 6 then
        result := '2�б�';
    elsif m between 7 and 9 then
        result := '3�б�';
    elsif m between 10 and 12 then
        result := '4�б�';
    else
        result := 'Not found';
    end if;
    
    dbms_output.put_Line(result);
    
    exception when others then
        dbms_output.put_Line('error');
end; 


--PL/SQL ���� ���α׷�
/*
    - �����ͺ��̽� ��ü�� �����ؼ� �ʿ��� ������ ȣ���Ͽ� ����� �� �ִ�
      PL/SQL���
      
    1) �Լ�(Function) - ������� ��ȯ��
        ����� ���� �Լ��� ����
        Ư�� ����� ������ ��, ������� ��ȯ�ϴ� �������α׷�
    
    2) ���� ���ν���(���� ���ν���, Stored Procedure) - ������� ��ȯ���� ����   
*/

--�Լ�
/*
    create or replace function �Լ���
    (
        �Ķ����1   ������Ÿ��,
        �Ķ����2   ������Ÿ��, ...
    )
        return ������Ÿ��
    is �Ǵ� as
        ��������
    begin
        ó���� ����
        
        exception when others then
            ����ó���� ����
    end;    
*/

--�ֹι�ȣ�� ������ ������ �����ϴ� �Լ� �����
create or replace function get_gender
(
    p_ssn   varchar2
)
return varchar2
is

    v_gender    varchar2(10);
begin
    select case when substr(p_ssn, 7, 1) in ('1', '3') then '����'
                else '����' end
                into v_gender
    from dual;
    
    return v_gender;
    
    exception when others then
        dbms_output.put_Line('error');
end;        


--�Լ� �����Ű��
select get_gender('9909221066711'), get_gender('6805242676026') from dual;
select length('java')from dual;

select gname, jumin, get_gender(jumin) ����,length(gname) �̸�����
    from gogak;


--�ֹι�ȣ�� �̿��ؼ� ���̸� ���ϴ� �Լ� �����
--�Լ��̸� - get_age
create or replace function get_age
(
    p_ssn   varchar2
)
return varchar2
is

    v_age    number;
begin
    select extract(year from sysdate) - (substr(p_ssn,1,2) +
    case when substr(p_ssn, 7, 1) in (1, 2) then 1900 
                else 2000 end)
                into v_age
    from dual;
    
    return v_age;
    
    exception when others then
        dbms_output.put_Line('error');
end;    

--�Լ� ����
select gname, jumin, get_age(jumin) ����,length(gname) �̸�����
    from gogak;


--stored procedure(���� ���ν���, ���� ���ν���)
--Ư�� ����� ���������� ���� ��ȯ������ �ʴ� �������α׷�
/*
    create or replace procedure ���ν�����
    (
        �Ķ����1   ������Ÿ��,
        �Ķ����2   ������Ÿ��, ...
    )
    is [as]
        ��������
    begin
        ó���� ����
        
        exception when others then
            ����ó��
    end;    
*/


--pd2���̺� �Է��ϴ� ���ν���
create or replace procedure pd2_insert
(
    p_pdcode    char,
    p_pdname    varchar2,
    p_price     number,
    p_company   varchar2
)
is

begin
    insert into pd2(no, pdcode, pdname, price, company)
    values(pd2_seq.nextval, p_pdcode, p_pdname, p_price, p_company);
    
    commit;
    
    exception when others then
        dbms_output.put_Line('error');
        rollback;
end;        
    
select * from pd2; 

--���� ���ν��� �����Ű��
/*
    execute ���ν����̸�(�Ķ����);
    �Ǵ�
    exec ���ν����̸�(�Ķ����);
*/
execute pd2_insert('C01', '���콺', 34000, '������');
exec pd2_insert('C02', '�����', 200000, 'LG');

select * from pd2;

--pd2 ���̺� �÷��� �����ϴ� ���ν��� �����
create or replace procedure pd2_update
(
    p_no        pd2.no%type,
    
    p_pdcode pd2.pdcode%type,
    p_pdname pd2.pdname%type,
    p_price pd2.price%type,
    p_company pd2.company%type
)
is

    v_cnt      number(3);
begin
    select count(*) into v_cnt
    from PD2
    where no = p_no;
    
    if v_cnt > 0 then
        update pd2
        set pdcode = p_pdcode, pdname = p_pdname, price = p_price,
                     company = p_company
        where no = p_no;
    end if;
    
    commit;
    
    exception when others then
    dbms_output.put_Line('error');
end;
        
--����
exec pd2_update(4, 'B03', '��ǻ��', 1500000, 'hp');
select * from pd2;

--���� ���ν���, �Լ� Ȯ��
select * from user_source
where name = 'PD2_UPDATE';

--exists �̿��� update
create or replace procedure pd2_update2
(
    p_no        pd2.no%type,
    p_pdcode pd2.pdcode%type,
    p_pdname pd2.pdname%type,
    p_price pd2.price%type,
    p_company pd2.company%type
)
is
begin
    update pd2 a
    set pdcode = p_pdcode, pdname = p_pdname, price = p_price, company = p_company
    where exists (select 1 from pd2 b where b.no = a.no and b.no = 4);
    
        commit;
    
    exception when others then
     raise_application_error(-20001, '���ܹ߻�');
     
     rollback;
end;
--����
exec pd2_update2(4, 'B04', 'Ű����', -500, 'qnix');
--error

exec pd2_update2(4, 'B04', 'Ű����', -500, 'qnix');

select * from pd2;

select * from user_constraints
where table_name = 'PD2';
select * from user_cons_columns
where table_name = 'PD2';

--%rowtype
/*
    - %type�� �����ϳ�, �� �� �̻��� ���� ���� ����
    - �ο�Ÿ�� ������ ������ ���̺� �ִ� row ���� ����
*/


--����� ���� ����



--out �Ű�����(�Ķ����)
--����� ����ϴ� �뵵�� �Ű�����

--in �Ű����� - �Ϲ����� �Ű�����, �Է¿� �Ű�����
--�����ϸ� in �Ű�����



--out �Ű������� �ִ� ���ν��� �����ϱ�


--member ���̺� update�ϴ� ���ν��� ����� �����ϱ�



--PL/SQL Ŀ��
/*
    Ŀ��
    - ������ ���� ��ȯ�Ǵ� ����� �޸� �� ��ġ�ϰ� �Ǵµ�,
    PL/SQL������ Ŀ���� ����Ͽ� �� ��� ���տ� ������ �� �ִ�.
    - Ŀ���� ����ϸ� ��������� �� ���� �����Ϳ� ������ �����ϴ�
    
    ����� Ŀ��
    - ����ڰ� ���� ������ ����� �����ؼ� �̸� ����ϱ� ���� ���������
      ������ Ŀ��
      
    ����� Ŀ���� ����ϱ� ���� ����
    [1] Ŀ�� ���� - ���� ����
    cursor  Ŀ���� is select����;
    
    [2] Ŀ�� ����(open) - ���� ����
    open Ŀ����;
    
    [3] ��ġ(fetch) - ������ ����� ����, ������ ���� ���� ���鿡 ����
    fetch Ŀ���� is ����...;
    
    [4] Ŀ�� �ݱ�(close) - �޸𸮻� �����ϴ� ������ ����� �Ҹ��Ŵ
    close  Ŀ����;  
*/



/*
    %notfound - Ŀ�������� ��� ������ �Ӽ�
    - �� �̻� ��ġ(�Ҵ�)�� �ο찡 ������ �ǹ�
    - ������ ������ ������� ��ġ�� �Ŀ� �ڵ����� ������ ���������� ��
*/

--for loop cursor��
/*
    Ŀ���� for loop���� ����ϸ� Ŀ���� open, fetch, close�� �ڵ������� �߻�
    �Ǿ����� ������ open, fetch, close���� ����� �ʿ䰡 ����
    
    ����
    for ������ (���ڵ� ������ ���� ����) in Ŀ���� loop
        ���� ����;
    end loop;
*/



--sys_refcursor
/*
    ���� ���ν����� select ������� java���� �б� ���ؼ��� sys_refcursor
    Ÿ���� ����ؾ� ��
*/
-- �ǽ�
create table person
(
  no number(4) primary key,
  name varchar2(20) not null,
  tel varchar2(20),
  regdate  date default sysdate
 );

create sequence person_seq
start with 1
increment by 1
nocache;



create or replace procedure cart_insert
(
    p_no IN cart.no%TYPE,
    p_name IN cart.name%TYPE,
    p_tel IN cart.tel%TYPE,
)
is
begin
    insert into (no, name, tel)
    values(p_no, p_name, p_tel);
    
    commit;
    
    exception when others then
        dbms_output.put_line('error');
end;
     
