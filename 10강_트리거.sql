--10��_Ʈ����.sql

/*
    �� Ʈ����
    - ���� ���α׷� ������ �ϳ��� Ʈ���Ŵ� ���̺�, ��, ��Ű�� �Ǵ� �����ͺ��̽�
    �� ���õ� PL/SQL �������
    ���õ� Ư�� ���(event)�� �߻��� ������ �ڵ����� �ش� PL/SQL �����
    �����
    
    -insert, update, delete �� DML���̳� DDL���� ������
     �����ͺ��̽������� Ư�� �̺�Ʈ�� �߻��Ǿ��ٰ� ��
     
    �� �ֿ� Ʈ���� ����
    [1] DML Ʈ����
        1) ���� Ʈ���� - ������ �޴� ���� ���� ������ Ʈ���Ű� �ѹ��� �����
        2) �� Ʈ���� - ���̺��� Ʈ���� �̺�Ʈ�� ������ ���� ������ ����ǰ�,
            Ʈ���� �̺�Ʈ�� ������ �޴� ���� ���� ��쿡�� ������� ����
            
    [2] DML�� �ƴ� Ʈ����
        1) DDL �̺�Ʈ Ʈ����
        - DML Ʈ���ſ� ���� ���������� Ʈ���Ÿ� Ȱ���Ͽ� DDL�۾��� �ϴ� �͸�
          �ٸ�
          
        2) �����ͺ��̽� �̺�Ʈ Ʈ����
        - �����ͺ��̽� ������ ����� �ϵ��� �����ϱ� ���ؼ� �����ϴ� Ʈ����         
*/

/*
    create or replace trigger Ʈ���� �̸�
        Ʈ���� ������� [before/after]
        �̺�Ʈ [insert | update | delete]
        on {���̺��̸� | ���̸� | ��Ű�� | �����ͺ��̽�}
    [for each row]
    begin
        Ʈ���� ��ü
    end;    
*/
--[1] �μ� ���̺�(dept)�� insert�� ���� �� �޽����� ����ϴ� Ʈ����
--(���� ���� Ʈ����)
create or replace trigger tr_dept_insert
after insert on dept
begin
    dbms_output.put_line('���������� �Էµ�!');
end;

select * from user_triggers; --����ڰ� ���� Ʈ���� ���� ��ȸ
select * from dept;

insert into dept(deptno, dname, loc)
values(60, 'TEST', 'seoul'); --dept���̺� insert �̺�Ʈ�� �߻��� �Ŀ�
--tr_dept_insert Ʈ���Ű� �����


--[2] ���̺� �����͸� �Է��� �� �ִ� �ð� �����ϱ�(���� ���� Ʈ����)

create table t_order(
    no number,
    ord_code    varchar2(10),
    ord_date    date
);


--�Է½ð��� 17:45 ~ 17:50 �� ��츸 �Է��� ����ϰ�, 
--�� �� �ð��� ���� ������ �߻���Ű�� Ʈ����
create or replace trigger tr_check_time
before insert on t_order
begin
    if to_char(sysdate, 'HH24:mi') not between '17:45' and '17:50' then
        raise_application_error(-20009, '17:45 ~ 17:50 �� ��츸 �Է� ����!');
    end if;
end;

insert into t_order(no, ord_code, ord_date)
values(3, 'A03', sysdate);

select * from t_order;

--[3] ���̺� �Էµ� ������ ���� �����ϰ�, �� �� �ܿ��� ������ �߻���Ű�� Ʈ����
--(�� ���� Ʈ����)
--��ǰ �ڵ尡 'C100'�� ��ǰ�� �Էµ� ��� �Է��� ����ϰ�, ������ ��ǰ�� ��� ������ �߻���Ű�� Ʈ����
drop trigger tr_check_time;

create or replace trigger tr_code_check
before insert on t_order
for each row  --�� ���� Ʈ����
begin
    if :new.ord_code != 'C100' then
        raise_application_error(-20010, '��ǰ�ڵ尡 C100�� ��ǰ�� �Է� ����!');
    end if;
end;

select * from t_order;

insert into t_order(no, ord_code)
values(4, 'C100');

insert into t_order(no, ord_code)
values(5, 'C200'); --error


/*
old - ������ �� ���� ���� ���� ������ ����
new - �����Ͱ� �߰� Ȥ�� ����Ǹ� new �����ڷ� ���� ���� ���� ���� �� ����
user - ���� �������� ����ڸ� ��Ÿ��
*/



--[4] ���� ���̺�(t_test1)�� �����Ͱ� ������Ʈ�� �� ���� ������ 
--��� ���̺�(t_test1_bak)�� �̵���Ű�� Ʈ����

create table t_test1(
    no number,
    name    varchar2(10)
);

create table t_test1_bak
as 
select * from t_test1;

insert into t_test1 values(1, 'AAA'); 
insert into t_test1 values(2, 'BBB'); 
commit;

select * from t_test1;
select * from t_test1_bak;

create or replace trigger tr_backup_t_test1
after update on t_test1
for each row
begin 
    insert into t_test1_bak(no, name)
    values (:old.no, :old.name);
