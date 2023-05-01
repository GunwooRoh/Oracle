--6��_insert.sql
--[2023-05-01]
--1. insert�� - �����͸� �Է��ϴ� DML
/*
    [1] ������ �Է��ϱ�
    insert into ���̺��(�÷�1, �÷�2, ...)
    values(��1, ��2, ...);
*/

/*
��1) dept2 ���̺� �Ʒ��� ���ο� �μ� ������ �Է��Ͻÿ�
�μ���ȣ : 9000, �μ���: Ư��1��
�����μ� : 1006 (������), ���� : �ӽ�����
*/
select * from dept2
order by dcode desc;

insert into dept2(dcode, dname, pdept, area)
values('9000', 'Ư��1��', '1006', '�ӽ�����');

insert into dept2(dname, dcode, area,  pdept)
values('Ư��2��',9001, '�ӽ�����',  1006); --������ �÷� ������� �Է�

--�Ϻ� �÷��� �Է��ϴ� ��� - not null�� �÷��� �ݵ�� ���� �Է��ؾ� ��
insert into dept2(dcode, dname)
values(9003, 'Ư��3��');

insert into dept2(dcode, pdept)
values(9004, 1006); --error:NULL�� DNAME �ȿ� ������ �� �����ϴ�
--dname�� not null�ε� ���� �Է����� �ʾƼ� ���� �߻�

desc dept2;

--��� �÷��� �����͸� �Է��ϴ� ��� => �÷��� ���� ����
insert into dept2
values(9002,'Ư��4��',1006, '�ӽ�����');

select * from dept2
order by dcode desc;


--null �Է��ϱ�
/*
1) �����͸� �Է����� ������ null �� �Էµ�
2) ���� null�� �Է��ص� null�� �Էµ�
*/
select * from dept2 
order by dcode desc;

insert into dept2(dcode, dname, pdept)
values(9004, 'Ư��5��', null);

--��3) ��¥ ������ �Է��ϱ�
/*
�Ʒ� ������ professor ���̺� �Է��Ͻÿ�
������ȣ : 5001, �����̸�: �輳��
ID : kimsh, Position : ������
Pay : 510, �Ի��� : 2013�� 2�� 19��
*/
select * from professor;

insert into professor(profno, name, id, position, pay, hiredate)
values(5001,'�輳��','kimsh', '������',510,'2013-02-19');

desc professor;

--[2] ���� �� �Է��ϱ�
/*
    insert into ���̺��(�÷�1, �÷�2, ...)
    select��
    
    => select���� �÷��� ������ ������ Ÿ���� ��ġ�ؾ� �Է� ������
*/

select * from pd
order by no desc;

select * from product;

insert into pd(no, pdname, price, regdate)
select p_code, p_name, p_price, sysdate
from product
where p_code in (102,103,104);

commit;

/*
�� Ʈ�����(Transaction)
-���࿡�� ���� ��,���(�۱�)�� ���� ����
-���࿡���� �۱� ��ü�� �ϳ��� Ʈ�����(�ŷ�)�� ���� A���忡�� ����� ���� 
B���忡 ��Ȯ�� �Ա��� Ȯ�εǸ� �� �� �ŷ��� �����Ŵ(commit)
��Ʈ��ũ ��ַ� ���� ��ݸ� �߻��ϰ� �Ա��� ���� �ʾ��� ��쿡�� 
�̸� ��� ���(rollback)�ϰ� ��

Transaction
-������ �۾� ����
-���� ���� DML �۾����� �ϳ��� ������ ���� �� ��
-�ش� Ʈ����� ���� �ִ� ��� DML�� �����ؾ� �ش� Ʈ������� �����ϴ� ���̰� 
���� 1���� DML�̶� �����ϸ� ��ü�� �����ϰ� ��

commit - Ʈ����� ���� �۾��� ����� Ȯ���ϴ� ��ɾ�
         �޸� �󿡼� ����� ������ ������ ���Ͽ� �ݿ�.
Rollback - Ʈ����� ���� ��� ��ɾ���� ����ϴ� ��ɾ�
         �޸� �󿡼� ����� ������ ������ ���Ͽ� �ݿ����� �ʰ� ����.
*/

--[3] ���̺��� �����ϸ鼭 ������ �Է��ϱ�
/*
    create table �ű� ���̺��
    as
    select �����÷�1, �����÷�2, ...from ���� ���̺��;
    
    - �ű� ���̺��� ����� ���ÿ� �ٸ� ���̺��� select�� �÷��� ��� �����͸�
      insert��Ŵ
    - select���� ���̺�� �÷��� ���������� �������� �ʱ� ������ �ű� ���̺�
      ���� ���̺�� �÷� ���������� �����ؾ� ��
      pk(primary key)���� �������� ����   
*/
create table professor2  --professor2 ���̺��� ������
as
select * from professor;

