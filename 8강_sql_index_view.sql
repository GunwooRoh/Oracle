--8��_sql_index_view.sql
--[2023-05-04 ��]
--sequence
/*
- �������� ���ڸ� �����س��� �����ͺ��̽� ��ü
- �⺻Ű�� ������ �ԷµǴ� row�� �ĺ��� �� �ֱ⸸ �ϸ� �ȴٰ� �Ҷ�,
  �������� ���� ������ ���� �����
  
- ���̺� �ִ� �⺻Ű ���� �����ϱ� ���� ���Ǵ� �������� ��ü
- ���̺� ���ӵ��� ���� => �ϳ��� �������� ���� ���� ���̺� ���ÿ�
  ����� �� �ִ�
  
  create sequence ��������
  minvalue      --�������� �ּҰ�
  maxvalue      --�������� �ִ밪
  start with ���۰�
  increment by ����ġ
  nocache       --cache������� �ʰڴ�
  nocycle       --������ ���������� �ִ�ġ Ȥ�� �ּ�ġ�� �ٴٶ��� ��
                   �ʱⰪ���� �ٽ� ������ �� ����
  order         --��û�Ǵ� ������� ���� ����
  
  �� ������ ���
  nextval, currval �ǻ��÷�
  1) nextval - �ٷ� ������ ������ �������� ������ �ִ�
  2) currval - ���� ���������� ������ �ִ�                  
*/


select * from pd;
select * from pd_temp1;


create table pd_temp1
as
select * from pd
where 0=1;

alter table pd_temp1
add constraint pk_pd_temp1_no primary key(no);

select * from user_constraints
where table_name = 'PD_TEMP1';


--������ ����
create sequence pd_temp1_seq
minvalue 1
maxvalue 9999999999999 --9�� 13��
increment by 1
start with 50  --50���� �����ؼ� 1�� ����
nocache;

--����ڰ� ������ ������ ��ȸ
select * from user_sequences;

select pd_temp1_seq.currval from dual;
--[Error]������ PD_TEMP1_SEQ.CURRVAL�� �� ���ǿ����� ���� �Ǿ� ���� �ʽ��ϴ�

insert into pd_temp1(no, pdname, price, regdate)
values(pd_temp1_seq.nextval, '��ǻ��',1200000,sysdate);  --seq:50

insert into pd_temp1(no, pdname, price, regdate)
values(pd_temp1_seq.nextval, '��Ʈ��',1500000,sysdate);  --seq:51

select * from pd_temp1;
select pd_temp1_seq.currval from dual;  --���� ������ ��ȣ ��ȸ : 51
select pd_temp1_seq.nextval from dual;  --���� ������ ��ȣ ��ȸ : 52
-->���� �����Ǿ� ���� => ���� ����ϸ� �� ������(53)���� ó����

insert into pd_temp1(no, pdname, price, regdate)
values(pd_temp1_seq.nextval, '�����',200000,sysdate);  --seq:53

select * from pd_temp1;

create table pd2
(
    no  number primary key,
    pdcode  char(3) not null,
    pdname  varchar2(100),
    price   number(10)  check(price>=0),
    company varchar2(100),
    regdate date default sysdate
);

--1���� �����ؼ� 1�� �����ϴ� ������ ��ü ����
create sequence pd2_seq
start with 1
increment by 1
nocache;

--������ �Է�
insert into pd2(no, pdcode, pdname, price, company)
values(pd2_seq.nextval, 'A01','�Ｚ��Ʈ��',2500000,'�Ｚ');

insert into pd2(no, pdcode, pdname, price)
values(pd2_seq.nextval, 'B01','Ű����',37000);

select * from pd2;

select * from user_sequences;

create sequence test_seq
increment by 1
start with 1
nocache;

--������ ����
--drop sequence ��������;
drop sequence test_seq;

