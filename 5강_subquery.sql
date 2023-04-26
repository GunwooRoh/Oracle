--5��_subquery.sql

/*
�������� - �����ȿ� �� �ٸ� ������ ��� �ִ� ��

select * from ���̺�  --main query
where ���� ������ ( select �÷� from ���̺� where ����)  --subquery

()�ȿ� ���������� �ִ´�
*/

--Emp ���̺��� ��SCOTT�� ���� �޿��� ���� �޴� ����� �̸��� �޿��� ����Ͻÿ�
--���������� �̿����� �ʰ� ��ȸ
--1) ���� scott�� �޿��� ���Ѵ�
select * from emp;

select sal from emp
where ename = 'SCOTT'; --3000


--2) 3000���� ���� �޴� ���� ��ȸ
select * from emp
where sal > 3000;


--�������� �̿�
select * from emp
where sal > (select sal from emp
                where ename = 'SCOTT');

/*
  => ���������� ������ ����� 1�Ǹ� ������, �� ����� main query�� �����ؼ�
  main query�� �����ϰ� ��
  
  ������ ���������� ��� where ������ ���Ǵ� ������
  =, !=, >, <, >=, <=
  
  �� ���������� ����
  1) ������ �������� - ���������� ����� 1���� ���� ���
  2) ������ �������� - ���������� ����� 2���� �̻��� ���
  3) �����÷� �������� - ���������� ����� ���� �÷��� ���
  4) ������ �ִ� ��������(������� ��������) - ���������� ���������� ���� �����Ǿ� 
        �ִ� ���
*/

--student ���̺�� department ���̺��� ����Ͽ� ������ �л��� 1����(deptno1)�� 
--������ �л����� �̸��� 1���� �̸��� ����Ͻÿ�
--1) �������� 1���� ��ȸ
select * from student;
select * from department;

select s.name, d.dname
from student s join department d
on s.deptno1 = d.deptno
where name = '������';

select name, deptno1 from student
where name = '������';

--2) ��ȸ�� ������ ���� ������ �л��� ��ȸ
select s.name, d.dname
from student s join department d
on s.deptno1 = d.deptno
where deptno1 = 101;

--�������� �̿�
select s.name, d.dname
from student s join department d
on s.deptno1 = d.deptno
where s.deptno1 = (select deptno1 from student
                    where name = '������');

--join


--�ǽ�) Professor ���̺��� �Ի����� �۵��� �������� ���߿� �Ի��� ����� �̸��� �Ի���, �а����� ����Ͻÿ�.
--professor, department���̺� �̿�
select * from professor;
select * from department;

select p.name, p.hiredate, d.dname
from professor p join department d
on p.deptno = d.deptno
where p.hiredate > (select hiredate from professor
                        where name = '�۵���');

--�ǽ�) student ���̺��� 1����(deptno1)�� 101���� �а��� ��� �����Ժ��� �����԰� ����
-- �л����� �̸��� �����Ը� ����Ͻÿ�
select * from student;
select name, weight
from student
where weight > (select avg(nvl(weight, 0)) from student
                    where deptno1 = 101)
order by weight;

--Professor ���̺��� �ɽ� ������ ���� �Ի��Ͽ� �Ի��� ���� �߿��� ������ �������� 
--������ ���� �޴� ������ �̸��� �޿�, �Ի����� ����Ͻÿ�.
select name, pay, hiredate
from professor
where pay < (select pay from professor
                where name = '������')
and hiredate = (select hiredate from professor
                where name = '�ɽ�');

select * from professor
where hiredate = '1981-10-23'
and pay < 550;

--emp2 ���̺��� ������ ���� ���� ��� ���� ��ȸ
--Dept2 ���̺�� �����ؼ� �μ��� ��ȸ�� ��
select * from emp2;
select * from dept2;

select e.*, d.dname
from emp2 e join dept2 d
on e.deptno = d.dcode
and pay = (select min(pay) from emp2);





--������ ��������
/*
    - ���������� ����� 2�� �̻� ��µǴ� ���
    - ���������� ����� ���� �� ��µǱ� ������ ������ �����ڸ� ����� �� ����
    
    �� ���� �� �������� ������
    in - ���� ���� ã�´� (���Ե� ��)
    <any - �ִ밪�� ��ȯ�� ��) sal < any(100,200,300) => 300
    >any - �ּҰ��� ��ȯ�� ��) sal > any(100,200,300) => 100
    <all - �ּҰ��� ��ȯ�� ��) sal < all(100,200,300) => 100
    >all - �ִ밪�� ��ȯ�� ��) sal > all(100,200,300) => 300
    
    any - ���� �� �� �ƹ��ų� �ϳ��� ������ �����ص� �ȴٴ� �ǹ�
    all - ������������ ��ȯ�Ǵ� ��� row ���� �����ؾ� ���� �ǹ�
*/