select * from professor2;

desc professor;
desc professor2;

--employees, departments ���̺��� ������ ����� imsi_tbl�� ����鼭 �Է�
create table imsi_tbl
as
select e.EMPLOYEE_ID, e.FIRST_NAME || '-' || e.LAST_NAME as Name,
    e.HIRE_DATE, nvl2(e.COMMISSION_PCT, salary+salary*e.commission_pct, salary) as Pay,
    e.DEPARTMENT_ID, d.DEPARTMENT_NAME
from employees e join departments d
on e.DEPARTMENT_ID=d.DEPARTMENT_ID;

select * from imsi_tbl;
/*
=> insert���� �÷� ����Ʈ�� ���� ���¿��� select�� �÷� ����Ʈ�� �Լ��� 
����ƴٸ� ��Ī�� �Ἥ insert�Ǵ� �������� �÷����� ��������� ��
�׷��� ������ ����
*/

create table imsi_tbl2(emp_id, name, hiredate, pay, dept_id, dept_name)
as
select e.EMPLOYEE_ID, e.FIRST_NAME || '-' || e.LAST_NAME,
    e.HIRE_DATE, nvl2(e.COMMISSION_PCT, salary+salary*e.commission_pct, salary),
    e.DEPARTMENT_ID, d.DEPARTMENT_NAME
from employees e join departments d
on e.DEPARTMENT_ID=d.DEPARTMENT_ID;

select * from imsi_tbl2;

/*
=> create table���� �÷����� �����ϸ�
�ű� ���̺� �÷� ����Ʈ�� ���ǵǸ鼭 select���� ���� �ʿ��� �����Ͱ� 
insert��
*/

--2. update��
--���� �����͸� �ٸ� �����ͷ� ������ �� ����ϴ� ���
/*
    update ���̺�
    set �÷���1=��1, �÷���2=��2, ... 
    where ����
*/

--[1] update
--��1) Professor ���̺��� ������ �������� �������� bonus�� 100�������� �λ��Ͻÿ�
select * from professor
where position ='������';

update professor
set bonus=100
where position ='������';

rollback;

--��2) student ���̺���  4�г� '�����' �л��� 2����(deptno2)�� 101��, 
-- weight�� 80���� �����Ͻÿ�.
select * from student
where grade=4 and name='�����';

update student
set deptno2=101, weight=80
where grade=4 and name='�����';

rollback;

--��3) Professor ���̺���  ����ö������ ���ް� ������ ������ ���� ������ 
--�� ���� �޿��� 250������ �� �Ǵ� �������� �޿��� 15% �λ��Ͻÿ�.
select * from professor
where position = (select position from professor where name='����ö')
and pay < 250;

update professor
set pay=pay*1.15
where position = (select position from professor where name='����ö')
and pay < 250;

rollback;

--[2] ���߰��� update - ���������� �̿��� update
/*
    ���������� ����ϸ� �� ���� update������� ���� ���� �÷��� ������ �� �ִ�
    ���� �÷��� ���������� ����� update�ϸ� �ȴ�.
    
    ���߰��� update�� �ϱ� ���ؼ��� �⺻���� update���� ���� ����ϰ�
    subquery�� ������ �����͸� setting�Ϸ��� �÷��� �����Ͱ����� �����
*/
--1) EMP01 ���̺��� �����ȣ�� 7844�� ����� �μ���ȣ�� ����(JOB)�� 
--�����ȣ�� 7782�� ����� ���� ������ ���� �μ��� �����϶�                 

--cf. �����÷� ��������
--�г⺰ �ִ�Ű�� ���� �л��� ���� ��ȸ
select grade, height, studno, name from student
where (grade, height) in (select grade, max(height) from student 
                            group by grade);
                            
--1) 7782���� job, deptno ���ϱ�
select job, deptno from emp
where empno=7782;  --MANAGER, 10

--2) 7844�� ���� update
select * from emp
where empno=7844;

/*
update emp
set job='MANAGER', deptno=10
where empno=7844;
*/

--subquery �̿�
update emp
set (job, deptno) = (select job, deptno from emp
                        where empno=7782)
where empno=7844;

select * from emp
where empno=7844;

rollback;

--[3] exists�� �̿��� ���� ���� update
/*
    - ���������� �÷����� �����ϴ��� ���θ� üũ
    - ���翩�θ� üũ�ϱ� ������ �����ϸ� true, �������� ������ false�� ������
    - true�� ���ϵǸ� set�÷��� update�� �����Ű��
      false�� ���ϵǸ� update�� ������� ����
*/ 
select * from panmae
order by p_code desc;