--index
/*
    - ���̺��� �����͸� ���� ã�� ���� ����ǥ
    - �ε����� ���ٸ� Ư���� ���� ã�� ���� ��� ������ �������� �� ������ ��
      (table full scan)
    - index seek
      �ε����� ����ϴ� ���� �� ȿ�����̶��, ����Ŭ�� ��� �������� ������ 
      �ʰ� �ε��� �������� ã�Ƽ� ���� �����͸� ������
    - �� ���̺� ���� ���� �ε����� ������ �� ����
    
    create [unique] index �ε�����
    on ���̺��(�÷���1, �÷���2, ...)    
*/
--primary key�� unique ���������� �ָ� �ڵ����� unique index�� ������

select * from pd2;

--��ǰ�ڵ� �ε��� �����
create unique index idx_pd2_pdcode
on pd2(pdcode);

--��ǰ�� �ε���
create index idx_pd2_pdname
on pd2(pdname);

--��ǰ�����, ȸ�� ���� �ε���
create index idx_pd2_regdate_company
on pd2(regdate, company);

--�ε��� ��ȸ
select * from user_indexes
where table_name='PD2';
select * from user_ind_columns
where table_name='PD2';
select * from user_constraints
where table_name='PD2';

--�ε����� �̿��� ��ȸ
select * from pd2
where pdcode='B01';
select * from pd2
where pdname='Ű����';
select * from pd2
where regdate>='2023-05-04' and company='�Ｚ';

--�ε��� ����
--drop index �ε�����;
create index idx_pd2_company
on pd2(company);

drop index idx_pd2_company;

select * from user_indexes
where table_name='PD2';

--�ǽ�
/*
    1. employees ���̺��� �̿��Ͽ� employees_temp1 ���̺� ����
    2. employee_id�� �Ϸù�ȣ�� �⺻Ű�� ������ sequence ����
        ���� �����Ϳ� �̾ ���� ���� ������
    3. ������ ������ 2�� insert - sequence �̿��� ��
    4. last_name�� �ε��� ����
    5. email�� �ε��� ����
    6. job_id, hire_date�� ���� �ε��� ����
    7. ������ �ε����� �̿��Ͽ� select    
*/
select * from employees;

-- 1. employees ���̺��� �̿��Ͽ� employees_temp1 ���̺� ����
   create table employees_temp1
   as
   select * from employees;
   
   -- 2. employee_id�� �Ϸù�ȣ�� �⺻Ű�� ������ sequence ����
   --���� �����Ϳ� �̾ ���� ���� ������
   select * from employees_temp1;
   
   create sequence employees_temp1_seq
   increment by 1
   start with 207
   nocache;
   
   -- 3. ������ ������ 2�� insert - sequence �̿��� ��
   select * from employees_temp1;
   desc employees_temp1;
   
   insert into employees_temp1(employee_id,first_name,last_name,email,phone_number,
   hire_date,job_id)
   values(employees_temp1_seq.nextval,'jerry','queen','jerry','515.23.454',
   sysdate,'IT_PROG');
   
   insert into employees_temp1(employee_id,first_name,last_name,email,phone_number,hire_date,job_id)
   values(employees_temp1_seq.nextval,'kai','sa','kia','515.234.454',sysdate,'IT_PROG');
   
   -- 4. last_name�� �ε��� ����
   create index idx_employees_temp1_last_name
   on employees_temp1(last_name);
   
   -- 5. email�� �ε��� ����
   create unique index idx_employees_temp1_email
   on employees_temp1(email);
   
   -- 6. job_id, hire_date�� ���� �ε��� ����
   create index idx_employees_temp1_job_hire
   on employees_temp1(job_id,hire_date);
   
   select * from user_indexes
   where table_name='EMPLOYEES_TEMP1';
   
   -- 7. ������ �ε����� �̿��Ͽ� select    
    select * from employees_temp1
    where last_name = 'queen';
    
    select * from employees_temp1
    where email = 'kia';
    
    select * from employees_temp1
    where job_id = 'IT_PROG' and hire_date >= '2022-09-15';
    
    
