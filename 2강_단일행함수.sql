--2��_�������Լ�.sql
select * from pd order by no desc;
/*
1) ���� �� �Լ� - �����Ͱ� ���� �� ���������� ���� �� �Լ��� ���� �����ʹ� 
                �ѹ��� �� ��
                - ���� ���� �����͸� �Ѳ����� ó���ϴ� ���� �ƴ϶� �ѹ��� �ϳ��� 
                ó���ϴ� �Լ�
2) ���� �� �Լ� - ���� ���� �����͸� ���ÿ� �Է� �޾Ƽ� ����� 1���� ����� �ִ� �Լ�
                �׷� �Լ���� ��
*/

select * from emp; --14��

--������ �Լ� ��
select ename, initcap(ename), job, length(job), sal from emp; --14��

--������ �Լ� ��


/*
������ �Լ� -�ԷµǴ� �������� ������ ����
[1] �����Լ� - �ԷµǴ� ��(�Ű�����)�� ������ �Լ�
[2] ���� �Լ�
[3] ��¥ �Լ�
[4] ����ȯ �Լ�
[5] �Ϲ��Լ�(��Ÿ�Լ�)
*/

--[1] �����Լ�
--initcap() - ���� ù���ڸ� �빮�ڷ� �ٲ۴�
select id, initcap(id) from student;

select 'preTTy girl', initcap('preTTy girl') from dual;
--���� ���� ���ڵ� �빮�ڷ� �ٲ���

--upper() - �빮�ڷ� ��ȯ����
--lower() - �ҹ��ڷ� ��ȯ
select id, initcap(id), upper(id), lower(id) from student;

select lower('JAVA') from dual;

select * from emp
where ename = 'SCOTT';

select * from emp
where lower(ename) = 'scott';


--length(), lengthb() - ���ڿ��� ���̸� �������ִ� �Լ�
--lengthb() - ���ڿ��� ����Ʈ���� ������(�ѱ� 1���ڴ� 2����Ʈ�� 3����Ʈ�� ó��)
--oracle express ������ �ѱ� 1���ڰ� 3����Ʈ�� �����Ǿ� �ִ�
select name, id, length(name) as "�̸��� ����",
    length(name) as "�̸��� ����Ʈ ��",
    length(id) "id ����", length(id) "id ����Ʈ ��"
from student;

--concat('','') -  �� ���ڿ��� ������ �ִ� �Լ�
--3�� �̻��� ���ڿ��� �����Ϸ��� || ������ �̿�
select name || position as "���� �̸�",
    concat(name, position) as "concat �̿�",
    name || ' ' || position as "|| ������ �̿�"
from professor;

--select concat(name, ' ' position) from professor;
--> error �μ��� ���� ������

--substr() - ���ڿ����� Ư�� ������ ���ڿ��� ������ �� ���
--substr('���ڿ�', ������ġ, ������ ���ڼ�)
--������ġ�� - �� �ϸ� �ڿ������� �ڸ����� �����
select substr('java����Ŭ', 5, 2),
    substr('java����Ŭ', 3, 3),
    substr('java����Ŭ', 6),
    substr('java����Ŭ', -3, 1) from dual;
--���� / va�� / ��Ŭ / ��

--ĳ���ͼ� Ȯ��
select parameter, value from nls_database_parameters
where parameter like '%CHAR%'; --uft8

select name, substr(name, 1, 2), substr(name, 1, 3) from student;
 

--STUDENT ���̺��� ID�� 9���� �̻��� �л����� �̸��� ID�� ���ڼ��� ���
select * from student;
select name, id, length(name), length(id) from student
where length(id) >= 9;

--STUDENT ���̺��� 1������ 201���� �л����� �̸��� �̸��� ���ڼ�, �̸��� ����Ʈ ���� ���
select name, length(name), lengthb(name) from student
where deptno1 = 201;

--student ���̺��� JUMIN Į���� ����Ͽ� 1������ 101���� �л����� �̸��� ��������� ���
select name, substr(jumin, 1, 6) from student
where deptno1 = 101;

--student ���̺��� JUMIN Į���� ����Ͽ� �¾ ���� 8���� ����� �̸��� ��������� ���
select name, substr(jumin, 1, 6) from student
where substr(jumin, 3, 2)='08';

