--[3��_�׷��Լ�.sql]

--������ �Լ�
select birthday, to_char(birthday, 'd'), name, length(name)
from student;

--������ �Լ�(�׷��Լ�)
select sum(pay) from professor;
select * from professor;


--count() - �ԷµǴ� �������� �Ǽ��� �����ϴ� �Լ�
--��κ��� �׷��Լ��� null�� �����ϰ� �����
--count(*)�� null ����


 
--sum() - �հ� ���ϴ� �Լ�
/*
    ����, ��¥�� sum(), avg() �Լ��� ����� �� ����(���� �Ұ�)
    count() �Լ��� ����, ��¥������ ��� ����
*/
select sum(pay), sum(bonus), count(pay), count(bonus), count(*)
from professor;

select sum(name) from professor; --error
select sum(hiredate) from professor; --error

select count(name), count(hiredate) from professor; --��밡��


--avg() - ����� ���ϴ� �Լ�
select avg(pay), sum(pay), count(pay), count(*),
    avg(bonus), sum(bonus), count(bonus),
    sum(bonus)/count(bonus), sum(bonus)/count(*),
    avg(nvl(bonus, 0))
from professor;


/*
    �׷��Լ��� null�� �����ϰ� �����ϹǷ� avg()�� �������� ������� ������ ����
    => nvl() �Լ��� �̿��Ͽ� ó���ؾ� ��
    => avg(nvl(�÷�, 0))
*/

--max() - �ִ밪�� ���ϴ� �Լ�
--min() - �ּҰ��� ���ϴ� �Լ�
select may(pay), min(pay), max(bonus), min(bonus)
from professor;


--����, ��¥�� �ִ밪, �ּҰ��� ���� �� �ִ�.(��� �񱳰� �����ϹǷ�)
select max(name), min(name), max(hiredate), min(hiredate)
from professor;


--�ߺ����� ������ �Ǽ� : count(distinct �÷���)
select count(grade), count(*), count(distinct grade)
from student;

select grade from student;
select distinct grade from student;

/*
sum(distinct �÷���) - �ߺ����� ������ �հ�
avg(distinct �÷���) - �ߺ����� ������ ���
min(distinct �÷���) - �ߺ����� ������ �ּҰ�
max(distinct �÷���) - �ߺ����� ������ �ִ밪
*/

--�׷캰 ����
--Professor ���̺��� �а����� �������� ��� �޿��� ����Ͻÿ�.
avg (distinct pay)

--group by���� �ִ� �÷��� �׷��Լ��� select���� �� �� �ִ�.


--group by
/*
   - ���̺� ��ü�� ���� ���踦 ���ϴ� ���� �ƴ϶�, Ư�� ���������� ���� �����͸� ����     
*/
--�а���, ���޺� �޿��� ��� ���ϱ�
select deptno, position, pay
from professor
order by deptno, position;

select deptno, position, avg(nvl(pay, 0))
from professor
group by deptno, position;

select deptno as dno, position, avg(nvl(pay,0))
from professor
group by dno, position --error
order by dno, position; --order by ������ ��Ī ��� ����

--�μ��� ��ձ޿��� ���� ��, ��� �޿��� 450 �ʰ��� �μ��� �μ���ȣ�� ��� �޿��� ���Ͻÿ�.
select deptno, position, avg(nvl(pay, 0))
from professor
group by deptno, position
having avg(nvl(pay, 0)) > 450;


/*
    having
    - group by�� ��������� Ư�� ������ �����ϴ� ���� ���Ϸ��� having�� �̿��Ѵ�
    - group by���� ���� ��µ� ����� ���� ������ �����Ѵ�.
    - group by�� ����� �����ϰ����� �� ���
    
    group by �÷�
    having ����
*/

--Student ���̺��� grade���� weight, height�� ���, �ִ밪 ���ϱ�
--���� ������� Ű�� ����� 170 ������ ��� ���ϱ�
select grade, avg(nvl(weight,0)), avg(nvl(height, 0)), max(weight), max(height)
from student
group by grade
having avg(nvl(height, 0)) <= 170;


--deptno1�� 100������ �а� �л��鿡 ���ؼ� �г⺰ Ű�� ��� ���ϰ�
--�� ������� Ű�� ����� 172 �̻��� ��� ���ϱ� 
select grade as "�г�", avg(nvl(height, 0)) "�г� �� Ű�� ���"
from student
where deptno1 < 200
group by grade
having avg(nvl(height, 0)) >= 172;

--�ǽ�
--1.  emp���̺��� �μ��� �޿��� ���� ���ϱ�.
select deptno as "�μ�", avg(nvl(sal, 0)) "�޿� ���", sum(nvl(sal, 0))
from emp
group by deptno;

select * from emp;
       
--2. emp ���̺��� job���� �޿��� �հ� ���ϱ�.
select job, sum(sal)
from emp
group by job;

--3. emp ���̺��� job���� �ְ� �޿� ���ϱ�
select job, max(sal)
from emp group by job;

