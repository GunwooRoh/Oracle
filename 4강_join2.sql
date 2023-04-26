--4��_join.sql

/*
    ����
    - ������ ���̺� �и��Ǿ� �ִ� ������ �ִ� �����͵��� �����ϰų� �����ϴ� 
      �Ϸ��� �۾���
    - ���� ���̺� ����� �ִ� ���� �߿��� ����ڰ� �ʿ��� ������ �����ͼ�
      ������ ���̺� ����� ���� �������� �˻�
      
    ������ ����
    1) ��������(inner join)
       - ���� ���̺� ��� �����Ͱ� �����ؾ� ����� ����
    2) �ܺ�����(outer join)    
    3) self ����
    4) cross join(ī��� ��)
    
    ����Ŭ�� ����
    ǥ�� ANSI ����
*/
--[1] inner join (���� ����)
--�л� ���̺�(student)�� �а� ���̺�(department)�� ����Ͽ� �л��̸�, 
--1���� �а���ȣ(deptno1), 1���� �а��̸��� ����Ͻÿ�.
select * from student;
select * from department;

--1) ����Ŭ ����
select student
from student, department
where student.deptno1 = deparatement


--2)ANSI  join
select s.STUDNO, s.NAME, s.GRADE, s.DEPTNO1, d.DNAME
from student s inner join department d
on s.DEPTNO1 = d.DEPTNO;


--inner�� ���� ����
select s.STUDNO, s.NAME, s.GRADE, s.DEPTNO1, d.DNAME
from student s join department d
on s.DEPTNO1 = d.DEPTNO;


--4�г� �л����� ������ ��ȸ, �а��� ���
select s.*, d.dname
from student s, department d
where s.deptno1 = d.deptno --��������
and s.grade = 4; --�˻�����(��ȸ����)

--ansi join
select s.*, d.dname
from student s join department d
on s.deptno1 = d.deptno --��������
and s.grade = 4; --�˻�����(��ȸ����)

--�Ǵ�
select s.*, d.dname
from student s join department d
on s.deptno1 = d.deptno --��������
where s.grade = 4; --�˻�����(��ȸ����)

--�л� ���̺�(student)�� ���� ���̺�(professor)�� join�Ͽ� �л��̸�, �������� ��ȣ, 
--�������� �̸��� ����Ͻÿ�
select s.name, s.grade, s.profno, p.name
from student s join professor p
on s.profno = p.profno
order by s.grade
where s.grade = 4;

select * from student;


--ansi join
select s.studno, s.name, s.grade, s.profno, p.name as "����������"
from student s, professor p
where s.profno = p.profno;


--employees, jobs�� �����ؼ� ��������� job_title�� ��ȸ
select * from employees;
select * from jobs;

select e.*, j.job_title
from employees e, jobs j
where e.job_id = j.job_id;

--ansi join
select e.*, j.job_title
from employees e join jobs j
on e.job_id = j.job_id;


--3�� ���̺� ����
--�л� ���̺�(student)�� �а� ���̺�(department), ���� ���̺�(professor)�� join�Ͽ� 
--�л��̸�, �а� �̸�, �������� �̸��� ����Ͻÿ�
select s.*, d.dname, p.name as "������"
from student s, department d, professor p
where s.deptno1 = d.deptno and s.profno = p.profno;

--ansi join
select s.*, d.dname, p.name as "������"
from student s join department d
on s.deptno1 = d.deptno
join professor p
on s.profno = p.profno;

--emp2 ���̺�� �а� p_grade ���̺��� join�Ͽ� ����̸�, ����, ���翬��, 
--�ش� ������ ������ ���� �ݾװ� ���� �ݾ���  ����Ͻÿ�
select * from emp2;
select * from p_grade;

select e.name, e.position, e.pay, p.s_pay, p.e_pay
from emp2 e join p_grade p
on e.position = p.position;

--dept2 ���̺� �̿��ؼ� �μ��� ���
select * from dept2;

select e.name, e.position, e.pay, p.s_pay, p.e_pay, d.dname
from emp2 e, p_grade p, dept2 d
where e.position = p.position
and e.deptno = d.dcode;

--ansi join
select e.name, e.position, e.pay, p.s_pay, p.e_pay, d.dname
from emp2 e join p_grade p
on e.position = p.position
join dept2 d
on e.deptno = d.dcode;


--�������, ����� �μ�����, �μ��� ��������, ������ �������� ��ȸ
 select * from employees;
 select * from departments;
 select * from locations;
 select * from countries;
-- department_id / location_id / country_id
select e.*, d.department_name, l.city, c.country_name
from employees e, departments d, locations l, countries c
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id;


--ansi join 
select e.*, d.department_name, l.city, c.country_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
join countries c
on l.country_id = c.country_id;

--�˻�(��ȸ) ������ �ִ� ���
--1����(depton1)�� 101���� �л����� �л��̸��� �������� �̸��� ����Ͻÿ�.
select s.*, p.name ������
from student s, professor p
where s.profno = p.profno
and deptno1 = 101;