--����) emp2 ���̺�� dept2 ���̺��� �����Ͽ� �ٹ����� (dept2 ���̺��� area Į��)�� 
--���� ������ ��� ������� ����� �̸�, �μ���ȣ�� ����Ͻÿ�
--1) �ٹ������� ���������� �μ�
select * from dept2;
select * from emp2;

select dcode from dept2
where area = '��������';

--2) ��ȸ�� ���������� �μ��� ���� ����� ��ȸ
select * from emp2
where deptno in (1000, 1001, 1002, 1010);

--subquery �̿�
select * from emp2
where deptno in (select dcode from dept2
                    where area = '��������');

--����) emp2 ���̺��� ����Ͽ� ��ü ���� �� ���� ������ �ּ� �����ں��� ������ 
--���� ����� �̸��� ����, ������ ����Ͻÿ�.
--��, ���� ��������� õ ���� ���б�ȣ�� �� ǥ�ø� �Ͻÿ�.
--1) ���� ������ ���� ��ȸ
select * from emp2
where position = '����';

--2) ��ȸ�� ������ �ּҰ����� ���� �޴� ��� ��ȸ
select * from emp2
where pay > any(50000000, 56000000, 51000000, 49000000);

--������ �������� �̿�
select * from emp2
where pay > any (select min(pay) from emp2
                where position = '����');

--������ �������� �̿�
select * from emp2
where pay > (select min(pay) from emp2
                where position = '����');
                
--emp2 ���̺��� ����Ͽ� ��ü ���� �� ���� ������ �ִ� �����ں��� ������ ���� ����� 
--�̸��� ����, ������ ����Ͻÿ�.
--������
select * from emp2
where pay > (select max(pay) from emp2
                where position = '����');
--������                
select * from emp2
where pay > all (select max(pay) from emp2
                where position = '����');                

--�ǽ�)student ���̺��� ��ȸ�Ͽ� ��ü �л� �߿��� ü���� 4�г� �л����� ü�߿��� 
--���� ���� ������ �л����� �����԰� ���� �л��� �̸��� �����Ը� ����Ͻÿ�.
--������
select name, weight from student
where weight < (select min(weight) from student
                    where grade = 4);

--������                    
select name, weight from student
where weight < all (select min(weight) from student
                    where grade = 4);    
               
--emp2 ���̺��� ��ȸ�Ͽ� �� �μ��� ��� ������ ���ϰ� �� �߿��� ��� ������ ���� 
--���� �μ��� ��� �������� ���� �޴� �������� �μ���,������, ������ ����Ͻÿ�.
select * from emp2;

select deptno, avg(nvl(pay, 0)) ��տ���
from emp2
group by deptno;

select * from emp2
where pay < (select min(avg(nvl(pay, 0)))
                from emp2
                group by deptno);
                
--join
select e.*, d.dname �μ���
from emp2 e join dept2 d
on e.deptno = d.dcode
where pay < (select min(avg(nvl(pay, 0)))
                from emp2
                group by deptno);
                

		
--������ �������������� != ������ �̿�
--������ �������������� not in������ �̿�
/*
    ������ ���������� ������       ������ ���������� ������
    =                               in
    !=                              not in
    >,<                             >any, <any, >all, <all
*/
--�ٹ������� ������簡 �ƴ� ��� ����� ��ȸ(emp2, dept2)
select * from emp2;
select * from dept2;

select dcode from dept2
where area = '�������'; --1005, 1009

select * from emp2
where deptno not in (1005, 1009);

--subquery�̿�
select * from emp2
where deptno not in (select dcode from dept2
                        where area = '�������');


--loc�� DALLAS�� �ƴ� ��� ��� ��ȸ(EMP, DEPT)
select * from emp;
select * from dept;

select *
from emp
where deptno not in (select deptno from dept
                    where loc = 'DALLAS');


--employees���� job_id�� salary�հ谡 30000�̻��� job_id�� ���ϴ� ��� ���ϱ�
select * from employees
where job_id in (select job_id from employees
                    group by job_id
                    having sum(salary) >= 30000);