--��(view)
/*
    - view�� ���̺� �ִ� �����͸� �����ִ� ������ �����ϴ�
      select������ ����ϰ� �� �� �ִ�
      
    - view�� ������ �����͸� ������ ������ ������,
      �並 ���� �����͸� ��ȸ�� �� �ְ�, �� �����͸� �Է�,����,������ �� ������
      �ٸ� ���̺�� ���ε� �� �� �ֱ� ������ 
      ������ ���� ���̺��̶�� ��
      
    create [or replace] view ���̸�
    as
    select����;    
*/
--�並 ����ϴ� ����
--1) ���ȼ�
--2) ���Ǽ�

--scott ����ڴ� emp�� ������(deptno=30) ������� �⺻����(�̸�, job, �Ի���)��
-- �˻��� �� �־�� �Ѵٸ�..

--hr����ڰ� emp���̺��� �Ϻ� �÷��� �� �� �ִ� �並 ����
--scott����ڰ� �ش� �並 �� �� �ְ� �Ѵ�

--1) hr�������� �� ���� ������ �ο��ؾ� ��
--sys ������ �������� ���� �ο��� �ؾ� ��
--grant create view to hr;

--view �������� �����ϱ�
--revoke create view from hr;

--2) hr����ڰ� view�� �����
create or replace view v_emp
as
select ename,job, hiredate
from emp
where deptno=30;

--select * from ���̺� �Ǵ� ��
--������ �� ��ȸ�ϱ�
select * from v_emp;

--3) scott���� �ش� �並 select�� �� �ִ� ������ �ο��Ѵ�

/*
    - sys�������� scott ����� ���� �����
    oracle 12c���� ������ ������ ��,  'c##�����̸�'  �̷������� �����ؾ��Ѵ�. 
    ���� 18c���� ���ʹ� ���������� ������� �ʱ� ���ؼ� ������ �������ش�
    alter session set "_ORACLE_SCRIPT"=true; 

    create user scott
    identified by scott123
    default tablespace users;
    
    - ���� �ο��ϱ�
    grant resource, connect to scott;     
*/

grant select on v_emp to scott;  --hr������ ���̹Ƿ� select ���� �ο��� ����

--��������
--revoke select on v_emp from scott;

--scott�������� �� select�ϱ�
select * from hr.v_emp; --��Ű���̸�.�����ͺ��̽� ������Ʈ��

--�� �����ϱ�
--scott����ڰ� research�μ��� ��������� ��ȸ�ؾ� �Ѵٸ�
select * from emp;
select * from dept;  --20, 30

create or replace view v_emp
as
select ename, job, hiredate
from emp
where deptno in(20,30);

select * from v_emp;

select ename, job, hiredate, deptno
from emp
where deptno in(20,30);


--������, research �ο� ���ϴ�  ����� �߿� 1982�� ������ �Ի��� ����� ������ ��ȸ�Ϸ���
--1) emp ���̺� �̿�
select * from emp
where deptno in (20,30) and hiredate<'1982-01-01';

--2) v_emp �� �̿�
select * from v_emp
where hiredate<'1982-01-01';


--������ �̿��ϴ� ��쳪 ������ �������� ��� �並 ���� ���
--employees, departments join
create or replace view v_employees
as
select e.EMPLOYEE_ID, e.FIRST_NAME || '-' || e.LAST_NAME �̸�,
    e.HIRE_DATE, e.DEPARTMENT_ID, d.DEPARTMENT_NAME,
    e.SALARY+e.SALARY*nvl(e.COMMISSION_PCT,0) �޿�
from employees e left join departments d
on e.DEPARTMENT_ID=d.DEPARTMENT_ID;

select * from v_employees;

--�ش� �信�� �޿��� 10000�̻��� ��� ��ȸ�ϱ�
select * from v_employees
where �޿�>=10000;