--ansi join
select s.*, p.name ������
from student s join professor p
on s.profno = p.profno
and deptno1 = 101;

--emp2, dept2 ���̺� �̿� - ����̸�, �޿�, ����, �μ��� ��ȸ
select * from emp2;
select * from dept2;

select e.*, d.dname �μ���
from emp2 e, dept2 d
where e.deptno = d.dcode;

--emp2, dept2 ���̺��� �μ��̸��� pay�� ��� ���ϱ�
--1) emp2���� �μ���ȣ�� ��ձ޿�
-- / dcode
select deptno, avg(nvl(pay, 0)) ��ձ޿�
from emp2
group by deptno;

--2) �����̿��ؼ� �μ��̸��� ��ձ޿�
select d.dname, avg(nvl(pay, 0)) ��ձ޿�
from emp2 e join dept2 d
on e.deptno = d.dcode
group by d.dname;

--3) ���� ������� �μ��̸��� �������� �����ϴ� �μ��� ��ո� ��ȸ
select d.dname, avg(nvl(pay, 0)) ��ձ޿�
from emp2 e join dept2 d
on e.deptno = d.dcode
group by d.dname
having d.dname like '����%';

select * from emp;
select * from dept;

--�ǽ�
--emp, dept ���̺��� �μ���ȣ,�����,����,�μ���,���� ��ȸ
--	��, ����(job)�� CLERK�� ��� �����͸� ��ȸ
select e.*, d.*
from emp e join dept d
on e.deptno = d.deptno
where e.job = 'CLERK';

--emp, dept ���̺��� �μ���ȣ,�����,����,�μ���,���� ��ȸ
--	��, ����(job)�� CLERK�� ����̰ų� Manager�� ����� ��ȸ
select e.*, d.*
from emp e join dept d
on e.deptno = d.deptno
where e.job = 'CLERK' or e.job = 'MANAGER';

--emp, dept ���̺��� ����(loc)�� �޿�(sal)�� ��� ��ȸ
--Join, group by ��� �̿�
select d.loc, avg(nvl(e.sal, 0))
from emp e join dept d
on e.deptno = d.deptno
group by d.loc;

--student ���̺�� exam_01 ���̺��� ��ȸ�Ͽ� �л����� �й�, �̸�, ����, ������ ����Ͻÿ�
-- (������ dcode�� case�̿�- 90 �̻��̸�'A', 80�̻��̸� 'B', 70�̻��̸� 'C', 
--60�̻��̸�'D' 60�̸��̸� 'F' )
select s.studno �й�,s.name �̸�, e.total ����,
    case
        when total >= 90 then 'A'
        when total >= 80 and total <= 89 then 'B'
        when total >= 70 and total <= 79 then 'C'
        when total >= 60 and total <= 69 then 'D'
        else 'F'
    end as "����"    
from exam_01 e join student s
on e.studno = s.studno;
 

select * from student;


--[2] outer join (�ܺ� ����)
/*
    inner join���� �ݴ�� ���� ���̺��� �����Ͱ� �ְ�, ���� ���̺� ���� ��쿡
    �����Ͱ� �ִ� �� ���̺��� ������ ���� ����ϰ� �ϴ� ���
*/

--����)student ���̺�� professor ���̺��� �����Ͽ� �л��̸��� �������� �̸��� ����Ͻÿ�.
--��, ���������� �������� ���� �л��� ��ܵ� �Բ� ����Ͻÿ�.
--(�л� �����ʹ� ���� ��µǵ���)

--cf. inner join : ���ʿ� �����Ͱ� �����ϴ� �͸� ��ȸ
select s.*, p.name ������
from student s join professor p
on s.profno = p.profno;


--outer join - �л��� ��� ���
--oracle join
select s.*, p.name ������
from student s, join professor p
where s.profno = p.profno(+);

--ansi join
select s.*, p.name ������
from student s left outer join join professor p
on s.profno = p.profno;


--student ���̺�� professor ���̺��� �����Ͽ� �л��̸��� �������� �̸��� ����Ͻÿ�.
--��, �����л��� �������� ���� ������ ��ܵ� �Բ� ����Ͻÿ�.
--(���� �����ʹ� ���� ��µǵ���)
select * from professor;

select s.*, p.name ������, p.position
from student, join professor p
where s.profno(+) = p.profno
order by p.name;

--ansi join


--student ���̺�� professor ���̺��� �����Ͽ� �л��̸��� �������� �̸��� ����Ͻÿ�.
--��, �����л��� �������� ���� ������ ��ܰ� ���������� ���� �� �� �л� ����� �Ѳ����� ����Ͻÿ�.

--oracle join => union�� �̿��Ͽ� ������ �ܺ����� ����� ��ģ��
select s.*, p.name ������
from student s, join professor p
where s.profno = p.profno(+)
union
select s.*, p.name ������
from student s, join professor p
where s.profno(+) = p.profno;