--instr() - �־��� ���ڿ��̳� �÷����� Ư�� ������ ��ġ�� ã���ִ� �Լ�
--instr('���ڿ�', 'ã�� ����')
--instr('���ڿ�', 'ã�� ����', ������ġ, ���°����)
--���°�� �⺻���� 1
select 'A*B*C', instr('A*B*C', '*'),
    instr('A*B*C', '*',3), instr('A*B*C', '*',3,2) from dual;


select 'A*B*C', instr('A*B*C', '*', -1),
    instr('A*B*C', '*', -2), instr('A*B*C', '*', -2, 2),
    instr('A*B*C', '*', -3, 2),
    instr('A*B*C', '*', -3, 4) from dual;

--student ���̺��� TEL Į���� ����Ͽ� �л��� �̸��� ��ȭ��ȣ, ')'�� ������ ��ġ�� ���
select name, tel, instr(tel, ')') from student;

--�ǽ� ) student ���̺��� �����ؼ� 1������ 101���� �л��� �̸��� ��ȭ��ȣ�� 
--������ȣ�� ���. ��, ������ȣ�� ���ڸ� ���;� ��
select name, tel, instr(tel, ')'), substr(tel, 1, 3),
    substr(tel, 1, instr(tel, ')') -1)
from student;


--���ϸ� �����ϱ�
create table test_file
(
    no  number,
    filePath    varchar2(100)
);
                               --123456789012345678901234567890
insert into test_file values(1, 'c:\test\js\example.txt'); --19-11=8 -1 =>7
insert into test_file values(2, 'd:\css\sample\temp\abc.java'); --23-19=4 -1=>3

commit;

select * from test_file;
--1) ���ϸ� ���� => example.txt, abc.java
select substr(filepath, instr(filepath,'\', -1) + 1)
from test_file;

--2) Ȯ���ڸ� ����=> txt, java
select substr(filepath, instr(filepath, '.') + 1)
from test_file;



--3) ���� ���ϸ� ����=> example, abc
select substr(filepath, instr(filepath,'\', -1, 1) + 1,
        instr(filepath, '.', 1)- instr(filepath, '\', -1) -1)
from test_file;
--lpad('���ڿ�' �Ǵ� �÷���, �ڸ���, 'ä�﹮��')
--���ڿ��� ���� �ڸ����� ä�� ���ڷ� ä���, ���ʺ��� ä����
--rpad() - �����ʺ��� ä����

--student ���̺��� 1������ 101���� �а� �л����� ID�� �� 10�ڸ��� ����ϵ� ���� 
--�� �ڸ��� '$'��ȣ�� ä�켼��
select name, id, lpad(id, 10, '$') from student
where deptno1 = 101;


--�ǽ�) DEPT2 ���̺��� ����Ͽ� DNAME�� ���� ����� �������� ���� �ۼ��ϱ�
--dname�� �� 10����Ʈ�� ����ϵ� ���� dname�� ������ ������ �� �ڸ��� �ش� �ڸ��� 
--���ڰ� ������ ��. ��, ������� �̸��� �� 6����Ʈ�̹Ƿ� ���ڰ� 1234���� ����
select dname, lpad(dname, 10, '1') from dept2;
select dname, lpad(dname, 10, '1234567890') from dept2;


--student ���̺��� ID�� 12�ڸ��� ����ϵ� ������ �� �ڸ����� '*'��ȣ�� ä�켼��
select id, rpad(id, 12, '*') from student;

--ltrim('���ڿ�' �Ǵ� �÷���, '������ ����')
--���ʿ��� �ش繮�ڸ� �����Ѵ�
--������ ���ڸ� �����ϸ� ������ �����Ѵ�
--rtrim() - �����ʿ��� �ش� ���ڸ� �����Ѵ�

select ltrim('abcdab', 'a'), ltrim('    �� ����    ') || '|',
    rtrim('abcdab', 'a'), rtrim('    �� ����    ') || '|' from dual;

select ltrim('javaoracle', 'abcdefghijvw'),
    ltrim('javaoracle', 'java'), rtrim('javaoracle', 'oracle'),
    rtrim('javaoracle', 'abcelmnopqr') || '|' from dual;

--DEPT2 ���̺��� DNAME�� ����ϵ� ���ʿ� '��'�̶� ���ڸ� ��� �����ϰ� ���
select dname, ltrim(dname, '��') from dpet2;

--DEPT2 ���̺��� DNAME�� ����ϵ� ������ ���� '��'��� ���ڴ� �����ϰ� ���
select dname, rtrim(dname, '��') from dpet2;

--reverse () - � ���ڿ��� �Ųٷ� �����ִ� ��

 
--replace('���ڿ�' �Ǵ� �÷���, '����1','����2')
--ù��° ���ڿ����� ����1�� ������ ����2�� �ٲپ� ����ϴ� �Լ�
select replace('javajsp', 'j', 'J'),
    replace('javajsp', 'jsp', 'oracle') from dual;


--student ���̺��� �л����� �̸��� ����ϵ� �� �κ��� '#'���� ǥ�õǰ� ���
select name, substr(name, 1, 1),
    replace(name, '��', '#'),
    replace(name, '', '#')
from student;

--�ǽ�) student ���̺��� 1������ 101���� �л����� �̸��� ����ϵ� ��� ���ڸ� '#'���� ǥ�õǰ� ���
select * from student;

select name,
    replace(name, substr(name, 2, 1), '#')
from student
where deptno1 = 101;

--�ǽ�) student ���̺��� 1������ 101���� �л����� �̸��� �ֹι�ȣ�� ����ϵ� 
--�ֹι�ȣ�� �� 7�ڸ��� '*'�� ǥ�õǰ� ���
select name, jumin,
    replace(jumin, substr(jumin, 7), '*******')