select * 
from 
(
    select e.EMPLOYEE_ID, e.FIRST_NAME || '-' || e.LAST_NAME �̸�,
        e.HIRE_DATE, e.DEPARTMENT_ID, d.DEPARTMENT_NAME,
        e.SALARY+e.SALARY*nvl(e.COMMISSION_PCT,0) �޿�
    from employees e left join departments d
    on e.DEPARTMENT_ID=d.DEPARTMENT_ID
)
where �޿�>=10000;


--gogak ���̺��� �� ������ ���� ����, ���� ������ view�� �����
--v_gogak_info
create or replace view v_gogak_info
as
select gno, gname, jumin,
    case when substr(jumin,7,1) in('1','3') then '��'
         else '��' end "����",
    extract(year from sysdate) 
        - (substr(jumin,1,2) +  case when substr(jumin,7,1) in ('1','2') then 1900
                                     else 2000 end) + 1 "����"     
from gogak;

--�ش� �並 �̿��Ͽ� 20��, 30�� ���ڸ� ��ȸ�ϱ�
select * 
from v_gogak_info
where trunc(����, -1) in (20,30) and ����='��';

--cf. inline �� �̿�
select * 
from
(
    select gno, gname, jumin,
        case when substr(jumin,7,1) in('1','3') then '��'
             else '��' end "����",
        extract(year from sysdate) 
            - (substr(jumin,1,2) +  case when substr(jumin,7,1) in ('1','2') then 1900
                                     else 2000 end) + 1 "����"     
    from gogak
)
where trunc(����, -1) in (20,30) and ����='��';


--�並 ���� ������ ����
/*
    1. updatable view - �並 ���� ��ȸ�� �����ϰ�, �Է�,����,������ ������
    2. read only view - ��ȸ�� ������ ��
*/

--updatable view�����
/*
    create or replace view ���̸�
    as 
        select��;
*/

--read only view�����
/*
    create or replace view ���̸�
    as 
        select��
    with read only;
*/
create or replace view v_emp_readonly
as
select ename, job, hiredate
from emp
where deptno in(20,30)
with read only;

select * from v_emp_readonly; --read only view
select * from v_emp; --updatable view
select * from emp;

update v_emp_readonly
set ename='SMITH2'
where ename='SMITH'; --ERROR:�б� ���� �信���� DML �۾��� ������ �� �����ϴ�.

update v_emp
set ename='SMITH2'
WHERE ename='SMITH';  --updatable view�� �Է�,����,���� ����

select * from emp;
select * from v_emp;

insert into v_emp(ename, job, hiredate)
values('ȫ�浿','CLERK',sysdate); --error:NULL�� EMPNO�ȿ� ������ �� �����ϴ�
-->�並 ���� �Է��� �ϴ� ���, �信 ���� �÷��� null�� ����ϰų� default���� �־�� ��
--�׷��� ������ ���� �߻�

desc emp;

create or replace view v_emp_2
as
select empno, ename, job, hiredate
from emp
where deptno in(20,30);

insert into v_emp_2(empno, ename, job, hiredate)
values(9999,'ȫ�浿','CLERK',sysdate);  --�Է°���
--���� ������ ����� ���������� �Է°����� 

select * from v_emp_2
where empno=9999;  --�Է��� �Ǿ����� ���� ������ ����Ƿ�, �信���� ��ȸ�Ұ�

select * from emp
where empno=9999;  --���̺����� ��ȸ ����

delete from v_emp_2
where empno=9999;  --���� ������ ����Ƿ�, ��ȸ�� �ȵǰ� ������ �ȵ�

select * from emp
where empno=8888;
delete from emp
where empno=8888;


/*
    �⺻������ �並 ���鶧 ���� ������ ����� ������ �����͸� ������ �� ������
    �̸� ������� �ʰ��� �Ҷ��� with check option�� ���
*/