--4. emp ���̺��� job���� ���� �޿� ���ϱ�
select job, min(sal)
from emp group by job;


--1. emp ���̺��� job���� �޿��� ��� ���ϱ� - �Ҽ����� 2�ڸ��� ǥ��



--4.  emp2 ���̺��� emp_type���� pay�� ����� ���� ���¿��� 
--��� ������ 3õ���� �̻��� ����� emp_type �� ��� ������ �о����


--5. emp2�� �ڷḦ �̿��ؼ� ����(position)���� ���(empno)�� ���� ���� 
--����� ���ϰ� �� ��� ������ ����� 1997�� �����ϴ� ��� ���ϱ�
--	(����� �ִ밪), like �̿�
select position, max(empno)
from emp2
group by position
having max(empno) like '1997%';


--6. emp ���̺��� hiredate�� 1982�� ������ ����� �߿��� deptno��, job�� 
--sal�� �հ踦 ���ϵ�
--	�� ��� ������ �հ谡 2000 �̻��� ����� ��ȸ



/*
�� select sql�� �������
5. select �÷�
1. from ���̺�
2. where ����
3. group by �׷����� �÷�
4. having ����
6. order by �÷�
*/

--rollup, cube : group by�� �Բ� ���
--[1] rollup() - �־��� �����͵��� �Ұ踦 ������
--group by���� �־��� �������� �Ұ谪�� ������

--�а��� ��ձ޿�
select deptno, round(avg(nvl(pay,0)), 1) ��ձ޿�
from professor
group by deptno
order by deptno;


--rollup
select deptno, round(avg(nvl(pay,0)), 1) ��ձ޿�
from professor
group by rollup(deptno)
order by deptno;

select deptno, position, avg(nvl(pay,0)) ��ձ޿�
from professor
group by rollup(deptno, position)
order by deptno, position;


--cube
select deptno, position, avg(nvl(pay,0)) ��ձ޿�
from professor
group by cube(deptno, position)
order by deptno, position;


--group by�� �÷��� 2���� ���
--�а���, ���޺� ��ձ޿�
--rollup




--group by�� �÷��� 3���� ���
--emp_details_view���� ������, �μ���, ������ ��ձ޿�



--rollup
select city, department_name, job_id, round(avg(nvl(salary, 0)), 1) ��ձ޿�
from emp_details_view
group by rollup (city, department_name, job_id)
order by city, department_name, job_id;

--rollup(�÷�) => �÷��� ����+1 ���� �Ұ谡 �������
--��) rollup(a,b,c) => (a,b,c), (a,b), (a), () => 3+1 => 4���� �Ұ谡 �������

--cube 
select city, department_name, job_id, round(avg(nvl(salary, 0)), 1) ��ձ޿�
from emp_details_view
group by cube (city, department_name, job_id)
order by city, department_name, job_id;

--cube(�÷�) => 2�� �÷��� ���� �Ұ谡 ������� (��� ����� ��)
--��) cube(a,b,c) => ��� ����� ����ŭ�� �Ұ谡 �������, 2�� 3�� ��=>8��
--(a,b,c), (a,b),(a,c),(b,c),(a),(b),(c),()



--grouping() - rollup, cube �Լ��� ���� ����
--�Ұ迡 ���� ��� ������ �� �� ���
--�׷��� �۾��� ���Ǿ����� 0, ������ �ʾ����� 1�� ������

--group by�� �÷��� 1���� ���, rollup
select deptno �а�, avg(nvl(pay, 0)) ��ձ޿�, grouping(deptno)
from professor
group by rollup(deptno)
order by deptno;

select decode(grouping(deptno), 0, to_char(deptno), '[�հ�]') �а�,
    avg(nvl(pay, 0)) ��ձ޿�, grouping(deptno)
from professor
group by rollup(deptno)
order by deptno;

--cube
select decode(grouping(deptno), 0, to_char(deptno), '[�հ�]') �а�,
    avg(nvl(pay, 0)) ��ձ޿�, grouping(deptno)
from professor
group by cube(deptno)
order by deptno;


--group by�� �÷��� 2���� ���
--rollup
select deptno, position, avg(nvl(pay, 0)), grouping(deptno), grouping(position)
from professor
group by rollup(deptno, position)
order by deptno, position;

select decode(grouping(deptno), 1, '[��ü]', deptno) �а�,
       decode(grouping(position), 1, 
       decode(grouping(deptno), 1,'[�Ұ�]', '[�а����Ұ�]') , position) ����,
avg(nvl(pay, 0)), grouping(deptno), grouping(position)
from professor
group by rollup(deptno, position)
order by deptno, position;

--cube
select deptno, position, avg(nvl(pay, 0)), grouping(deptno), grouping(position)
from professor
group by cube(deptno, position)
order by deptno, position;

select decode(grouping(deptno), 1, '[��ü]', deptno) �а�,
       decode(grouping(position), 1, 
       decode(grouping(deptno), 1,'[�Ұ�]', '[�а����Ұ�]') , position) ����,