--���� �÷� ��������(pairwise subquery)
--���������� ����� ���� �÷��� ���

--student ���̺��� ��ȸ�Ͽ� �� �г⺰�� �ִ� Ű�� ���� �л����� �г�� �̸��� Ű�� ����Ͻÿ�.
--�г⺰ �ִ�Ű ���ϱ�
select * from student

select grade, max(height)
from student
group by grade
order by grade;

/*
1�г� - 179
2�г� - 184
3�г� - 177
4�г� - 182
*/         

--1�г� �ִ�Ű�� ���� �л� ����
select * from student
where grade = 1 and height = 179;

--���� �÷� ��������
select grade, height, studno, name from student
where (grade, height) in (select grade, max(height)
                            from student
                            group by grade);


--professor ���̺��� ��ȸ�Ͽ� �� �а����� �Ի����� ���� ������ ������ ������ȣ�� �̸�, 
--�Ի���, �а����� ����Ͻÿ�. �� �а��̸������� �������� �����Ͻÿ�.
select * from professor;

select deptno, min(hiredate)
from professor
group by deptno
order by deptno;

select * from professor
where dpetno = 101 and hiredate = '1980/06/23';

--subquerry
select * from professor
where (deptno, hiredate) in (select deptno, min(hiredate)
                                from professor
                                group by deptno)
order by deptno;

--join
select p.*, d.dname
from professor p join department d
on p.deptno = d.deptno
where (p.deptno, p.hiredate) in (select deptno, min(hiredate)
                                from professor
                                group by deptno)
order by d.dname;

--emp2 ���̺��� ��ȸ�Ͽ� ���޺��� �ش� ���޿��� �ִ� ������ �޴� ������ �̸��� 
--����, ������ ����Ͻÿ�. ��, ���������� �������� �����Ͻÿ�
select * from emp2;

select name, position, pay from emp2
where (position, pay) in (select position, max(pay)
                                from emp2
                                group by position)
order by pay;                                

--������ ���� ������ ��ȸ�ǵ���
select name "�����", nvl(position, '����') "����", pay "����" from emp2
where (nvl(position, '����'), pay) in (select nvl(position, '����'), max(pay)
                                from emp2
                                group by position)
order by 2;  

--�μ���ȣ���� �⺻���� �ִ��� ����� �⺻���� �ּ��� ��� ��ȸ - employees
select * from employees;

select department_id, max(salary)
from employees
group by department_id;

select department_id, min(salary)
from employees
group by department_id;

select department_id, salary, employee_id, first_name
from employees
where (department_id, salary) in (select department_id, max(salary)
                                    from employees
                                    group by department_id)
or (department_id, salary) in (select department_id, min(salary)
                                    from employees
                                    group by department_id)
order by department_id;

-- null�� ǥ��
select nvl(department_id, 0), salary, employee_id, first_name
from employees
where (nvl(department_id, 0),salary) in (select nvl(department_id, 0), max(salary)
                                    from employees
                                    group by department_id)
or (nvl(department_id, 0),salary) in (select nvl(department_id, 0), min(salary)
                                    from employees
                                    group by department_id)
order by department_id;
--��ȣ ���� sub query(������ �ִ� ��������, ������� ��������)
/*
- ���������� ���������� ���������� �ʰ�, �������� �� ������ ���� ����Ǿ� �ִ� ������ ����
- ���������� �������� ���̿��� ������ ����
- ���� ������ �÷��� ���������� where�������� ����

- Main query ���� sub query�� �ְ� sub query�� ������ ��,
 �� ����� �ٽ� main query�� ��ȯ�ؼ� �����ϴ� sub query
*/

--����) emp2 ���̺��� ��ȸ�Ͽ� ������ �߿��� �ڽ��� ������ ��� ������ ���ų� ���� 
--�޴� ������� �̸�, ����, ���翬���� ����Ͻÿ�.
select * from emp2;

select name, position, pay
from emp2
where (position, pay) in (select position, avg(nvl(pay, 0))
                                from emp2);



--subquery �̿�
select position, pay, empno, name from emp2 a
where pay >= (select avg(nvl(pay, 0)) from emp2 b
                    where b.position = a.position)
order by position;                    

--professor ���̺��� ��ȸ�Ͽ� ������ �߿��� �ڽ��� �а��� ��� �޿����� ���� �޴� 
--�������� �̸�, �а�, ����޿��� ����Ͻÿ�
select * from professor;