from student
where deptno1 = 101;

--�ǽ�) student ���̺��� 1������ 102���� �л����� �̸��� ��ȭ��ȣ, ��ȭ��ȣ���� 
--���� �κи� '#' ó���Ͽ� ���. ��, ��� ������ 3�ڸ��� ������
select name,
    replace(tel, substr(tel, 5, 3), '###')
from student
where deptno1 = 102;

--[2] �����Լ�
--round(����, ���ϴ� �ڸ���) - �ݿø�
select 12345.457, round(12345.457), round(12345.457, 1),
    round(12345.457, 2), round(12345.457, -1), round(12345.457, -2),
    round(12345.457, -3) from dual;
--12345 / 12345.5

/*
    ������ �ݿø�(�Ҽ����� ù°�ڸ����� �ݿø�)
    1: �Ҽ����� 1�ڸ��� �����(�Ҽ����� 2°�ڸ����� �ݿø�)
    2: �Ҽ����� 2�ڸ��� �����(�Ҽ����� 3°�ڸ����� �ݿø�)
    -1: 1�� �ڸ����� �ݿø�(�ڸ����� ������ ��쿡�� �Ҽ� �̻󿡼� ó��)
    -2: 10�� �ڸ����� �ݿø�
    -3: 100�� �ڸ����� �ݿø�
*/

--trunc(����, ���ϴ� �ڸ���) - ����
select 12345.457, trunc(12345.457), trunc(12345.457, 1),
    trunc(12345.457, 2), trunc(12345.457, -1), trunc(12345.457, -2),
    trunc(12345.457, -3) from dual;

--employees���� salary�� 100�� �ڸ����� �ݿø�, �����ؼ� ���
select salary, round(salary, -3), trunc(salary, -3)
from employees;

--mod(����, ������ ��) - �������� ���ϴ� �Լ�
--ceil(�Ҽ����� �ִ� �Ǽ�) - �ø�(�־��� ���ڿ� ���� ������ ū ���� ���)
--floor(�Ǽ�) - ����(���� ������ ���� ����)
--power(����1, ����2) - ����1�� ����2��
select mod(13, 3), ceil(12.3), floor(17.85), power(3, 4) from dual;

 
--[3] ��¥�Լ�
--sysdate : �������ڸ� �����ϴ� �Լ�
select sysdate from dual;

--1) ��ĥ��, ��ĥ ��
/*
���ú��� 100�� ��, 100����

2019-03-27 + 100 => ��¥
2019-03-27 - 100
=> ���ϰ� ���� ������ �ϼ�
*/
select sysdate as "��������", sysdate + 100 "100�� ��",
    sysdate - 100 "100�� ��", sysdate + 1 "����", sysdate - 1 "����" from dual;

    