end;

update t_test1
set name = 'CCC'
where no = 1;

update t_test1
set name = 'DDD';

select * from t_test1;
select * from t_test1_bak;
--[5] ���� ���̺�(t_test2)�� �����Ͱ� ������ �� ���� ������ 
--��� ���̺�(t_test2_bak)�� �̵���Ű�� �̶� ��� ���̺� ������ �ð�, 
--���� �� �����͸� ��� ����ϴ� Ʈ����

create table t_test2(
    no number,
    name    varchar2(10)
);
create table t_test2_bak(
    no number,
    name    varchar2(10),
    regdate date default sysdate
);
insert into t_test2 values(1, 'AAA'); 
insert into t_test2 values(2, 'BBB'); 
commit;


create or replace trigger tr_backup_t_test2
after delete on t_test2
for each row
begin
    insert into t_test2_bak
    values(:old.no, :old.name, sysdate);
end;

select * from user_triggers;

delete from t_test2;

insert into t_test2 values(5, 'FFF');
insert into t_test2 values(6, 'GGG');
rollback;
commit;

delete from t_test2
where no = 5;

select * from t_test2;
select * from t_test2_bak;

--[6] ���� ���̺�(t_test3)�� �߰�, ����, ������ ������ ������ �α� ���̺��� 
--�����Ͽ� ����� ���⵵�� Ʈ���Ÿ� ����

create table t_test3(
    no number,
    name    varchar2(10)
);

create table t_test3_history(
    o_no number, --�������̳� ������ �����͸� �����ϴ� Į���� o�� ����
    o_name    varchar2(10),    
    n_no number, --���� �ĳ� �߰��� �����͸� �����ϴ� Į���� ������ n���� ����
    n_name    varchar2(10),
    who varchar2(30), --� ����ڰ� � �۾��� �����۾� �ߴ��� ������ ����
    regdate    date default sysdate,
    chk char(1)        
);

insert into t_test3 values(1, 'AAA'); 
insert into t_test3 values(2, 'BBB'); 

commit;

create or replace trigger tr_insert_t_test3
after insert on t_test3
for each row
begin
        insert into t_test3_history(n_no, n_name, who, regdate, chk)
        values (:new.no, :new.name, user, sysdate, 'I');
end;        

select * from t_test3;
select * from t_test3_history;

create or replace trigger tr_regdate
before insert on t_test3
for each row
begin
    insert into t_test3_history(n_no, n_name, who, regdate, chk)
    values (:new.no, :new.name, user||':insert', sysdate, 'I');
end;

update t_test3
set name = 'CCC'
where  no = 1;

select * from t_test3;
select * from t_test3_history;


create or replace trigger tr_delete_t_test3
after delete on t_test3
for each row
begin
        insert into t_test3_history(n_no, n_name, who, regdate, chk)
        values (:new.no, :new.name, user, sysdate, 'D');
end;   

--�ǽ�
/*
-��ǰ�� �԰�Ǹ� ��� ���̺��� �ڵ����� �ش� ��ǰ�� ��� ������ �ݾ��� �����Ǵ� Ʈ���� �ۼ��ϱ�
insert into �԰� values(100, 2, 1800);

-��ǰ�� �ǸŵǸ� ��� ���̺��� �ڵ����� �ش� ��ǰ�� ��� ������ �ݾ��� ���ҵǴ� Ʈ���� �ۼ��ϱ�
insert into �Ǹ� values(100, 3, 2700);
*/

create table ��ǰ(
    ǰ�� number,
    �׸�� varchar2(20), 
    �ܰ� number
);
create table �԰�(
    ǰ�� number,
    ���� number, 
    �ݾ� number
);
create table �Ǹ�(
    ǰ�� number,
    ���� number, 
    �ݾ� number
);
create table ���(
    ǰ�� number,
    ���� number, 
    �ݾ� number
);
insert into ��ǰ
values(100, '�����',900);
insert into ��ǰ
values(200, '���ڱ�',900);
insert into ��ǰ
values(300, '������',1000);

insert into �԰� values(100, 10,9000);
insert into �԰� values(200, 10,9000);
insert into �԰� values(300, 10,10000);

insert into ��� values(100, 10,9000);
insert into ��� values(200, 10,9000);
insert into ��� values(300, 10,10000);

commit;


select * from ��ǰ;
select * from �԰�;
select * from �Ǹ�;
select * from ���;

--����
insert into �԰� values(100, 2, 1800);

create or replace trigger tr_����
after insert on �԰�
for each row
begin
    update ��� set
    ���� = ���� + :new.����,
    �ݾ� = �ݾ� + :new.�ݾ�;
end;

select * from ��ǰ;
select * from �԰�;
select * from ���;
select * from �Ǹ�;

--�Ǹ�
insert into �Ǹ� values(100, 3, 2700);

create or replace trigger tr_�Ǹ�
after delete on �԰�
for each row
begin
    update ��� set
    ���� = ���� - :new.����,
    �ݾ� = �ݾ� - :new.�ݾ�;
end;

select * from ��ǰ;
select * from �԰�;
select * from ���;
select * from �Ǹ�;