--ansi join
select s.*, p.NAME ����������, p.POSITION
from student s full outer join professor p
on s.profno = p.profno;


--�л����� ���, �а���, ���������� ���
--�л� �����ʹ� ���� ��µǵ���
select * from department;

select s.*, d.name �а���, p.name ����������
from student s, department d, professor p
where s.deptno = d.deptno(+)
on 

--ansi join
select s.*, d.dname �а���, p.name ����������
from student s left join department d
on s.deptno1 = d.deptno
left join professor p
on s.profno = p.profno;

--student - deptno2 �̿�
select s.*, d.dname �а���, p.name ����������
from student s left join department d
on s.deptno2 = d.deptno
left join professor p
on s.profno = p.profno;

--cf. inner join

--ansi join


--������� ���, �μ�����, �������� �߰�
--�����ü ���(���-�μ���), �μ���ü ���(�μ�-������)
select * from employees;
select * from departments;
select * from locations;

select e.*, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+);

--ansi join
select e.*, d.department_name, l.city
from employees e left join departments d
on e.department_id = d.department_id
left join locations l
on d.location_id = l.location_id;

--���� ������ �߰�
--������ü ������ ���(����-����)
select * from countries;

select e.*, d.department_name, l.city, c.country_name
from employees e, departments d, locations l, countries c
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
and l.country_id = c.country_id(+);

--ansi join
select e.*, d.department_name, l.city, c.country_name
from employees e left join departments d
on e.department_id = d.department_id
left join locations l
on d.location_id = l.location_id
left join countries c
on l.country_id = c.country_id;


--employees, departments, locations ���̺��� city��, department_name��,
--job_id���� �׷�ȭ�Ͽ� city, department_name, job_id, �ο���, salary�հ� ���ϱ�
--outer join �̿�
--�����ü ���(���-�μ���), �μ���ü ���(�μ�-������)
select l.city, d.department_name, e.job_id,  count(*), sum(salary)
from employees e left join departments d
on e.department_id = d.department_id
left join locations l
on d.location_id = l.location_id
group by l.city, d.department_name, e.job_id;



--[3] self join
/*
-���ϴ� �����Ͱ� �ϳ��� ���̺� �� ������� ���
 �ϳ��� ���̺��� �޸𸮻󿡼� ������ �� ���� ����ؼ� �������� 2���� ���̺�� ���� ��
 ���� �۾��� ����
*/
--���� �μ��� ��ȸ�ϱ�
--�μ����̺��� �����μ��ڵ�(pdept)�� �ش��ϴ� �����μ��� ���


--inner join�̿�
select a.DCODE, a.DNAME, a.PDEPT �����μ��ڵ�, b.dname �����μ���
from dept2 a, dept2 b
where a.PDEPT = b.DCODE
order by a.dcode;

--outer join �̿�
select a.DCODE, a.DNAME, a.PDEPT �����μ��ڵ�, b.dname �����μ���
from dept2 a, dept2 b
where a.PDEPT = b.DCODE(+)
order by a.dcode;

--ansi
select a.DCODE, a.DNAME, a.PDEPT �����μ��ڵ�, b.dname �����μ���
from dept2 a left join dept2 b
on a.PDEPT = b.DCODE
order by a.dcode;

--��������� �ش� ����� ���� ����� �̸� ��ȸ
select * from employees;
select a.EMPLOYEE_ID, a.FIRST_NAME, a.hire_date, a.MANAGER_ID ���ӻ�����̵�,
    b.FIRST_NAME ���ӻ���̸�
from employees a, employees b
where a.manager_id = b.employee_id(+)
order by a.EMPLOYEE_ID;


--ansi
select a.EMPLOYEE_ID, a.FIRST_NAME, a.hire_date, a.MANAGER_ID ���ӻ�����̵�,
    b.FIRST_NAME ���ӻ���̸�
from employees a left join employees b
on a.manager_id = b.employee_id
order by a.EMPLOYEE_ID;


--[4] cross join(īƼ�� ��)
/*
���� ������ ���� ���
�� ���̺��� �����͸� ���� ������ŭ�� �����Ͱ� ��µ�
*/
select * from emp; --14��
select * from dept; --4��



--ansi join


--�ǽ�
--1. emp2, p_grade ���̺��� name(����̸�),  position(����), ���ۿ���(s_year), ������(e_year)�� ��ȸ
--��, emp2 ���̺���  �����ʹ� ���� ��µǵ��� �� ��
select a.name �̸�, a.position ����, b.s_year ���ۿ���, b.e_year ������
from emp2 a left join  p_grade b
on a.position = b.position;


select * from emp2;
select * from p_grade;

--2. EMP Table�� �ִ� EMPNO�� MGR�� �̿��Ͽ� ������ ���踦 ������ ���� ����϶�. 
--��FORD�� �Ŵ����� JONES��
select a.empno �����ȣ, a.ename ����̸�, a.job ������, a.mgr �Ŵ��������ȣ, b.ename �Ŵ���
from emp a left join emp b
on a.mgr = b.empno;