--2�� 1�ð� 5�� 10�� �� ��¥ ���ϱ�
SELECT SYSDATE, SYSDATE + 2 + 1/24 + 5/1440 + 10/86400
from dual;

--3�� �� ��¥, 3������ ����
--add_months(��¥, ������) : �ش糯¥�κ��� ��������ŭ ���ϰų� �� ��¥�� ���Ѵ�
--=> �� ������, �� �������� �ش��ϴ� ��¥�� ���� �� �ִ�


--1�� ��, 1���� ��¥
select sysdate, add_months(sysdate, 12) "����", add_months(sysdate, -12) "�۳�"
from dual;


--2�� 4���� 1�� 3�ð� 10�� 20�� ���� ��¥ ���ϱ�
    
--to_yminterval() --year - month
--to_dsinterval() -

select sysdate, (sysdate + to_yminterval('02 - 04') + to_dsinterval('1 03:10:20'))
    as "2�� 4���� 1�� 3�ð� 10�� 20�� ��"
from dual;

select sysdate, add_months(sysdate, 28)+1+3/24+10/(24*60)+20/(24*60*60) from dual;
    
--7�� 3���� 5�� 2�ð� 30�� 15�� �� ��¥ ���ϱ�
select sysdate, (sysdate - to_yminterval('07 - 03') - to_dsinterval('5 02:30:15'))
    as "7�� 3���� 5�� 2�ð� 30�� 15�� ��"
from dual;
 
--2) �� ��¥ ������ ����� �ð�(�ϼ�)
--���� 1�� 1�� ���� ��ĥ ����Ǿ�����
--2021-04-15 - 2021-01-01 => ����
select sysdate, sysdate- '2023-01-01' from dual; --error


--��¥�� ����ȯ�� �� ����ؾ� ��
select sysdate, to_date('2023-01-01'),
    sysdate - to_date('2023-01-01') from dual;
 
--�������� ���ñ��� ����� �ϼ�, ���ú��� ���ϱ��� ���� �ϼ�
--to_date(����) => ���ڸ� ��¥���·� ��ȯ���ִ� �Լ�
select to_date('2023-04-20') - to_date('2023-04-19') "�������� ����� �ϼ�",
    to_date('2023-04-21') - to_date('2023-04-20') "���ϱ��� ���� �ϼ�" from dual;

select sysdate - to_date('2023-04-19') "�������� ����� �ϼ�",
    to_date('2023-04-21') - sysdate "���ϱ��� ���� �ϼ�" from dual;

--�ð��� ������ �� ��¥ ������ �ϼ��� ���ϴ� ���
--trunc(��¥) �Լ��� �̿��ϸ� �ش� ��¥�� �������� (�ú��� ����, ����)
select to_date('2023-04-21') - trunc(sysdate) "���ϱ��� ���� �ϼ�",
    sysdate, trunc(sysdate) from dual;

--�� ��¥ ������ ���� ��
--months_between() - �� ��¥ ������ �������� ������
select months_between('2023-03-27', '2023-01-27'),
    months_between('2023-05-27', '2023-01-01'),
    months_between('2023-05-10', '2023-01-27')
from dual;

--next_day() �Լ�
/*
�־��� ��¥�� �������� ���ƿ��� ���� �ֱ� ������ ��¥�� �������ִ� �Լ�
���ϸ� ��� ���ڸ� �Է��� ���� �ִ�.
1:��, 2:��, 3:ȭ ... 7:��
*/
select sysdate, next_day(sysdate, '��'), next_day(sysdate, 'ȭ����'),
    next_day(sysdate, 1), next_day('2023-04-01', '��') from dual;


--last_day() �Լ�
--�־��� ��¥�� ���� ���� ���� ������ ���� �������ִ� �Լ�
select sysdate, last_day(sysdate), last_day('2023-02-03'),
    last_day('2023-05-08'), last_day('2024-02-03') from dual;

--round() - ������������ �� �������� ���� ��¥�� �����ϰ�, �� ���Ŀ��� �� ���� ��¥��
--������

--trunc() - ������ ���� ��¥�� ����
--=> �ð��� ���ܵ�
select sysdate, round(sysdate)


--[4] ����ȯ �Լ�
/*
�� ����Ŭ�� �ڷ���
���� - char(����������), varchar2(����������)
���� - number
��¥ - date

����ȯ
1) �ڵ�����ȯ
2) ����� ����ȯ
    to_char() - ����, ��¥�� ���ڷ� ��ȯ
    to_number() - ���ڸ� ���ڷ� ��ȯ
    to_date() - ���ڸ� ��¥�� ��ȯ
*/

--�ڵ�����ȯ
select 1 + '2', 2 + '003', '004', 1 + to_number('2'),
    2 + to_number('003') from dual;

select * from employees
where hire_date >= '2008-01-01'; --��¥�� �ڵ� ����ȯ

select * from employees
where hire_date >= to_date('2008-01-01');

--(1-1) to_char(��¥, ����) - ��¥�� ������ ����� ���ڷ� ��ȯ�Ѵ�.
select sysdate, to_char(sysdate, 'yyyy'),
    to_char(sysdate, 'mm'),
    to_char(sysdate, 'dd'),
    to_char(sysdate, 'd') "����",
    to_char(sysdate, 'year'),
    to_char(sysdate, 'mon'),
    to_char(sysdate, 'month'),
    to_char(sysdate, 'ddd'), --1�� �� ��ĥ����
    to_char(sysdate, 'day'), --������ �ѱ۷�
    to_char(sysdate, 'dy'), --����(��, ȭ, ��)
    to_char(sysdate, 'q'), --�б�
from dual;

select sysdate, to_char(sysdate, 'yyyy-mm-dd'),
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss am day'),
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss pm day')
from dual;

--extract()�Լ� - �ش� ��¥���� ��,��,���� �����ϴ� �Լ�
select extract(year from sysdate) �⵵,
    extract(month from sysdate) ��,
    extract(day from sysdate) ��
from dual;

select extract(year from to_date('2023-05-08')) �⵵,
    extract(month from to_date('2023-05-08')) ��,
    extract(day from sysdate) ��
from dual;

--�ǽ�) STUDENT ���̺��� birthday Į���� �����Ͽ� ������ 3���� �л��� �̸��� birthday�� ���
select name, birthday
from student
where to_char(birthday, 'mm') = 03;
    

--�ǽ�
--emp���̺��� ����� �Ի��� 90�� ���� ��¥?
select ename, hiredate, hiredate + interval '90' day
from emp;

--emp���̺��� ����� �Ի��� 1���� �Ǵ� ��¥?
select ename, hiredate, hiredate + interval '1' year
from emp;

--���ú��� ũ������������ ���� �ϼ���?
 select sysdate, to_date('2023-12-25') - sysdate as "ũ������������ ���� �ϼ�"
 from dual;

--���ú��� ũ������������ ���� �޼���? (months_between)
 select months_between('2023-12-25', sysdate) "ũ������������ ���� �޼�"
 from dual;


--emp���̺��� �Ի����� ���ñ��� ���� �Ǿ���?
select ename, hiredate, (to_date(sysdate) - hiredate) "��� �� ��"
from emp;

--emp���̺��� �Ի����� ���ñ��� ��� �Ǿ���?
select ename, hiredate, months_between(sysdate, hiredate) "��� �� ��"
from emp;

--emp���̺��� �Ի����� ���ñ��� �� ���� �Ǿ���?
select hiredate, extract(year from sysdate) - extract(year from hiredate) "��� �� ��"
from emp;


--���� ��¥�� �ش��ϴ� ���� ������ ��¥��? (last_day)
select last_day(sysdate)
from dual;

--2016-02-13�� �ش��ϴ� ���� ������ ��¥��?
select last_day('2016-02-13')
from dual;

--(1-2) to_char(����, ����) - ���ڸ� ������ ����� ���ڷ� ��ȯ
/*
    9 : ���� �ڸ��� �������� ä��
    0 : ���� �ڸ��� 0���� ä��
*/
select 1234, to_char(1234, '99999'), to_char(1234, '099999'),
    to_char(1234, '$99999'), to_char(1234, 'L99999'),
    to_char(1234.56, '9999.9'), to_char(1234, '99,999'),
    to_char(1234.56, '9999')from dual;


