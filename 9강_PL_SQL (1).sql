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

declare  --����� : ������ �����ϴ� �κ�
    counter number;
begin  --����� : ó���� ������ �ִ� �κ�
    counter := 1; --������ �� �Ҵ�
    
    --���� ó��
    counter := counter/10;
    
    if counter is not null then
        dbms_output.put_line('counter => ' || counter);
    end if;
    
    --exception when others then --����ó����
    exception when ZERO_DIVIDE then
        dbms_output.put_line('0���� ������ �ȵ˴ϴ�.');
end;    


--1~10���� for���� �̿��Ͽ� �ݺ�ó��
declare
    i   number;
    result  number;
begin
    for i in 1..10 loop
        result:=i*2;
        dbms_output.put_line(result);
    end loop;

    exception when others then
        dbms_output.put_line('error!');
end;


--while �� �̿�
declare
    i   number;
    result  number;
begin
    i:=1;
    while i<=10 loop
        result:=i*3;
        dbms_output.put_line(i || '*3 =>' || result);
        
        i:=i+1;
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
    
    if grade='A' then
        result:='Excellent';
    elsif grade='B' then
        result:='Good';
    elsif grade='C' then
        result:='Fair';
    elsif grade='D' then
        result:='Poor';
    else
        result:='Not found!';
    end if;
    
    dbms_output.put_line(grade || '=>' || result);
        
    exception when others then
        dbms_output.put_line('error!');
end;


--case�� �̿�
declare
    grade char;
    result varchar2(50);
begin
    grade:='C';
    
    case grade
        when 'A' then
            result:='Excellent';
        when 'B' then
            result:='Good';
        when 'C' then
            result:='Fair';
        when 'D' then
            result:='Poor';
        else
            result:='not found!';
        end case;
            
    dbms_output.put_line('case��: ' || grade || '=>' || result);
    
    exception when others then
        dbms_output.put_line('error!');
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
    i:=1;
    
    loop
        result:=i*2; --2...18,20,22
        
        exit when result>20; --������ �����ϸ� �ݺ��� Ż��
        dbms_output.put_line(result); --2,..18,20
        
        i:=i+1; --2, ..9,10,11
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;


--for�� �̿�
declare
    i   number;
    result  number;
begin
    for i in 1..10 loop
        result:=i*5;
        dbms_output.put_line('i=' || i || ', result=' || result);
    end loop;

    dbms_output.put_line('----------for�� reverse �̿�------------');
    
    result:=0;
    for i in reverse 1..10 loop
        result:=i*4;
        dbms_output.put_line('i=' || i || ', result = ' || result);
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;


--while �� �̿�
declare
    i   number;
    result  number;
begin
    i:=1;
    result:=0;
    
    while result<20 loop
        result:=i*2; --2, ..18,20
        dbms_output.put_line(result); --2,...18,20
        
        i:=i+1; --2, ..9,10,11
    end loop;

    exception when others then
        dbms_output.put_line('error!');
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

--[1] 1~20������ �� - for�� ���
declare
    i   number;
    result  number;
begin
    result := 0;
    for i in 1..20 loop
        result := result + i;
    end loop;
    
    dbms_output.put_line('1~20������ �� : ' || result);
    
    exception when others then
        dbms_output.put_line('Error!');
end;

--[2] �б⳪���� - if�� ��� 
declare
    month   number;
    result  varchar2(20);
begin
    month := 5;
    
    if month in (1, 2, 3) then 
        result := '1�б�';
    elsif month in (4, 5, 6) then 
        result := '2�б�';
    elsif month in (7, 8, 9) then 
        result := '3�б�';
    elsif month in (10, 11, 12) then 
        result := '4�б�';
    end if;
    
    dbms_output.put_line(month || '���� ' || result);
    
    month:=7;
    
    if month between 1 and 3 then
        result := '1��б�';
    elsif month between 4 and 6 then
        result := '2��б�';
    elsif month between 7 and 9 then
        result := '3��б�';
    elsif month between 10 and 12 then
        result := '4��б�';
    else
        result := '�߸��Է�!';
    end if;

    dbms_output.put_line(month || '���� ' || result);
    
    exception when others then
        dbms_output.put_line('Error!');
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
    --�Ķ����
    p_ssn   varchar2
)
return varchar2  --��ȯŸ��
is
    --���� ����
    v_gender    varchar2(10);
begin
    --ó���� ����
    select case when substr(p_ssn, 7,1) in ('1','3') then '����'
            else '����' end
           into v_gender
    from dual;
    
    return v_gender;
    
    exception when others then
        dbms_output.put_line('error!');        
end;    

--�Լ� �����Ű��
select get_gender('9901081112222'), get_gender('0305094445555') from dual; --����������Լ�
select length('java') from dual; --����Ŭ �Լ�

select gname, jumin, get_gender(jumin) ����, length(gname) "�̸�����"
 from gogak;