--�м��Լ�
--�����Լ� - rank(), dense_rank(), row_number()

/*
    rank | dense_rank | row_number()
    over(<partition by��>, <order by ��>)
*/
--�޿��� ���� ������� ������ �ο��Ͽ� ���
select * from employees;

select employee_id, first_name || '-' || last_name �̸�, hire_date, salary,
        department_id,
        rank() over(order by salary desc) as "��ü����(rank)",
        rank() over(partition by department_id order by salary desc) as "�μ��� ���� (rank)",
        dense_rank() over(order by salary desc) as "�������(dense_rank)",
        dense_rank() over(partition by department_id order by salary desc) as "�μ��� ���� (dense_rank)",
        row_number() over(order by salary desc) as "�������(row_number)",
        row_number() over(partition by department_id order by salary desc) as "�μ��� ���� (row_number)"
from employees
--order by department_id, salary desc;

order by salary desc;

--�޿��� ���� ���� ��� (1~5��)������ ��ȸ�ϱ�
--rank�̿�



--top-n �м�
--�Ի��� �������� ������ �� ��ȸ�ϱ� - emp
select row_number() over(order by hiredate desc) No,
    empno, ename, hiredate
from emp;

select rownum No, A.*
from
(
    select empno, ename, hiredate from emp
    order by hiredate desc
)A;

--�ֱٿ� �Ի��� 7���� ������� ��ȸ
--1) rownum �̿�
select rownum No, A.*
from
(
    select empno, ename, hiredate from emp
    order by hiredate desc
)A
where rownum <= 7;

--2) row_number() �̿�
select row_number() over(order by hiredate desc) No,
    empno, ename, hiredate
from emp
where rownum <= 7;



--professor ���̺��� ��������  ������ȣ�� �̸�, �޿�, �޿� ������ ��ȸ�Ͻÿ�
select * from professor;
select  profno, name, pay,
        rank() over(order by pay desc) as "��ü����(rank)",
        rank() over(partition by deptno order by pay desc) as "�μ��� ���� (rank)"
from professor; 


--�� �������� �޿� ���� 1~7�� ������ ��ȸ - inline view �̿�
select *
from
(       select profno, name, pay,
            rank() over(order by pay desc) as "��ü����(rank)",
            rank() over(partition by deptno order by pay desc) as "�μ��� ���� (rank)"
        from professor)
where "��ü����(rank)" <= 7;

--emp ���̺��� ����Ͽ� ���, �̸�, �޿�, �μ���ȣ, �μ��� �޿������� ��ȸ�Ͻÿ�
--partition by - �� ���� �ڿ� �׷��� �� �÷��� �����ָ� ��
select * from emp;

select empno, ename, sal, deptno, 
        rank() over(order by sal desc) as "��ü����(rank)",
        rank() over(partition by deptno order by sal desc) as "�μ��� ���� (rank)"
from emp;

--emp ���̺��� ����Ͽ� ���, �̸�, �޿�, �μ���ȣ, �μ� �� job���� �޿������� ��ȸ�Ͻÿ�
select empno, ename, sal, deptno, job,
        rank() over(partition by deptno, job order by sal desc) as "�μ� �� job�� �޿� ����"
from emp
order by deptno, job, "�μ� �� job�� �޿� ����";


--���� �հ� ���ϱ�
--��ǰ �ڵ庰, ��¥�� ���� �Ǹŷ�
select p_code, p_date, p_qty,
    sum(p_qty) over(partition by p_code order by p_date) �����Ǹŷ�
from panmae
order by p_code, p_date;


select p_code, p_date, qty_total �Ǹŷ�,
    sum(qty_total) over(partition by p_code order by p_date) �����Ǹŷ�
from
(
    select p_code, p_date, sum(p_qty) as qty_total
    from panmae
    group by p_code, p_date
);
   
create or replace view v_panmae
as
select p_code, p_date, qty_total �Ǹŷ�,
    sum(qty_total) over(partition by p_code order by p_date) �����Ǹŷ�
from
(
    select p_code, p_date, sum(p_qty) as qty_total
    from panmae
    group by p_code, p_date
);    

select * from v_panmae;

--��ü ���ں��� ���� �Ǹŷ�, ���� �Ǹűݾ� ���ϱ�
select p_date, sum(p_qty) qty, sum(p_total) price
from panmae
group by p_date
order by p_date desc;

select p_date, qty �Ǹŷ�, price �Ǹűݾ�,
        sum(qty) over(order by p_date) �����Ǹŷ�,
        sum(price) over(order by p_date) �����Ǹűݾ�
from
(
    select p_date, sum(p_qty) qty, sum(p_total) price
    from panmae
    group by p_date
);

--p_store���� ���� �Ǹűݾ� ���ϱ�
--�Ǹ����ڷ� �����ؼ� ����

select p_date, p_store, sum(p_total)
from panmae
group by p_store,p_date;

select p_store, p_date, sum(price) over(partition by p_store order by p_date) ������, price
from 
(
    select p_store, p_date, sum(p_total) price
    from panmae 
    group by p_store, p_date
);