select avg(nvl(pay, 0))
from professor
where deptno = 101;

select * from professor
where deptno = 101 and pay < 400;


--subquery�̿�
select name, deptno, pay, profno, position
from professor a
where  pay < (select avg(nvl(pay, 0))
                from professor b
                where b.deptno = a.deptno);


--emp ���̺��� ��ȸ�Ͽ� ������ �߿��� �ڽ��� job�� ��� ����(sal)���� ���ų� ���� 
--�޴� ������� ��ȸ�Ͻÿ�.
select * from emp;
select avg(nvl(sal, 0))
from emp
where job = 'CLERK';

select * from emp
where job = 'CLERK' and sal <= 1037.5;

--subquery
select * from emp a
where sal < (select avg(nvl(sal, 0))
                from emp b
                where a.job = b.job);
	    
--exists������
/*
    - Ư�� �÷����� �����ϴ��� ���θ� üũ
    - ���������� ��ȯ�ϴ� ����� ������������ ����� �����͵��� �����ϱ⸸ �ϸ�
      ������ �����ϰ� ��
    - ���ɸ鿡���� in���� exists�� ������ �����
    
    ��in, exists ��
    1)in - � ���� ���ԵǴ��� ���θ� üũ
           in�� ()�ȿ� ���� ���� �� ���� �ְ�, ���������� �� ���� �ִ�.
    2)exists - Ư�� �÷����� �����ϴ��� ���θ� üũ
           exists�� ���� ���������� �� �� �ִ�. 
*/                      
--�μ����̺��� pdept���� null�� �ƴ� �μ��� ���ϴ� ��� ����
select * from dept2;
select * from emp2;


--in �̿�
select decode from dept2;
where pdept is not null;

select * from emp2
where deptno in (select dcode from dept2
                    where pdept is not null);


--exists�̿�
select * from emp2 e
where exists (select dcode from dept2 d
                    where d.DCODE = e.DEPTNO
                    and pdept is not null);


--join�̿�
select e.*
from emp2 e join dept2 d
on d.DCODE = e.DEPTNO
and pdept is not null;

	 
--������翡 ���ϴ� ������� ���� ��ȸ
--in
select dcode from dept2
where area = '�������';

select * from emp2
where dpetno in (1005, 1009);

select * from emp2
where deptno in (select dcode from dept2
                    where area = '�������');

--exists
select * from emp2 e
where exists (select 1 from dept2 d
                where d.dcode = e.deptno
                and area = '�������');

--join
select e.*, d.*
from emp2 e join dept2 d
on e.deptno = d.dcode
--and d.area = '�������';
order by d.area;

--������ 3000�޷� �̻��� ����� ���� �μ� ������ ��ȸ
--emp, dept�̿�
select * from emp;

select * from emp
where sal >= 3000;

--in
select * from dept
where deptno in (select deptno from emp
                    where sal >= 3000);
--exists                    
select * from dept d
where exists(select 1 from emp e
                where e.deptno = d.deptno
                and sal >= 3000);
                
--join                 
select d.* , e.*
from emp e join dept d
on e.deptno = d.deptno
--and e.sal >= 3000;
order by e.sal;
/*
    �� �������� ��ġ�� �̸�
    ���������� ���� ��ġ�� ���� �� �̸��� �ٸ�
    [1] scalar subquery
     select (subquery)
     - select���� ���� ���������� �� ���� ����� 1�྿ ��ȯ��
     
    [2] inline view
     from (subquery)
     - from���� ���� ��������
        
    [3] subquery
     where (subquery)
     - where���� ���� ��������
*/

--emp2 ���̺�� dept2 ���̺��� ��ȸ�Ͽ� ������� �̸��� �μ��̸��� ����Ͻÿ�
--join�̿�



--outer join



--scalar subquery�̿�



--employees, departments - �������, �μ��� ��ȸ
--scalar subquery



--outer join





--�� �μ��� �ش��ϴ� ����� ���ϱ�
select * from dept;
select * from emp;



--�а��� ������ �ο���, ����� ���ϱ�



--employees���� job_id�� salary(�޿�)�հ� �ݾ��� ��ü �޿��ݾ׿��� �����ϴ� �������ϱ�



--employees���� ��������� ���ӻ���� �̸�, �޿� ��� ���ϱ�
--��Į�󼭺����� �̿�
--���ӻ���� ��� ���ӻ���� ������ �����̶�� ���
--�޿� ����� salary�� 5000 �̸��̸� ��, 5000~9999���̸� ��
--10000~19999���̸� ��, 20000�̻��̸� Ư��



--�ǻ��÷�(pseudoColumn), �����÷�, �����÷�
/*
    ���̺� �ִ� �Ϲ����� �÷�ó�� �ൿ�ϱ�� ������, ������ ���̺� ����Ǿ� ����
    ���� �÷�
    [1] ROWNUM : ������ ����� ������ ������ ROW�鿡 ���� �������� ����Ű�� �ǻ��÷�
                - �ַ� Ư�� ������ �� ������ row�� ������ �� ����
    
    [2] ROWID : ���̺� ����� ������ row���� ����� �ּҰ��� ���� �ǻ��÷�
                - ��� ���̺��� ��� row���� ���� �ڽŸ��� ������ rowid���� ���� �ִ�    
*/



--emp���̺� ��ü���� ���� 5���� ������ ��ȸ



--order by�̿�, emp���� ename������ ������ ���¿��� ���� 5�� ��ȸ



--inline view �̿�



--student���� height������� ���� 7���� �л� ��ȸ�ϱ�


--employees���� salary�� �������� �����ؼ� ���� 6�Ǹ� ��ȸ



--�������� 2~4 ������ ������ ��ȸ�ϱ�


--emp ���̺��� ��ȸ�Ͽ� ������ �߿��� �ڽ��� job�� ��� ����(sal)���� ���ų� ���� �޴� ������� ��ȸ�Ͻÿ�.



--�� �а��� �ش��ϴ� ������ �� ���ϱ�


--�� �а��� �ش��ϴ� �л��� ���ϱ�
--department , student ���̺�



--Professor ���̺��� ������ ���� �޴� ���� ������ 10�� ��ȸ�ϱ�


--Student, exam_01 ���̺��� ������ 90�̻��� �л����� ���� ��ȸ


--1.job�� MANAGER�� ����� ��ȸ(emp)


--2. job�� Manager�� ��� ����麸�� �Ի����� ����(����) ��� ������ ��ȸ => all �̿� (emp)


--3. ALL���� ����� ��� <= MIN�Լ��� �Ἥ
--all�� �Ⱦ����� ������������ �߻��Ǵ� �����Ͱ� 1���̸�  ��
--������� ������ �ϳ��� ���=> �����Լ� (�����Լ��� ������� 1��)


--4. sales�μ��� �ٹ��ϴ� ��� ������ ��ȸ


--5. ��ձ޿����� �޿��� ���� �޴� ��� ������ ��������



--inline view
--employees���� ��������� ��ȸ�ϰ�, job_id�� salary��յ� ���

 
--job_id�� salary���


--�α��� ó��
--id:simson, pwd:a1234 �� ��� ������ �α��� ����, id�� ��ġ�ϸ� ��й�ȣ ����ġ
--id�� ������ �ش���̵� ����



--����ڷκ��� �Է°� �޾ƿͼ� ó���ϱ�


--decode �̿�



--inline view
--gogak���� 10��, 30�� ���� ��ȸ
--10,12,17  => 10
--30,33,38  => 30


--gogak���� ���ɴ뺰 �ο����� ����� ���


--�г⺰, ���� �ο����� ����� ���ϱ�
--student



--job_history�� ������ ��ȸ�ϵ� job_id�� �ش��ϴ� job_title, dapartment_id�� �ش��ϴ�
--�μ��� ��ȸ
--��Į�� �������� �̿�
--job_history, jobs, departments



--��������� ��ȸ



--departments, employees �����ؼ� �μ��� �ش��ϴ� ����� ���� ��ȸ�ϱ�
--����� ��� ���
--�μ���ȣ ������ ����


 
--�μ���� ��ȸ
--departments���̺��� employees�� �����ؼ� �μ������ ���� ���Ѵ�


--inline view�̿�



----�� �μ��� ���ϴ� ��������� ��ȸ�ϰ�, �μ��� ��ձ޿��� ����Ͻÿ�


--[1] �� �μ��� ���ϴ� ��������� ��ȸ�ϴ� ������ ���� ���ϱ�


--[2] �μ��� ��ձ޿��� ��ȸ�ϴ� ������ ���� (salary+salary*commission_pct)



--[3] �� ���� ������������ �̿��ؼ� outer join�Ѵ�

