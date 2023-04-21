--1��_select�⺻.sql

--���� �ּ�
/*
���� �� �ּ�
*/

/*
    sqlplus (���� �ۼ� ��) ���� �ش� ������ �����ϴ� ���
    [1] sqlplus ���� ��
    sqlplus ���̵�/��й�ȣ
    ��) sqlplus hr/hr123
        sqlplus sys/123$ as sysdba
        sqlplus / as sysdba
    
    [2] sqlplus �� ��
    conn ���̵�/��й�ȣ
    ��) conn hr/hr123
        conn sys/123$ as sysdba
        conn / as sysdba
        
    �� ����Ŭ ��ġ �� ����� sample ������ ������ lock�� Ǯ�� ����ؾ� ��
    sys�������� ������ ��
    
    - hr ������ lock Ǯ��
    alter user hr account unlock;
    
    - hr ������ ��й�ȣ �����ϱ�
    alter user hr identified by hr123;
    => hr ������ ��й�ȣ�� hr123���� �����Ѵ�
    
    �� sqlplus���� ������ ������ Ȯ���Ϸ���
    show user        
*/
select * from tab; --�ش� ������ ���̺� ��� ��ȸ

desc job_history;



--���̺��� ����
--�θ� ���̺��� �⺻Ű(primary key)�� 
--�ڽ� ���̺��� foreign key(����Ű, �ܷ�Ű)�� ���̵ȴ�.

--�⺻Ű(primary key) - �� ���ڵ带 �����ϰ� ������ �� �ִ� �÷�
--foreign key - �ٸ� ���̺��� ������ �� ����ϴ� �÷�

select * from employees;
select * from jobs;
select * from departments;
select * from locations;
select * from countries;
select * from regions;
select * from job_history
order by employee_id;

--������ ��ȸ�ϱ�
--select �÷���, �÷���, �÷���... from ���̺��;

--1. ��� �÷� ��ȸ�ϱ�
--select * from ���̺��;

--employees ���̺��� ��� �÷� ��ȸ�ϱ�
select * from employees;

SELECT * FROM EMPLOYEES; --��ҹ��� ���� ���� / ��, �����ʹ� ��ҹ��� ������

--2. �Ϻ� �÷��� ��ȸ�ϱ�
--select �÷���1, �÷���2, ...from ���̺��;

--employees ���̺��� ������̵�, �̸�, �Ի���, �޿� ��ȸ�ϱ�
select employee_id, first_name, hire_date, salary from employees;

--3. ǥ������ ����Ͽ� ����ϱ�
select first_name, '�� ȯ���մϴ�' from employees;

/*
ǥ���� (literal���, ����)
- �÷� �̸� �̿ܿ� ����ϱ⸦ ���ϴ� ������ �ǹ�
select ���� �ڿ� '(Ȭ����ǥ)�� ��� ���
*/

--4. �÷� ��Ī ����Ͽ� ����ϱ�
/*
�÷��� �ڿ� as "��Ī" (�����̳� �Ϻ� Ư����ȣ�� ������ �ݵ�� ""�� ������� ��)
�Ǵ� �÷��� �ڿ� "��Ī"
�Ǵ� �÷��� �ڿ� ��Ī

- ���� ���̺��� �÷����� ����� ���� �ƴ϶�
��µ� �� �ӽ÷� �ٲپ �����ִ� �� */
select first_name; '�� ȯ���մϴ�' as "�λ縻"
from employees;

select employee_id as "��� ���̵�", first_name �̸�,
    last_name ��, phone_number "��ȭ��ȣ", salary "�޿�"
from employees;

--5. distinct - �ߺ��� ���� �����ϰ� ����ϱ�
select * from emp;

select deptno from emp;

select distinct deptno from emp; --�ߺ� ������ ���ŵ�

select deptno, job from emp
order by deptno, job;

select distinct deptno, job from emp
order by deptno, job; --distinct Ű����� 1���� �÷����� ��� ��� �÷��� �����

--6. ���� ������ ||
select * from professor;

select name, position from professor;
select name || ' ' || position as "���� �̸�"
from professor;

--7. ��� ������ ����ϱ� +,-,*,/
select ename, sal, comm, sal + 100, sal + comm, sal + 100/2, (sal + 100)/2
from emp;

select first_name, salary, commission_pct,
    salary + salary * commission_pct
    from employees;
    
select 100 * 0.3, 200 - 60, 100 + null, 20 * null from dual;
--����Ŭ�� select ���� from ���� �ʼ��̸� from �� ���� �Ұ�,
--�ڿ� ���� ���̺� dual�� ���ش�


--null : �������� �ʴ´ٴ� ��
--null�� ������ �ϴ��� ����� null

select * from dual;
desc dual;



--�ǽ� - dept2 ���̺��� ����Ͽ� dcode�� �μ�#, dname�� �μ���, area�� ��ġ�� ������ 
--�����Ͽ� ����ϱ�
select * from dept2;
select dcode as "#", dname �μ���, area ��ġ from dept2;


--�ǽ� - student ���̺��� ����Ͽ� ��� �л����� '�������� Ű�� 180 cm, 
--�����Դ� 55kg �Դϴ�' �� ���� �������� ��µǵ��� ���ͷ� ���ڸ� �߰��ϰ�, 
--Į���̸��� "�л��� Ű�� ������"��� �������� ����ϱ�
select * from student;
select name, '�� Ű�� ' || height || 'cm, �����Դ� ' || weight || '�Դϴ�' 
from student;

--8. ���ǿ� �´� ������ ��ȸ�ϱ�
/*
    select �÷��� from ���̺��
    where ����;
*/
--emp ���̺��� 10�� �μ��� �ٹ��ϴ� ����� �̸��� �޿�, �μ���ȣ�� ���
select * from emp;

select ename, sal, deptno
from emp
where deptno = 10;

--emp ���̺��� �޿�(sal)�� 4000���� ū ����� �̸��� �޿��� ���
select ename, empno, sal
from emp
where sal > 4000;

--emp ���̺��� �̸��� scott�� ����� �̸��� �����ȣ, �޿��� ���
select ename, empno, sal
from emp
where ename = 'SCOTT';


--���ڿ��� ��¥�� '(���� ����ǥ)�� �����־�� ��
--professor ���̺��� �Ի����� 1987-01-30 �� ���ڵ� ��ȸ�ϱ�
select * from professor
where hiredate = '1987-01-30';

--�Ǵ�
select * from professor
where hiredate = '1987/01/30';


--9. ���ǿ��� �پ��� ������ �̿�
/*
    �񱳿�����  =,!=, >,<,>=,<=
    ��������  and, or, not
    ����������  between A and B
    ��Ͽ�����   in(A,B,C)
    Ư�����ϰ˻�  like
*/

--�� �����ڸ� ����Ͽ� student ���̺��� Ű(height)�� 180cm ���� ũ�ų� ���� ��� ���
select * from student
where height < 180;

--Ű�� 180���� ���� ��� ��ȸ
select * from student
where not (height >= 180);

--[1]between
--Between �����ڸ� ����Ͽ� student ���̺��� ������(weight)�� 60~80kg �� ����� 
--�̸��� ü�� ���
select name, weight from student
where weight between 60 and 80; -- 60 �̻� 80 ����


--�����԰� 60~80 ���̰� �ƴ� ��� ��ȸ
select name, weight from student
where not weight between 60 and 80;


--����, ��¥�� between�� �̿��� �������� ���� �� �ִ�
--ename�� B~G ������ ��� ��ȸ
select * from emp
where ename >= 'B' and ename <= 'G';

--ename�� B~G ���̰� �ƴ� ��� ��ȸ
select * from emp
where ename<'B' or ename>'G';

select * from emp
where ename not between 'B' and 'G';

select * from emp
where ename not between 'B' and 'G';

select ascii('A'), ascii('a'), chr(65), chr(48)
from dual;


--employees���� �Ի����� 2005~2006�� ������ ��� ��ȸ
select * from employees
where hire_date between '2005/01/01' and '2006/12/31';

select * from employees
where hire_date >= '2005/01/01' and hire_date <= '2006/12/31';


--student���� 4�г��� �ƴ� �л��� ��ȸ�ϱ�
--���� �ʴ�  !=, <>,  ^=
select * from student
where grade != '4';

select * from student
where grade <> '4';

select * from student
where grade ^= '4';


--[2] in
--In �����ڸ� ����Ͽ� student ���̺��� 101�� �а� �л��� 102�� �а� �л����� ��� ���
select * from student
where deptno1 in (101, 102);

--�а��� 101,102�� �ƴ� �л� ��ȸ
select * from student
where deptno1 != 101 and deptno1 != 102;

select * from student
where deptno1 not in (101, 102); 

select * from student
where not (deptno1 in (101, 102));

--Like �����ڸ� ����Ͽ� student ���̺��� ���� "��"���� ����� ��ȸ
select * from student
where name = '��';

select * from student
where name like '��%';

--�̸��� ���� ������ ��� ��ȸ
select * from student
where name like '%��';

--�̸��� �簡 ���ԵǴ� ��� ��ȸ
select * from student
where name like '%��%';


/*
like �� �Բ� ���Ǵ� ��ȣ : %   _
% : ���ڼ� ���� ���� � ���ڰ� �͵� ��
_ : ���ڼ��� �� ���ڸ� �� �� �ְ�, � ���ڰ� �͵� ��
*/

--id�� in�� ���Ե� ��
select * from student
where id like '%in%';

--in�տ� �ѱ��� , in �ڿ� �� ���ڰ� ���� �͸� ��ȸ
select * from student
where id like '_in__';

--employees���� job_id�� AD_PRES �� �� ��ȸ
select * from employees
where job_id like 'AD_PRES';

--employees���� job_id�� PR�� ���Ե� �� ��ȸ
select * from employees
where job_id like '%PR%';

--employees���� job_id�� PR_ �� ���Ե� �� ��ȸ
select * from employees
where job_id like '%PR\_%' escape '\'; 

select * from employees
where job_id like '%PR@_%' escape '@';

select * from employees
where job_id like '%PR*_%' escape '*';


--student���� �̸��� ������� ��� ��ȸ
select * from student
where name like '�����';

--���� �达���� ũ�ų� ���� ��� ��ȸ
select * from student
where name >= '��%';

/*
null :  ����Ŭ�� ������ ���� �� �Ѱ����� � ������ �𸥴ٴ� �ǹ�
        �����Ͱ� ������ �ǹ���, ���� ���ǵ��� ���� ������ ��
- null���� � ������ �����ص� ������� �׻� null�� ����

- null ���� '=' ������ ����� �� ����
=> is null, is not null�� �̿��ؾ� ��        
*/

--professor���� bonus�� null�� ������ ��ȸ
select * from professor
where bonus is null;

--null�� �ƴ� ������ ��ȸ
select * from professor
where bonus not null

--�˻� ������ 2�� �̻��� ���
--�� ������ �켱���� : () > not > and > or

--student ���̺��� ����Ͽ� 4�г� �߿��� Ű�� 170cm �̻��� ����� �̸��� �г�, 
--Ű�� ��ȸ
select name, grade, height from student
where grade = 4 and height >= 170;

--student ���̺��� ����Ͽ� 1�г��̰ų� �Ǵ� �����԰� 80kg �̻��� �л����� �̸��� �г�, 
--Ű, �����Ը� ��ȸ
select name, grade, height, weight from student
where grade = 2 and weight >= 80;

--student ���̺��� ����Ͽ� 2�г� �߿��� Ű�� 180cm ���� ũ�鼭 �����԰� 70kg ���� 
--ū �л����� �̸��� �г�, Ű�� �����Ը� ��ȸ
select name, grade, height, weight from student
where grade = 2 and height > 180 and weight >= 70;

--student ���̺��� ����Ͽ� 2�г� �л� �߿��� Ű�� 180cm ���� ũ�ų� 
--�Ǵ� �����԰� 70kg ���� ū �л����� �̸��� �г�, Ű, �����Ը� ��ȸ
select * from student
where grade = '2' and (height >'180' or weight > '70');


--�ǽ�> professor ���̺��� �������� �̸��� ��ȸ�Ͽ� �� �κп� '��'�� ���Ե� ����� ����� ���


--[10] order by ���� ����Ͽ� ��°�� �����ϱ�
/*
�������� ����(�⺻��) : asc
�������� ���� : desc
sql ������ ���� �������� ����� ��

�������� => order by �÷��� 
�������� => order by �÷��� desc
*/

--student ���̺��� ����Ͽ� 1�г� �л��� �̸���  Ű�� ���. ��, Ű�� ���� ������� ���
select name, height 
from student
where grade = 1
order by height;

--�Ǵ�
select name, height 
from student
where grade = 1
order by height asc;

--Ű�� ū ����
select name, height
from student
where grade = 1
order by height desc;



--student ���̺��� ����Ͽ� 1�г� �л��� �̸���  Ű, �����Ը� ���. 
--��, Ű�� ���� ������� ����ϰ� �����Դ� ���� ������� ���
select name, height, weight from student
--where grade = 1
order by height, weight desc;

--student ���̺��� ����Ͽ� 1�г� �л��� �̸���  ����, Ű, �����Ը� ���. 
--��, ������ ���� ��� ������� ����
select name, birthday, height, weight from student
where grade = 1
order by birthday;

--student ���̺��� ����Ͽ� 1�г� �л��� �̸���  Ű�� ���. 
--��, �̸��� ������������ ����
--�̸�, Ű ��Ī �����ϱ�
select name as "�̸�", height Ű from student
where grade = 1
order by "�̸�"; --��Ī�� ����ؼ� ���� ����

--�ǽ�]employees ���̺��� ������̵�, �̸� - ��(�� : Steven-King), �Ի���, �⺻��(salary), 
--����(salary*commission_pct), �޿�(salary+����) ��ȸ�ϱ�
--��� �÷��� ��Ī�� ����Ѵ�
--�Ի����� 2005�� ������ ����� ��ȸ
--�⺻���� ���� ��� ������ ����
select * from employees;
select employee_id as "������̵�", last_name ��, hire_date �Ի���, salary �⺻��,
salary*commission_pct ����, salary+commission_pct �޿� from employees
where "�Ի���" = '2005/01/01'
order by "�⺻��";




/*
�� ���� ������

union - �� ������ ���ؼ� ����� ���, �ߺ�����, �������� (������)
union all - �� ������ ���ؼ� ����� ���, �ߺ��������� �ʰ�, ���������� ����
intersect - �� ������ ������ ����� ���, ��������
minus - �� ������ ������ ����� ���, ��������

=> ���� ������ ���� ���ǻ���
1) �÷��� ������ ��ġ�ؾ� ��
2) �÷��� �ڷ����� ��ġ�ؾ� ��
(�÷����� �޶� ��� ����)
*/
--set1 ���̺�� set2 ���̺� union


--union all



--�а��� 101�� ������ �л� ��� ��ȸ�ϱ�


--set1, set2 intersect


/*
set1 => AAA,AAA,BBB
set2 => BBB,CCC,CCC
*/



/*
product ���̺��� ��� �÷� ��������
dept  ���̺��� ��� �÷� ��������
student ���̺��� �Ϻ� �÷��� ��������
  -ID,NAME, BIRTHDAY 
  -name �� ���л� �̸������� �÷� ���� �ٲٱ�

1. professor ���̺��� ��� �÷��� ��ȸ�ϴµ�, name ������������ ��ȸ�ϱ�
���� : position �� ���������� �� �͸� ��ȸ
2. department ���̺��� deptno, dname, build �÷��� ��ȸ
���� : �а�(dname)�� �����С��̶�� �ܾ �� �а����� ��ȸ�ϱ�
���� : dname ������ ������������ ����
3. emp2 ���̺��� name, emp_type, tel, pay, position �÷��� ��ȸ�ϵ�, position �÷��� �÷������� ���������� ��Ÿ����
���� : pay�� 3000�������� 5000������ �͵鸸 ��ȸ�ϱ�

4. emp2 ���̺��� name, emp_type, tel, birthday �÷��� ��ȸ�ϵ�, ���� ���ǿ� �´� �����͸� ��ȸ
���� : ����(birthday)�� 1980�⵵ �� �͵鸸 ��ȸ�ϱ�(between �̿�)

5. gift ���̺��� ��� �÷��� ��ȸ�ϵ�
���� : gname�� ����Ʈ����� �ܾ �� ���ڵ常 ��ȸ�ϱ�

6. emp2 ���̺��� name, position, hobby, birthday �÷��� ��ȸ�ϵ�
���� : position �� null �� �ƴ� �͸� ��ȸ
����(birthday) ������ ������������ ����

7. emp2 ���̺��� ��� �÷��� ��ȸ�ϵ�
���� : emp_type�� �����������̰ų� ����������� �͸� ��ȸ(in �̿�)

8. emp2 ���̺��� emp_type, position �÷��� ��ȸ�ϵ�
�ߺ��� ��(���ڵ�)�� ����
*/