select * from product;

--������ �ڵ尡 panmae ���̺� �ִٸ� �� �ڵ�� update�ϱ�
select * from panmae a
where exists ( select 1 from product b
                where b.p_code = a.p_code
                and b.del_yn = 'Y');

update panmae a
set p_code=(select p_code_new from product b
            where b.p_code=a.p_code and del_yn='Y')
where exists ( select 1 from product b
                where b.p_code = a.p_code
                and b.del_yn = 'Y');

select * from panmae
order by p_code desc;
 
select * from product;

rollback;
 
--emp���� comm�� ���������� 100�λ��ϰ�,
--sal�� job�� CLERK�̸� 2��, MANAGER�̸� 3��, �������� 4��� �����Ͻÿ�
select * from emp;

update emp
set comm=comm+100, sal=case job when 'CLERK' then sal*2
                                when 'MANAGER' then sal*3
                                else sal*4 
                                end; 

rollback;

--employees���� ������ȣ�� 100�� ������ job_id�� IT_PROG�� ����
select * from employees
where employee_id=100;

update employees
set job_id='IT_PROG'
where employee_id=100;

rollback;

/*
select * from job_history where job_id='IT_PROG';

select * from user_constraints
where constraint_name='JHIST_EMP_ID_ST_DATE_PK';

select * from user_triggers;

desc job_history;
*/

--employees���� ������ȣ�� 100�� ������ job_id�� ������ȣ�� 101��
--job_id�� ����

select job_id from employees
where employee_id=101;  --AD_VP

update employees
set job_id=(select job_id from employees
                where employee_id=101)
where employee_id=100;

rollback;

--3. delete�� - ����
/*
    delete from ���̺�
    where ����
*/

--��1) dept2 ���̺��� �μ���ȣ(dcode)�� 9000������ 9100�� ������ ������� �����Ͻÿ�
select * from dept2
where dcode between 9000 and 9100;

delete from dept2
where dcode between 9000 and 9100;

rollback;
commit;

--delete������ �������� �̿�
--������
--departments���� 10�� �μ��� �μ����� employees���� ����
select * from departments;
select * from employees;

select manager_id from departments
where department_id=10;  --200

select * from employees
where employee_id=(select manager_id from departments
                    where department_id=10);
                    
delete from employees
where employee_id=(select manager_id from departments
                    where department_id=10); --�ڽ� ���ڵ� �߰�-���Ἲ�������� ����

--                                       
create table new_employees
as
select * from employees;

delete from new_employees
where employee_id=(select manager_id from departments
                    where department_id=10); 
                    
select * from new_employees
where employee_id=200;

rollback;

--���� ��
--departments���� location_id�� 1700�� ����� ���� - employees���� ����
select department_id from departments
where location_id=1700;

select * from new_employees
where department_id in (select department_id from departments
                        where location_id=1700);
                        
delete from new_employees
where department_id in (select department_id from departments
                        where location_id=1700);
                        
rollback;

select * from new_employees a
where exists (select 1 from departments b
                        where b.department_id=a.DEPARTMENT_ID 
                         and location_id=1700);

delete from new_employees a
where exists (select 1 from departments b
                        where b.department_id=a.DEPARTMENT_ID 
                         and location_id=1700);
                                                 
--�����÷� ��������
--employees���� ������ �ִ�޿��� �޴� ��� ����
select * from new_employees 
where (job_id,salary) in (select job_id,max(salary) from new_employees
                            group by job_id);
                 
delete from new_employees 
where (job_id,salary) in (select job_id,max(salary) from new_employees
                            group by job_id);

rollback;
                                             
--������� �������� ����
--employees���� �ڽ��� job_id�� ��ձ޿����� ���� �޴� ��� ����
select * from new_employees a
where salary> (select avg(nvl(salary,0)) from new_employees b
                where b.job_id=a.job_id);

delete from new_employees a
where salary> (select avg(nvl(salary,0)) from new_employees b
                where b.job_id=a.job_id);
      
rollback;
                       
/*
dept => dept01 ���̺� �����
emp => emp01 ���̺� �����
--insert
1) dept01, emp01 ���̺� ������ �Է��ϱ�
dept01 ���̺��� ��� Į�� �Է�, emp01 ���̺��� �Ϻ� Į���� �Է�

--update
1) DEPT01 ���̺��� �μ���ȣ�� 30�� �μ��� ��ġ(LOC)�� '�λ�'���� ����
2) DEPT01 ���̺��� ������ ��� '����'�� ����
3) emp01 ���̺��� job�� 'MANAGER' �� ����� �޿�(sal)�� 10% �λ�

--���������� �̿��� update
1) �����ȣ�� 7934�� ����� �޿���, ������ �����ȣ�� 7654�� ����� ������ �޿��� ����(emp01 ���̺� �̿�)

--�ٸ� ���̺��� ������ UPDATE
1) DEPT01 ���̺��� �μ��̸��� SALES�� �����͸� ã�� �� �μ��� �ش�Ǵ� EMP01 ���̺��� �������(JOB)��
 'SALSEMAN'���� ����
2) DEPT01 ���̺��� ��ġ(loc)��  'DALLAS'�� �����͸� ã�� 
�� �μ��� �ش��ϴ� EMP01 ���̺��� ������� ����(JOB)�� 'ANALYST'�� ����
*/
CREATE TABLE DEPT01
AS
SELECT * FROM DEPT;

CREATE TABLE EMP01
AS
SELECT * FROM EMP;

SELECT * FROM EMP01;
SELECT * FROM DEPT01;

insert into dept01
values(50, '������','����');

insert into emp01(empno, ename, job,  sal, deptno)
values(9992, '��浿', 'CLERK', 3500, 10);

desc emp01;


    UPDATE DEPT01
    SET LOC='�λ�' 
    WHERE DEPTNO=30;

    UPDATE DEPT1
    SET LOC = '����';

	UPDATE EMP01
    SET sal = sal*1.1
    WHERE job = 'MANAGER';

	UPDATE EMP01
    SET (JOB, SAL) = (SELECT JOB, SAL FROM EMP01
                       WHERE EMPNO = 7654)
    WHERE EMPNO = 7934;

	UPDATE EMP01
    SET JOB='SALESMAN' 
    WHERE DEPTNO= (SELECT DEPTNO FROM DEPT01  
                   WHERE DNAME='SALES');

	UPDATE EMP01
    SET JOB = 'ANALYST'
    WHERE DEPTNO = (SELECT DEPTNO
                    FROM DEPT01
                    WHERE loc = 'DALLAS');
                    
                    

--insert all�� �̿��� ���� ���̺� ���� �� �Է��ϱ�
--[1] �ٸ� ���̺� �Ѳ����� ������ �Է��ϱ�
select * from p_01;
select * from p_02;

insert all into p_01 values(1,'AA')
           into p_02 values(2, 'BB')
select * from dual;          
    
--[2] �ٸ� ���̺��� �����͸� �����ͼ� �Է��ϱ�
/*
Professor ���̺��� ������ȣ�� 1000������ 1999�������� ������ ��ȣ�� �����̸��� 
p_01 ���̺� �Է��ϰ�, ������ȣ�� 2000������ 2999�������� ������ ��ȣ�� �����̸��� 
p_02 ���̺� �Է��Ͻÿ�.
*/
insert all
    when profno between 1000 and 1999 then
        into p_01 values(profno, name)
    when profno between 2000 and 2999 then
        into p_02 values(profno, name)
select profno, name from professor;

select * from p_01;
select * from p_02;

--[3] �ٸ� ���̺� ���ÿ� ���� ������ �Է��ϱ�
--Professor ���̺��� ������ȣ�� 3000������ 3999�������� �������� ��ȣ�� �����̸��� 
--p_01 ���̺�� p_02 ���̺� ���ÿ� �Է��Ͻÿ�.
                    
insert all into p_01 values(profno, name)
           into p_02 values(profno, name)
select profno, name from professor
where profno between 3000 and 3999;
            
select * from p_01;
select * from p_02;

/*
-- DELETE
1) EMP01���̺��� 7782�� �����ȣ�� ��������� ��� ����
2) EMP01���̺��� ����(JOB)�� 'CLERK'�� ������� ������ ����
3) EMP01���̺��� ��� ������ ���� �� rollback

--���������� �̿��� �������� ����
1) 'ACCOUNTING'�μ��� ���� �μ��ڵ带 DEPT01���̺��� �˻��� �� 
	�ش� �μ��ڵ带 ���� ����� ������ EMP01���̺��� ����
2) DEPT01���̺��� �μ��� ��ġ�� 'NEW YORK'�� �μ��� ã�� 
	EMP01���̺��� �� �μ��� �ش��ϴ� ����� ����
*/

DELETE FROM EMP01
WHERE EMPNO = 7782;

	DELETE FROM EMP01
    WHERE JOB='CLERK';

	DELETE from EMP01;

    SELECT * FROM EMP01; 

    ROLLBACK;

	DELETE EMP01
    WHERE DEPTNO=(SELECT DEPTNO 
                  	    FROM DEPT01
	                      WHERE DNAME='ACCOUNTING');
      
	DELETE EMP01
    WHERE DEPTNO= (SELECT DEPTNO 
                 		FROM DEPT01
                 		WHERE LOC = 'NEW YORK');
                 		                        	