--�ֹι�ȣ�� �̿��ؼ� ���̸� ���ϴ� �Լ� �����
--�Լ��̸� - get_age
create or replace function get_age
(
    --�Ķ����
    p_ssn   varchar2
)
return number  --��ȯŸ��
is
    --��������
    v_age    number(3);
begin
    --ó���� ����
    select extract(year from sysdate) 
        - (substr(p_ssn,1,2) +  case when substr(p_ssn,7,1) in ('1','2') then 1900
                                     else 2000 end) + 1
        into v_age                                
    from dual;
    
    return v_age;
    
    exception when others then
        dbms_output.put_line('error');
end;

--�Լ� ����
select get_age('0005094445555') from dual;
select studno, name, grade, jumin, get_age(jumin) from student;

select gname, jumin, get_gender(jumin) gender, get_age(jumin) age,
    trunc(get_age(jumin),-1) ���ɴ�
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
    --�Ķ����
    --pd2 ���̺� insert�Ҷ� �ʿ��� �Ķ���͵�
    p_pdcode    char,
    p_pdname    varchar2,
    p_price     number,
    p_company   varchar2
)
is
--���� ����
begin
    insert into pd2(no, pdcode, pdname, price, company)
    values(pd2_seq.nextval, p_pdcode, p_pdname, p_price, p_company);        

    commit; --�����ϸ� Ŀ��
    
    exception when others then
        dbms_output.put_line('pd2 insert error!');
        rollback;  --�����ϸ� �ѹ�
end;

--���� ���ν��� �����Ű��
/*
    execute ���ν����̸�(�Ķ����);
    �Ǵ�
    exec ���ν����̸�(�Ķ����);
*/
execute pd2_insert('C01','���콺',34000,'������');
exec pd2_insert('C02','�����',280000, 'LG');

select * from pd2;


--pd2 ���̺� �÷��� �����ϴ� ���ν��� �����
create or replace procedure pd2_update
(
    --�Ķ����
    no    pd2.no%type,  --���̺��.�÷���%type => �ش� ���̺��� �ش� �÷��� ������ ������Ÿ��
                          --pd2 ���̺��� no �÷��� ������ Ÿ��
    p_pdcode  pd2.pdcode%type,
    p_pdname  pd2.pdname%type,
    p_price   pd2.price%type,
    p_company pd2.company%type                            
)
is
    --���� �����
    v_cnt   number(3);
begin
    select count(*) into v_cnt
    from PD2
    where no=p_no;
    
    --�ش� �����Ͱ� �����ϸ� update
    if v_cnt>0 then
        update pd2
        set pdcode=p_pdcode, pdname=p_pdname, price=p_price,
            company=p_company
        where no=p_no;
    end if;
    
    commit;
    
    exception when others then
        dbms_output.put_line('pd2 update error!');
        rollback;
end;

--����
exec pd2_update(4,'B03','��ǻ��',1500000,'hp');
select * from pd2;

--���� ���ν���, �Լ� Ȯ��
select * from user_source
where name='PD2_UPDATE';

--exists �̿��� update
create or replace procedure pd2_update2
(
    --�Ķ����
    p_no    pd2.no%type,
    p_pdcode    pd2.pdcode%type,
    p_pdname    pd2.pdname%type,
    p_price    pd2.price%type,
    p_company    pd2.company%type
)
is
begin
    update pd2 a
    set pdcode=p_pdcode, pdname=p_pdname, price=p_price, company=p_company
    where exists (select 1 from pd2 b where b.no=a.no and b.no=p_no);
    
    commit;
    
    exception when others then
        raise_application_error(-20001, 'pd2 update �� ���ܹ߻�!');
        --����� ���� ���ܹ�ȣ�� -20001~ 20999����
        
        rollback;
end;

--����
exec pd2_update2(4, 'B04','Ű����',-500, 'qnix'); 
--> error

exec pd2_update2(4, 'B04','Ű����',19000, 'qnix'); 

select * from pd2;

select * from user_constraints
where table_name='PD2';
select * from user_cons_columns
where table_name='PD2';

--%rowtype
/*
    - %type�� �����ϳ�, �� �� �̻��� ���� ���� ����
    - �ο�Ÿ�� ������ ������ ���̺� �ִ� row ���� ����
*/
create or replace procedure prof_info
(
    p_profno    professor.profno%type
)
is
    v_prof_row  professor%rowtype;  --professor ���̺��� �� �� ���ڵ�(row) ������ 
                                    --���� �� �ִ� Ÿ��
    v_result    varchar2(2000);                                
begin
    select * into v_prof_row
    from professor
    where profno=1003;
    
    v_result := v_prof_row.profno || ' ' || v_prof_row.name || ' ' ||
                v_prof_row.position || ' ' ||
                (v_prof_row.pay + nvl(v_prof_row.bonus, 0));
    
    dbms_output.put_line(v_result);
    
    exception when others then
        raise_application_error(-20002, 'professor ���̺� ��ȸ ����!');
end;

exec prof_info(1001);
select * from professor;