--Professor ���̺��� �����Ͽ� 101�� �а� �������� �̸��� ������ ����Ͻÿ�. 
--�� ������ (pay*12)+bonus �� ����ϰ� õ ���� ���б�ȣ�� ǥ���Ͻÿ�.
select name as "�̸�", to_char((pay*12) + bonus,'999,999') "����"
from professor
where deptno = 101;

--(2) to_date(����, ����) - ���ڸ� ��¥�� ��ȯ
select to_date('2023-05-20'), to_date('2023-06-07', 'yyyy-mm-dd'),
    to_date('2023-02-05 17:39:20', 'yyyy-mm-dd hh24:mi:ss')from dual;
    
select * from professor where hiredate >= '1995-01-01';
select * from professor where hiredate >= to_date('1995-01-01');

select '2023-04-20' - '2023-04-01' from dual; --error
select to_date('2023-04-20') - to_date('2023-04-01')from dual;
--2021-04-14 ~ 2019-05-05������ ������ ��ȸ



--������� ��ð��� �������� ��ȸ
--pd���̺�, regdate�̿�



--(3) to_number(����) - ���ڸ� ���ڷ� ��ȯ

	

--[�ǽ�]Professor ���̺��� ����Ͽ� 1990�� ������ �Ի��� ������� �Ի���, 
--���� ������ 10% �λ� �� ������ ����Ͻÿ�.
--������ �󿩱�(bonus)�� ������ (pay*12)�� ����ϰ� ������ �λ� �� ������ õ ���� ���� 
--��ȣ�� �߰��Ͽ� ����Ͻÿ�.



--[5] �Ϲ� �Լ�
--nvl(�÷�, ġȯ�� ��) - �ش� �÷��� null�̸� ġȯ�� ������ �ٲٴ� �Լ�


--Professor ���̺��� 101�� �а� �������� �̸��� �޿�, bonus, ������ ����Ͻÿ�. 
--��, ������ (pay*12+bonus)�� ����ϰ� bonus�� ���� ������ 0���� ����Ͻÿ�.


--nvl2(col1, col2, col3) : col1 �� null�� �ƴϸ� col2��
--                                 null�̸� col3�� ���


--Professor ���̺��� 101�� �а� �������� �̸��� �޿�, bonus, ������ ����Ͻÿ�. 
--��, ������ (pay*12+bonus)�� ����ϰ� bonus�� ���� ������ 0���� ����Ͻÿ�.

    
--�̸�(first_name - last_name), �Ի���, salary(�⺻��), �����ۼ�Ʈ(commission_pct),
--����(�⺻��+�⺻��*�����ۼ�Ʈ)*12
--�����ۼ�Ʈ�� null�̸� ������ �⺻��*12
--nvl()�̳� nvl2() �̿�
--employees���̺� �̿�


--decode() �Լ�
--if���� ����ϴ� �Լ�
/*
    decode(A, B, ��, ����)
    - A�� B�� ������ ���� ó���ϰ�, �׷��� ������ ������ ó���Ѵ�.
*/

--student ���� grade�� 1�̸� 1�г�, 2�̸� 2�г�, 3�̸� 3�г�, 4�̸� 4�г��̶�� ���

				  
--Professor ���̺��� ������, �а���ȣ, �а����� ����ϵ� deptno�� 101���� ������ 
--��ǻ�� ���а��� ����ϰ� 101���� �ƴ� �������� �а��� �ƹ��͵� ������� ������.



--Professor ���̺��� ������, �а���ȣ, �а����� ����ϵ� deptno�� 101���� ������ 
--��ǻ�� ���а��� ����ϰ� 101���� �ƴ� �������� �а��� ����Ÿ�а����� ����ϼ���.


--Professor ���̺��� ������, �а����� ����ϵ� deptno�� 101���̸� ����ǻ�� ���а���, 
--102���̸� ����Ƽ�̵�� ���а���, 103���̸� ������Ʈ���� ���а���, �������� ����Ÿ�а����� ����ϼ���.

			      
--Professor ���̺��� ������, �μ���ȣ�� ����ϰ�, deptno�� 101���� �μ� �߿��� 
--�̸��� �������� �������� �����±��� �ĺ������ ����ϼ���. �������� null �� ���.


