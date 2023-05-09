--10��_sys����_����ڰ���.sql


--����� ���� ���� ��ȸ
select * from dba_users;

--������ ���Ͽ� ���� ���� ��ȸ
select * from dba_date_files;

--���̺����̽��� ���� ���� ��ȸ
select * from dba_tablespaces;

/*
����Ŭ �����ͺ��̽��� ���� ���� ����
1) �����ͺ�(Data block) - �ּ� �������
   �����ͺ��� default size : 8K
2) �ͽ���Ʈ(Extent) - 8���� �����ͺ��� �𿩼� �ϳ��� �ͽ���Ʈ�� ��
3) ���׸�Ʈ(Segment) - �ϳ� �̻��� �ͽ���Ʈ�� ����
4) ���̺����̽�(Tablespace) - ���׸�Ʈ���� �����ϴ� ������ ���� �̸�

�ϳ��� ���̺����̽��� �ּ� 1���� ����������(������ ����)�� ������
*/

--���̺����̽� ����
/*
create tablespace ���̺����̽���
datafile ������������ ��� size ũ��
autoextend on next ũ�� -- �ڵ� ���� �ɼ�(����)
*/

create tablespace tb_test1
datafile 'C:\mydata\tb_test1.dbf'   size 48m
autoextend on next 10m;

select * from dba_data_files;
select * from dba_tablespaces;

--
create tablespace tb_test2
datafile 'C:\mydata\tb_test2_01.dbf'   size 48m
autoextend on maxsize 1000m,
'C:\mydata\tb_test2_02.dbf'   size 48m
autoextend on maxsize 1000m,
'C:\mydata\tb_test2_03.dbf'   size 48m
autoextend on maxsize 1000m;

--���̺����̽� ����
/*
    drop tablespace ���̺����̽���;
    
    drop tablespace ���̺����̽���
        including contents and datafiles;  --�������� ���������ϱ��� ����
*/
drop tablespace tb_test2
    including contents and datafiles;

--����� ���� �����
/*
    create user ������̸�
    identified by ��й�ȣ
    default tablespace ���̺����̽���;
*/

alter session set "_ORACLE_SCRIPT" = true; 


--tb_test2 ���̺����̽��� ����ϴ� ����ڰ��� �����ϱ�
create user testuser8
identified by testuser123
default tablespace tb_test1;


create user testuser1
identified by testuser123
default tablespace tb_test1;


create user testuser2
identified by testuser123
default tablespace tb_test1;

create user testuser3
identified by testuser123
default tablespace tb_test1;

create user testuser4
identified by testuser123
default tablespace tb_test1;

create user testuser5
identified by testuser123
default tablespace tb_test1;

create user testuser6
identified by testuser123
default tablespace tb_test1;

select * from dba_users
where username like '%TESTUSER%';

--���� ��ȸ
select * from dba_sys_privs where grantee = 'TESTUSER1'; --������ȸ
select * from dba_role_privs where grantee = 'TESTUSER1'; --�� ��ȸ

--����ڿ��� ���� �ο��ϱ�
--grant ���� to ����ڸ�;

--create session���� �ο�(���� ����)
grant create session to testuser1;


create table tbl_test1
(
    no  number primary key,
    name    varchar2(30)    
) tablespace tb_test1;


--���̺���� ���� �ο��ϱ�
grant create table to testuser1;


--���ѹ�Ż
--revoke ���� from ����ڸ�;
revoke create session from testuser1;

--testuser2 ����ڿ��� resource, connect �� �ο��ϱ�
grant resource, connect to testuser2;

select * from dba_sys_privs where grantee = 'TESTUSER2'; --������ȸ
select * from dba_role_privs where grantee = 'TESTUSER2';

select * from dba_sys_privs where grantee = 'RESOURCE';
select * from dba_sys_privs where grantee = 'CONNECT';

select * from dba_sys_privs where grantee = 'HR';
select * from dba_role_privs where grantee = 'HR';


--����� ����
--DROP USER ������̸�
drop user testuser3;

--��� ���� ����
--alter user �����ID account unlock;
alter user testuser2 account unlock;

--���� ��ױ�
--alter user �����ID account lock;
alter user testuser2 account lock;

--���� ������ ��ȣ �����ϱ�
--alter user �����ID identified by ���ο��ȣ;
alter user testuser2 identified by 123;

--����Ŭ�� �����ϴ� role ��ȸ
select * from dba_roles;

/*
��(Role)
- ���ѿ� ���� �ο��� ������ ���� ���ϰ� �ϱ� ���ؼ� ���
- ������ �׷�
- �� �ӿ� ���� ���� ������ �־� �ΰ� ����ڿ��� �� �ϳ��� �ָ� 
  �� �ȿ� �ִ� ��� ������ �� �ް� �Ǵ� ��
*/
--testrole�̶�� �̸��� ���� �����ϰ�, ���ӱ���, ���̺�������� �ο��ϱ�
--1) �� �����ϱ�
create role testrole;

select * from dba_roles where rule = 'TESTROLE';
select * from dba_sys_privs where grantee = 'TESTROLE';

--2) �ѿ� ���� �ο��ϱ�
grant create session to testrole;
grant create table to testrole;

select * from dba_sys_privs where grantee = 'TESTROLE';
--3) testuser3 ����ڿ��� testrole �ο��ϱ�
create role testuser3;

grant testrole to testuser3;

select * from dba_sys_privs where grantee = 'TESTUSER3'
select * from dba_role_privs where grantee = 'TESTUSER3'

--���� �����ͺ��̽��� ��ȸ - xe, orcl
select * from global_name; --xe



--object ���� �ֱ�
--�ش� object�� ������ �������� ������ �ο��ϰų� ��Ż�� �� �ִ�

--testuser3���� hr������ employees ���̺��� ��ȸ�ϰ�, ������ �� �ִ� ���� �ο�
--(hr�������� ó�� ����)
grant select on hr.employees to testuser3;

--select���� ��Ż
revoke select on hr.employees from testuser3;

--update���� �ο�
grant update on hr.employees to testuser3;

--update���� ��Ż
revoke update on hr.employees from testuser3;


testuser3 �������� ó��

select first_name from hr.employees where salary>=17000;

update hr.employees
set salary=20000
where employee_id=100; 


--with grant option
grant resource, connect to testuser4;




/*
    with grant option
    - ������ �����ϴ� ���
    �� �ٸ� ����ڿ��� ������ �Ҵ��� �� �� �ְ� ��
    object ���ѿ��� ���
*/

    testuser3���� ó��
    grant select on hr.employees to testuser4;
    => testuser3������ testuser4�������� hr�� employees�� select�� �� �ִ�
    ������ �ο���
    
    => testuser4�� �����ؼ� hr�� employees�� select�ϸ� ��ȸ��


--with admin option
/*
    - ������ �����ϴ� ���
    �� �ٸ� ����ڿ��� ������ �Ҵ����� �� �ְ� ��
    system ���� ���ѿ��� ���
*/

grant resource, connect to testuser5 with admin option;

/*
    testuser5�� �����ؼ� testuser6���� resouce, connect ����(��) �ο��ϱ�
    grant resource, connect to testuser6;
*/
grant resource, connect to testuser6;

--data dictionary
/*
    - �����ͺ��̽� ���� ����� ��� ��ü�� ������ ������ �ִ� ���̺�
    
    Data Dictionary�� ����
    1) DBA_XXX : �����ͺ��̽� ������ ���� ������ ����
    2) User_XXX : �ڽ��� ������ object ������ ����
                  ���� �����ͺ��̽��� ������ ����ڰ� ������ ��ü�� ������ ����
    3) ALL_XXX : �ڽ��� ������ object�� �ٸ� ����ڰ� ������ object �߿�
                 �ڽ��� �� �� �ִ� ������ ����
                 - ����ڰ� ���� ������ ��� ��Ű���� ������ ����
                 - ������ �ο��������ν� ����
*/

--��� �ڷ� ������ ������ ���
select * from dictionary where table_name like '%USER_%';

--�ڷ���� ���̺��� �� �÷��� ���� ������ ���
select * from dict_columns
where table_name = 'USER_CONS_COLUMNS';

select * from user_cons_columns;



--[1] user_xxx
grant select on hr.employees to testuser3 with grant option;

select * from user_objects;
select * from user_tables;
select * from user_constraints;
select * from user_cons_columns;
select * from user_indexes;
select * from user_ind_columns;
select * from user_sequences;
select * from user_views;
select * from user_source;


--[2] all_xxx
select owner, table_name from all_tables
where table_name = 'EMPLOYEES';

--[3] DBA_XXX
select * from dba_users;

select * from dba_data_files;
select * from dba_tablespaces;

select * from dba_rules;

select * from dba_sys_privs;
select * from dba_role_privs;