select * from member;
select * from user_sequences;

create sequence member_seq
start with 1005
increment by 1
nocache;

desc member;

--����� ���� ����
create or replace procedure member_insert
(
    p_name  member.name%type,
    p_jumin  member.jumin%type,
    p_pwd  member.passwd%type,
    p_id  member.id%type
)
is
    system_check_insert_fail  exception; --����� ���� ����
begin
    --�Ͽ��� 23:00:00 ~ 23:59:59 ���̿��� �ý��� �۾����� ���� �Է� �Ұ�
    /*
    if to_char(sysdate, 'd')=1 and to_char(sysdate, 'HH24')=23  then
        raise system_check_insert_fail; --����� ���� ���� �߻���Ű��
    end if;*/
    
    if to_char(sysdate, 'd')=2 and to_char(sysdate, 'HH24')=17  then
        raise system_check_insert_fail; --����� ���� ���� �߻���Ű��
    end if;
    
    --�Ͽ��� 23�� �ð��밡 �ƴϸ� �Է� ����
    insert into member(no, name, jumin, passwd, id)
    values(member_seq.nextval, p_name, p_jumin, p_pwd, p_id);
    
    commit;
    
    exception when system_check_insert_fail then
        raise_application_error(-20998,'�Ͽ��� 23�� �ð��뿡�� �ý��� ���� �۾����� ���� �̿�Ұ�');
        rollback;
end;

exec member_insert('ȫ�浿2', '9801081112222','123','hong2');

select * from member;

--out �Ű�����(�Ķ����)
--����� ����ϴ� �뵵�� �Ű�����

--in �Ű����� - �Ϲ����� �Ű�����, �Է¿� �Ű�����
--�����ϸ� in �Ű�����

select * from professor;

create or replace procedure prof_info2
(
    p_profno    in  professor.profno%type,  --in �Ű�����
    o_name      out professor.name%type,  --out�Ű�����
    o_pay       out professor.pay%type  --out�Ű�����
)
is
begin
    select name, pay into o_name, o_pay
    from professor
    where profno=p_profno;
    
    exception when others then
        raise_application_error(-20003, 'professor ��ȸ ����!');
end;

--out �Ű������� �ִ� ���ν��� �����ϱ�
declare
    v_name  professor.name%type;
    v_pay   professor.pay%type;
begin
    prof_info2(1003, v_name, v_pay);
    
    dbms_output.put_line('�̸�:' || v_name || ', �޿�:' || v_pay);
    
    exception when others then
        dbms_output.put_line('error');
end;    

--[]
--member ���̺� update�ϴ� ���ν��� ����� �����ϱ�
select * from member;

create or replace procedure member_update
(
    p_no        member.no%type,
    p_name      member.name%type,
    p_jumin     member.jumin%type,
    p_passwd    member.passwd%type,
    p_id        member.id%type
)
is
begin
    update member
    set name = p_name, jumin = p_jumin, passwd = p_passwd, id = p_id
    where no = p_no;
    
    commit;
    
    exception when others then
        raise_application_error(-20005, 'error');
        rollback;
end;

exec member_update(1005, '��浿', '9805072223333', '111', 'Kim');

select * from member;

--
create or replace procedure pd2_select
is
begin
    --select * from pd2; error
    
    exception when others then
        raise_application_error(-20006, 'error');    
        rollback;
end;

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

create or replace procedure pd2_select
is
    cursor pd2_csr is
        select no, pdcode, pdname, price from pd2;
        
        pd2_row pd2%rowtype;
begin

    open pd2_csr;
    
    loop
        fetch pd2_csr into pd2_row.no, pd2_row.pdcode, pd2_row.pdname,
            pd2_row.price;
            exit when pd2_csr %notfound;
            
            dbms_output.put_Line(pd2_row.no || ' ' || pd2_row.pdcode || ' ' || 
                pd2_row.pdname || ' ' || pd2_row.price);
    end loop;
    
    close pd2_csr;
    
    exception when others then
        raise_application_error(-20006, 'error');
end;

exec pd2_select();
select * from pd2;
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

create or replace procedure pd2_select2
is
    cursor pd2_csr is
        select no, pdcode, pdname, price from pd2 order by no;
        
begin
    for pd2_row in pd2_csr loop
        dbms_output.put_Line(pd2_row.no || ' ' || pd2_row.pdcode || ' ' || 
            pd2_row.pdname || ' ' || pd2_row.price || ' ' || );
    end loop;
    
    exception when others then
        raise_application_error(-20007, 'error');
end;



--sys_refcursor
/*
    ���� ���ν����� select ������� java���� �б� ���ؼ��� sys_refcursor
    Ÿ���� ����ؾ� ��
*/
create or replace procedure pd2_select3
(
    pd2_cursor out SYS_REFCURSOR
)
is
begin
    open pd2_cursor for
        select no, pdcode, pdname, price, company, regdate
        from pd2;
        
    exception when others then
        raise_application_error(-20009, 'error');
end;