--Professor ���̺��� ������, �μ���ȣ�� ����ϰ�, deptno�� 101���� �μ� �߿��� 
--�̸��� �������� �������� ������ �����±��� �ĺ������ ����ϼ���. 
--101�� �а��� ������ ���� �ܿ��� ������ ���ĺ��ƴԡ��� ����ϰ� 
--101�� ������ �ƴ� ���� ������ ������ �ǵ��� 



--Student ���̺��� ����Ͽ� �� 1����(deptno1)�� 101���� �а� �л����� �̸�(name)�� 
--�ֹι�ȣ(jumin), ������ ����ϵ� ������ �ֹι�ȣ Į���� �̿��Ͽ� 7��° ���ڰ� 1�� ���
-- �����ڡ�, 2�� ��� �����ڡ��� ����ϼ���



--Student ���̺��� �� 1����(deptno1)�� 101���� �л����� �̸�(name)�� ��ȭ��ȣ(tel),
--�������� ����ϼ���. �������� ������ȣ�� 02�� ����, 031�� ���, 051�� �λ�,052�� ���,
-- 055�� �泲���� ����ϼ���




--to_char() �̿� - 1�̸� ��, 2�̸� ��, ..7�̸� ��


 
--case �Լ� - if���� ����ϴ� �Լ�, ������ �������� �������� ��� ����
/*
    [1] ���ϰ� �񱳽� (=�� �񱳵Ǵ� ���)
        case ���� when ���1 then ���1
                  when ���2 then ���2
                  else ���3
                  end "��Ī"
                  
    [2] ������ �񱳽�
        case when ����1 then ���1
             when ����2 then ���2
             else ���3
             end "��Ī"
*/ 
--1) ���ϰ� ��
--�г� ����ϱ�

--2) ������ ��
--professor ���̺��� pay�������� 400�ʰ�, 300~400����, 300�̸����� ���


 
--Student ���̺��� �л����� �̸��� ��ȭ��ȣ, �������� ����ϼ���. 
--��, ������ȣ�� 02�� ����, 031�� ���, 051�� �λ�,052�� ���, 055�� �泲, 
--�������� ��Ÿ�� ����ϼ���


--Student ���̺��� JUMIN Į���� �����Ͽ� �л����� �̸��� �¾ ��, �б⸦ ����ϼ���. 
--�¾ ���� 01~03���� 1/4�б�, 04~06���� 2/4�б�, 07~09���� 3/4�б�, 
--10~12���� 4/4�б�� ����ϼ���


 
--���� - gogak���̺��� �ֹι�ȣ �̿�
--1:��, 2:��, 3:��, 4:��



--exam_01���� total�� �̿��ؼ� �������ϱ�
--90�̻��̸� A, 80�̻��̸� B, 70�̻��̸� C, 60�̻��̸� D, �������� F

 
--Professor ���̺��� ��ȸ�Ͽ� ������ �޿��׼�(pay)�� �������� 200 �̸��� 4��, 
--201~300�� 3��, 301~400�� 2��, 401 �̻��� 1������ ǥ���Ͽ� ������ ��ȣ(profno), 
--�����̸�(name), �޿�(pay), ����� ����ϼ���. ��, pay Į���� ������������ �����ϼ���.



--gogak ���̺��� ���� ���ϱ�
--jumin���� ������ ���� - substr
--�������ڿ��� ������ - to_char() �� extract()
--������ ���⿡ 1900�̳� 2000 ���ϱ� - substr(), decode()/case
--���������� �⵵ - 1900�̳� 2000�� ���� ���� + 1


 
--�ſ� ������ ���޳�, ���޳��� ������̸� ������ �ݿ��Ͽ�,
--�Ͽ����̸� �������� �ݿ��Ͽ� ������ �޴´�
--���޳� ����ϱ�


    
--emp ���̺��� sal �� 2000 ���� ũ�� ���ʽ��� 1000, 1000���� ũ�� 500, 
--�������� 0 ���� ǥ���ϼ���

    