avg(nvl(pay, 0)), grouping(deptno), grouping(position)
from professor
group by cube(deptno, position)
order by deptno, position;

select decode(grouping(deptno),1,decode(grouping(position),1,'[��ü]','[���޺��Ұ�]'), deptno) �а�,
       decode(grouping(position),1,decode(grouping(deptno),1,'[�Ұ�]','[�а����Ұ�]'),position) ����,
avg(nvl(pay,0)), grouping(deptno), grouping(position)
from professor
group by cube(deptno, position)
order by deptno, position;

--grouping sets - ���ϴ� ���踸 ������ �� �ִ�
--�׷��� ������ ���� ���� ��� �����ϰ� ���

--��) STUDENT ���̺��� �г⺰�� �л����� �ο��� �հ�� �а����� �ο����� �հ踦 
--���ؾ� �ϴ� ��쿡 �������� �г⺰�� �ο��� �հ踦 ���ϰ� ������ �а����� �ο��� 
--�հ踦 ���� �� UNION ������ ����

--�г⺰ �ο��� union �а��� �ο���
select grade, deptno1, count(*) as "�г⺰ �ο� ��"
from student
group by grade, deptno1;

select * from student;
--cf. �г⺰, �а��� �ο���


--grouping sets �̿�



--rollup
select deptno, position, avg(nvl(pay, 0)) ��ձ޿�
from professor
group by rollup(deptno, position);


--grouping sets�� �̿��� rollup�� ������ ��Ȳ
select deptno, position, avg(nvl(pay, 0)) ��ձ޿�
from professor
group by grouping sets((deptno, position), (deptno), ());


--cube
select deptno, position, avg(nvl(pay, 0)) ��ձ޿�
from professor
group by cube(deptno, position);


--grouping sets�� �̿��� cube�� ������ ��Ȳ
select deptno, position, avg(nvl(pay, 0)) ��ձ޿�
from professor
group by grouping sets((deptno, position), (deptno), (position), ())
order by deptno, position;

--���ϴ� ���踸
select deptno, position, avg(nvl(pay, 0)) ��ձ޿�
from professor
group by grouping sets((deptno, position), (deptno), (position), ())
order by deptno, position;


--panmae ���̺��� ����(p_qty)�� 3�� �̻��� �����Ϳ� ���� �Ǹ���(p_date)��, 
--�Ǹ���(p_store)���� �Ǹűݾ�(p_total)�� �հ� ���ϱ�
--rollup, cube�̿��Ͽ� �Ұ� ���
--������ ��� grouping�Լ��� �̿��ؼ� ������� ����ϱ�(decode()�� �̿�)
select p_date, p_store, sum(nvl(p_total, 0)) as "�հ�"
from panmae
group by rollup (p_date, p_store);

select p_date, p_store, sum(nvl(p_total, 0)) as "�հ�"
from panmae
group by cube (p_date, p_store);

select p_date, p_store, decode(p_qty >= 3, sum(nvl(p_total, 0))) as "�հ�"
from panmae
group by grouping sets (p_date, p_store);

select decode(grouping(p_date), 1, '��', p_date) as "�Ǹ���",
    decode(grouping(p_store), 1, decode(grouping(p_date), 1, '[�ջ�]','[�����ջ�]'),p_store) "�Ǹ�����", sum(p_total) "�����"
from panmae
where p_qty >= 3
group by rollup(p_date, p_store)
order by p_date, p_store;

select decode(grouping(p_date), 1, decode(grouping(p_store), 1, '[��]','[�Ǹ��� �Ұ�]'), p_date) as "�Ǹ���",
    decode(grouping(p_store), 1, decode(grouping(p_date), 1, '[�ջ�]','[�����ջ�]'),p_store) "�Ǹ�����", sum(p_total) "�����"
from panmae
where p_qty >= 3
group by cube(p_date, p_store)
order by p_date, p_store;


select decode(grouping(p_date),1,'[��]',p_date) �Ǹ���,
    decode(grouping(p_store),1,decode(grouping(p_date),1,'[�ջ�]','[�����ջ�]'),p_store) �Ǹ�����, sum(p_total) �����
from panmae
where p_qty>=3
group by rollup(p_date,p_store);

select * from panmae;



--emp ���̺��� �μ����� �� ���޺� sal�� �հ谡 ������ ����ؼ� ���
select deptno, job, sum(sal)
from emp
group by deptno, job
order by deptno, job;



--���� ����(������ price�� �հ� ���ϱ�)
--[1] group by �̿�
select sum(price) as "���� �հ�", extract(month from regdate)as "��"
from pd
group by extract(month from regdate)
order by extract(month from regdate);

select * from pd;



--student���� deptno1(�а�)��, �г⺰ Ű�� ��� ���ϱ�
--[1] group by �̿�
select deptno1, grade, avg(nvl(height, 0)) as "��� Ű"
from student
group by deptno1, grade
order by deptno1, grade;

