--7��_table_��������.sql

/*
   DDL - �����ͺ��̽� ������Ʈ���� ����, ����, ����, �����ϴ� ��ɾ�
   [1] create - ������Ʈ�� ���� ��ɾ�
    create ������ƮŸ��  ������Ʈ��...
    ��) create table ���̺��...
        create sequence ��������..
        
   [2] drop - ������Ʈ ����(���� �Ҹ�)
    drop ������ƮŸ�� ������Ʈ��;
    ��) drop table ���̺��;
        drop sequence ��������;
        
   [3] alter - ������Ʈ ���� ����
    alter ������ƮŸ�� ������Ʈ��..
    ��) alter table dept5
        add loc varchar2(20);
        
   [4] truncate 
    truncate table : ���̺��� ������ ����
    truncate table ���̺��;
    
    �� drop, truncate, delete��
    1) delete - �޸𸮻��� �����͸� ����, rollback���� �ǵ��� �� �ִ�
    2) truncate - �޸𸮻��� �����Ϳ� ������ ���ϱ��� ����, �ڵ�Ŀ�Ե�
                 delete���� ����ӵ��� ����
       => delete, truncate�� �����͸� ����, ���̺� ������ ����ִ�           
    3) drop - ���̺��� �������� ������ �Ҹ��Ŵ
*/
/*
    �� ���̺� �����
    create table ���̺��
    (
        �÷���1    ������Ÿ��,
        �÷���2    ������Ÿ��,
        �÷���3    ������Ÿ��,
        ....
    )
    
    �� ������Ÿ��
    ������, ������, ��¥��
    [1] ������
    char(ũ��) - �������� ������, �ִ� 2000byte���� ���� 
    varchar2(ũ��) - �������� ������, �ִ� 4000byte���� ����
    CLOB Ÿ��(Character Large Object) 
        - ũ�Ⱑ ū ���ڿ��̳� ������ ������ ����
        - long Ÿ���� Ȯ��� ����, 4GB���� ���� 
*/

--char, varchar2 ��
create table char_exam1
(
    name1   char(3),    --��������  3����Ʈ
    name2   varchar2(3) --��������  3����Ʈ
);

insert into char_exam1
values('AA','AA');

select name1, name2, length(name1), length(name2),
    replace(name1, ' ','*'), replace(name2,' ', '*') from char_exam1;

drop table char_exam1;

--[2023-05-02 ȭ]
create table char_exam1
(
    name1   char(3),  --�����ϸ� byte
    name2   varchar2(3),
    name3   char(6 byte),
    name4   char(6 char),
    name5   char(6),  --6 byte
    name6   clob  --4GB���� ����
);


insert into char_exam1(name1,name2,name3,name4,name5,name6)
values('AAA','��','ABCDEF','ABCDEFG','AB',null);  --error
--name4�� 6�� ���ڸ� �Է� �����ϹǷ� ����

insert into char_exam1(name1,name2,name3,name4,name5,name6)
values('AAA','��','ABCDEF','�����ٶ󸶹�','����',null);
--���ڵ��� ���� �ѱ� 1���ڴ� 2����Ʈ�� 3����Ʈ
--UTF-8 : �ѱ� 1���ڰ� 3����Ʈ

insert into char_exam1(name1,name2,name3,name4,name5,name6)
values('AAA','��','ABCDEF','�����ٶ󸶹�','������',null); --error
--name5�� 6����Ʈ�̹Ƿ� �ѱ� 2���ڸ� �Է� ����

insert into char_exam1(name1,name3,name6)
values('ABC','ABCDEF','ABCdefg������ clob ����!!');


select * from char_exam1; 

select * from nls_session_parameters
where parameter='NLS_LENGTH_SEMANTICS'; --=> BYTE=> char, varchar2���� �����ϸ� byte

--[2] ������ - number
/*
    number
    number(��ü �ڸ���)
    number(��ü �ڸ���, �Ҽ����� �ڸ���)
*/
create table num_exam1
(  --1234567.89
    n1  number,
    n2  number(9),    --��ü 9�ڸ��� �� ǥ�� ����
    n3  number(9,2),  --��ü 9�ڸ��� �� �� �Ҽ����� 2�ڸ����� ǥ��
                      --�Ҽ����� 3° �ڸ����� �ݿø�
    n4  number(9,1),  --��ü 9�ڸ��� �� �� �Ҽ����� 1�ڸ����� ǥ��
    n5  number(7),  --��ü 7�ڸ��� �� ǥ��, �Ҽ����� �ڸ����� ǥ������ ����
    n6  number(7,-2),  --��ü 7�ڸ��� �� ǥ��, �Ҽ��̻� ��°�ڸ�(���� �ڸ�)���� �ݿø�
    n7  number(6),  --��ü 6�ڸ��� �� ǥ��
    n8  number(3,5)  --1���� ���� �Ǽ� ǥ��, �Ҽ����� 5�ڸ� �� 0�� 2��(5-3) �ٴ´�                        
);


insert into num_exam1(n1,n2,n3,n4,n5,n6)
values(1234567.89, 1234567.89,1234567.89,1234567.89,1234567.89,1234567.89);

insert into num_exam1(n1,n2,n3,n4,n5,n6,n7)
values(1234567.89, 1234567.89,1234567.89,1234567.89,1234567.89,1234567.89,1234567.89);
--n7�� ��ü �ڸ��� 6���� ����, 7���� �Է��ؼ� ����


select * from num_exam1;

/*
    n8  number(3,5)
    - ��ü �ڸ����� �Ҽ����� �ڸ������� ���� ���
    - 1���� ���� �Ǽ� ǥ��
    - ��ü �ڸ��� 3��, �Ҽ����� �ڸ��� 5��
    => 5-3 => �Ҽ����� �ڸ����� 2���� 0�� �ٰ� ��
*/

insert into num_exam1(n8)
values(0.00123);

insert into num_exam1(n8)
values(0.01234);  --error

insert into num_exam1(n8)
values(0.0012);

insert into num_exam1(n8)
values(0.000123);

select * from num_exam1;

--[3] ��¥��
/*
    date - ����� �ú��� ���� ǥ��
    timestamp - �и��ʱ����� ǥ��
*/

select sysdate, systimestamp from dual;

select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
    to_char(systimestamp, 'yyyy-mm-dd hh24:mi:ss.ff')
from dual;

create table date_exam1
(
    d1  date,
    d2  timestamp
);

insert into date_exam1
values(sysdate, systimestamp);

insert into date_exam1
values(sysdate, sysdate);

insert into date_exam1
values(systimestamp, systimestamp);


select * from date_exam1;

--���̺� ����� ����
--�̸�, �ֹι�ȣ, ����, ����, �ڱ�Ұ�, �����
create table tbl_test1
(
  name  varchar2(30),   --�̸�(�ִ� 4000����Ʈ)
  ssn   char(14),       --�ֹι�ȣ(�ִ� 2000����Ʈ)
  gender    char,       --����(M,F)
  age       number(3),  --����
  intro     clob,       --�ڱ�Ұ�(�ִ� 4GB)
  regdate   date        --�����  
);

insert into tbl_test1
values('ȫ�浿','990102-1112222', 'F', 20, '�ȳ��ϼ���', sysdate);

select * from tbl_test1;

--���Ἲ ��������
/*
    ������ ���Ἲ
    - ����Ŭ �������� �����͸� �� ���� �����ǰ� �����ִ°�
    - ����ε� �����͵��� �ùٸ��� ����� �� �ֵ��� �ϱ� ����
      �����ͺ��̽� ������ �����ϴ� ��ɵ� => ���Ἲ ��������
    - ���Ἲ�� ��Ű�� ���� �������ǵ��� ������
    - �������ǵ��� ���̺��� �÷��� �����
    
    �� ���Ἲ �������� (Integrity Constraint)
    [1] NULL/NOT NULL
    [2] UNIQUE
    [3] PRIMARY KEY
    [4] FOREIGN KEY
    [5] CHECK
    [6] DEFAULT 
*/
--[1] NULL (NOT NULL => C)
/*
    - �����Ͱ� ������ �ǹ�
    - �÷��� �Ӽ� �� �ϳ��� �ش� �÷��� NULL���� ����ϴ��� ������� �ʴ��� ����
    - ������Ÿ�� ������ �����
    - NULL�� ����ϸ� NULL, ������� ������ NOT NULL ���
    - ������� ������ ����Ʈ�� : NULL
*/
create table null_exam1
(
    col1    char(3) not null,   --null�� ������� ���� => �ݵ�� ���� �Է��ؾ� ��
    col2    char(3) null,   --null�� �����
    col3    char(3)         --�����ϸ� null�� �����
);


insert into null_exam1(col1, col2)
values('AA','BB');

insert into null_exam1(col2, col3)
values('B2','C2');  
--col1�� not null�̹Ƿ� ���� �Է��ؾ� ��

insert into null_exam1(col1, col2, col3)
values('A2',null, '');  --null�� ���� �Է��ϴ� ��� : null, ''�Է�

insert into null_exam1(col1, col3)
values('A3',' ');  --' '�� null�� �ƴ�

insert into null_exam1(col1)
values('A4');


select * from null_exam1
where col3 is null;

select * from null_exam1
where col3 is not null;

--=> �ʼ� �Է��׸񿡴� not null ���������� �����ؾ� ��

--[2] unique (U)
/*
    - �� ���ڵ带 �����ϰ� �ĺ��� �� �ִ� �Ӽ�
    - ����Ű�� unique������������ ����� �� �ִ�
    - �� ���̺� ���� ���� unique���������� �� �� �ִ�.
    - null�� �����
*/
create table unique_exam1
(
    col1    varchar2(10)    unique  not null,
    col2    varchar2(10)    unique  null,   --null ���
    col3    varchar2(10)    not null,
    col4    varchar2(10)    not null,
    constraint unique_col   unique(col3, col4) --outline��������, unique ���ձ�
);


insert into unique_exam1
values('AA','BB','CC','DD');

insert into unique_exam1(col1,col3,col4)
values('AA','C1','D1'); 
--unique�������� ����, col1�� AA�� �̹� �����Ƿ� �ߺ��� �� ����

insert into unique_exam1(col1,col3,col4)
values('A4','CC','DD'); --error: col3, col4�� ����Ű�� unique�ؾ� �ϹǷ�

insert into unique_exam1(col1,col3,col4)
values('A1','C1','C2');  --col2�� unique ������, null����ϹǷ� �Է� ����

insert into unique_exam1
values('A2',null,'C2','D2');

insert into unique_exam1
values('A3','','C3','D3');


select * from unique_exam1;

/*
    null�� ����� unique���� ���� �Է����� ���� �� �ִ�
    col2�� ���� null�� ���ڵ尡 ���� ��
    => unique ��󿡼� ���ܵ�
    
    unique �������ǿ��� not null�� �����ϴ� ���� �Ϲ�����
*/

--�������� ��ȸ
--user_constraints, user_cons_columns �� �̿�
select * from user_constraints
where table_name like '%EXAM%';

select * from user_cons_columns
where table_name like '%EXAM%';

select a.TABLE_NAME, a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, a.INDEX_NAME,
    b.COLUMN_NAME, b.POSITION
from user_constraints a join user_cons_columns b
on a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
and  a.table_name like '%EXAM%';

--[3] primary key (P)
/*
    - �� ���ڵ带 �����ϰ� �ĺ��� �� �ִ� �Ӽ�
    - ���̺�� �ϳ��� �� �� �ִ�
    - not null + unique index
    - ����Ű�� ����
*/
create table pk_exam1
(
    col1    char(3) primary key,    --inline ��������
    --col2    char(3) primary key,    --error:���̺�� �ϳ��� �;� �ϹǷ�
    col2    varchar2(4),
    col3    number
);


insert into pk_exam1(col1,col2,col3)
values('A01','AA',1);

insert into pk_exam1(col1,col2,col3)
values('A01','BB',2);  
--col1�� unique�ؾ� �ϹǷ� 

insert into pk_exam1(col1,col2,col3)
values(null,'CC',3); 
--primary key�� not null�̹Ƿ�, null������� ����

insert into pk_exam1(col1)
values('A02');


select * from pk_exam1;

create table pk_exam2
(
    col1    char(3),
    col2    varchar2(4),
    col3    number,
    constraint pk1_col1 primary key(col1, col2) --����Ű, outline ��������
);

insert into pk_exam2
values('A01', 'B01', 10);

insert into pk_exam2
values('A01', 'B01', 20);  --error:col1, col2�� ����Ű, unique �������� ����

insert into pk_exam2
values('A01', 'B02', 30);

select * from pk_exam2;

update pk_exam2
set col2='B01'
where col1='A01' and col2='B02'; --error: unique�������� ����

commit; 

select a.TABLE_NAME, a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, a.INDEX_NAME,
    b.COLUMN_NAME, b.POSITION
from user_constraints a join user_cons_columns b
on a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
and  a.table_name like '%EXAM%';



--[4] foreign key(R) �ܷ�Ű ��������
/*
    - �ٸ� ���̺��� �����ϱ� ���Ͽ� ���Ǵ� �Ӽ���
    - ���̺��� ���踦 ������ �� ���Ǵ� Ű
    - �θ� ���̺��� primary key�� unique�� �ڽ� ���̺��� foreign key�� ���̵ȴ�
    
    - �Է½� �θ� ���̺��� ���� insert�ϰ�, �� �Ŀ� �ڽ� ���̺��� insert�ؾ� ��
    - �θ� ���̺� �ִ� �����÷��� ���� �ڽ� ���̺��� ����� �� �ִ�
    (�θ� ���̺� ���� ���� �ڽ� ���̺��� ����ϴ� ���� �Ұ���)
    
    - ������ �ڽ� ���̺��� ���� �����ϰ�, �� �Ŀ� �θ� ���̺��� �����ؾ� ��
    - foreign key ������ on delete cascade �ɼ��� �ָ�
      �θ� ���̺��� ���ڵ带 �����ϸ� �ڽ� ���̺��� �ش� ���ڵ嵵 ������
*/




--[5] CHECK ���� ���� (C)
/*
    - �ԷµǴ� ���� üũ�Ͽ� ������ ���ǿ� �ش�Ǵ� ���� �Էµ� �� �ְ� �ϴ� ��������
    ��) ����(gender) �÷� => ����, ���ڸ� �Էµǰ� �ٸ� ���� �Էµ� �� ������
*/

create table check_exam1
(
    no  number  primary key,
    name    varchar2(30)    not null,
    gender  char(6) check(gender in('����','����')), --inline ��������
    pay     number(10),
    age     number(3),
    constraint ck_check_exam1_pay check(pay>=0),
    constraint ck_check_exam1_age check(age>=0 and age<=120)
);

insert into check_exam1(no, name)
values(1,'ȫ�浿');

insert into check_exam1(no, name, gender, pay, age)
values(2,'��浿','����', 5000000,35);

insert into check_exam1(no, name, gender, pay, age)
values(3,'�̱��','��', 500000,30);  
--gender check�������� ����

insert into check_exam1(no, name, gender, pay, age)
values(4,'�����','����', -300000,31); --error:pay check �������� ����

insert into check_exam1(no, name, gender, pay, age)
values(5,'��浿','����', 5000000,135); --error: age check�������� ����

select * from check_exam1;

select a.TABLE_NAME, a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, a.INDEX_NAME,
    b.COLUMN_NAME, b.POSITION
from user_constraints a join user_cons_columns b
on a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
and  a.table_name = 'CHECK_EXAM1';



--[6] default
/*
- �⺻��
- �÷��� Ư������ ����Ʈ������ �����ϸ� ���̺� �����͸� �Է��� ��
  �ش� �÷��� ���� �Է����� ���� ��� ����Ʈ�� ������ ���� �ڵ����� �Էµ�
- �÷� Ÿ�� ������ 'default ����Ʈ��' �� ���
- �ݵ�� ������Ÿ�� ������, null�̳� not null �տ� ��ġ���Ѿ� ��
*/

create table default_exam1
(
    no  number  primary key,
    name    varchar2(30),
    gender  char(3) default '��' check(gender in('��','��')),
    hiredate    date    default sysdate not null,
    score   number(3)   default 0
);

insert into default_exam1(no, hiredate)
values(1, sysdate);

insert into default_exam1(no)
values(2);

insert into default_exam1(no, name, gender, hiredate, score)
values(3,'ȫ�漱','��', default, 90);

insert into default_exam1
values(4,'���浿',default, default, default);

insert into default_exam1(no, name)
values(5,'�̱浿');

select * from default_exam1;


--���������� �̿��Ͽ� ���̺� �����
--1) �μ� ���̺� �����
--�μ�(�θ�) <--> ���(�ڽ�)

--drop table depart;
drop table depart cascade constraint;
/*
=> �ڽ� ���̺��� �����ϰ� �ִ� �θ� ���̺��� drop�� �� ������,
�����������Ǳ��� ���� �����ϰ� ������ drop�� cascade constraint �ɼ��� �ش�
(�ڽ��� foreign key�� �����ϰ� �θ� ���̺� ������)
*/
create table depart
(
    dept_cd char(3) primary key,    --�μ��ڵ�
    dept_name   varchar2(50)    not null,   --�μ���
    loc     varchar2(100)   --����
);

--2) ��� ���̺� �����
--���(�θ�) <--> �������(�ڽ�)
--drop table employee;
create table employee
(
    empno   number  primary key,    --�����ȣ
    name    varchar2(30)    not null,   --����̸�
    dcode   char(3) not null constraint fk_employee_dcode
                                references depart(dept_cd), --�μ��ڵ�
    sal     number(10)  default 0 check(sal>=0),    --�޿�
    email   varchar2(50)    unique, --�̸���
    hiredate    date    default sysdate --�Ի���                                
);

select * from depart;
select * from employee;

select a.TABLE_NAME, a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, a.INDEX_NAME,
    b.COLUMN_NAME, b.POSITION
from user_constraints a join user_cons_columns b
on a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
and  a.table_name = 'EMPLOYEE';

--���̺� ���� �� �������� �߰�
--foreign key �߰��ϱ�
alter table employee
add constraint fk_employee_dcode foreign key(dcode)
    references depart(dept_cd);


--3) ������� ���̺� �����
--drop table family;
create table family
(
    empno   number  not null    constraint fk_family_empno
                                    references employee(empno) on delete cascade,--�����ȣ
    name    varchar2(30)    not null, --�����̸�
    relation    varchar2(50),   --��������
    constraint pk_family_empno_name primary key(empno, name)                                
);

select * from family;

--insert - �θ� ���̺� ���� �����͸� �Է�
--1) �μ� ���̺� insert
insert into depart(dept_cd, dept_name, loc)
values('A01','�λ��','����');
insert into depart(dept_cd, dept_name, loc)
values('B01','������','�λ�');
insert into depart(dept_cd, dept_name, loc)
values('C01','�ѹ���','����');

select * from depart;

--2) ��� ���̺� insert
--�θ��� �μ� ���̺��� ���ڵ尡 ������ �ڽ��� ��� ���̺��� insert�� �� ����
insert into employee(empno, name, dcode, sal, email, hiredate)
values(1001,'ȫ�浿','A01',5000000, 'h@nate.com',sysdate);

insert into employee(empno, name, dcode, sal, email)
values(1002,'ȫ�浿2','F01',5000000, 'h2@nate.com');  --error:�θ�Ű�� ����

insert into employee(empno, name, dcode, sal, email)
values(1003,'ȫ�浿3','A01',-50000, 'h3@nate.com');  --error:check�������� ����

insert into employee(empno, name, dcode, sal, email)
values(1004,'ȫ�浿4','A01',5000000, 'h@nate.com');  --error:unique�������� ����

insert into employee(empno, name, dcode, sal, email)
values(1002,'��浿','B01',2000000, 'k@nate.com');  

insert into employee(empno, name, dcode, sal, email)
values(1003,'�̱浿','C01',3000000, 'l@nate.com');  

select * from employee;

--3) ������� ���̺� insert
insert into family(empno, name, relation)
values(1005, '�ڱ��','��');  --error:�θ�Ű�� ����

insert into family(empno, name, relation)
values(1001, 'ȫ�ƺ�','��'); 

insert into family(empno, name, relation)
values(1001, '�����','��'); 

insert into family(empno, name, relation)
values(1001, 'ȫ�ƺ�','��');  --error:unique�������� ���� 

insert into family(empno, name, relation)
values(1002, '��ƹ���','��'); 

insert into family(empno, name, relation)
values(1002, '�ھ�Ӵ�','��'); 

insert into family(empno, name, relation)
values(1002, '����','��'); 

select * from depart;
select * from employee;
select * from family;

--delete
--�ڽ��� �����ϰ� �ִ� �θ� ���̺��� ���ڵ带 �����ϴ� ���
--1) on delete cascade �ɼ��� ���� ���� ���
--=> �θ� ���̺��� ���ڵ带 �����ϸ� ���� �߻�
delete from depart
where dept_cd='A01'; --error: foreign key�������� ����- �ڽ� ���ڵ尡 �߰ߵǾ���
--=> ������ �ݵ�� �ؾ� �ȴٸ�, �ڽ� ���ڵ带 ���� ������ �� �θ� ���ڵ带 �����Ѵ�

--2) on delete cascade �ɼ��� �� ���
--=> �θ� ���̺��� ���ڵ带 �����ϸ� �ش� ���ڵ带 �����ϴ� �ڽ� ���̺� ���� ������
delete from employee
where empno=1001;  --family���� �����ϰ� �ִ� ���ڵ����� ���� ����
--=> �θ��� employee�� 1001�� ���ڵ尡 �����Ǹ鼭, �ڽ��� family�� 1001�� ���ڵ�鵵
--���� ������
commit;

/*
    1) ���̺� ���� �� �������� �߰�
    alter table ���̺��
    add constraint ���������̸�  ������������(�÷�);
    ��) alter table emp
        add constraint pk_empno primary key(empno);
        
    2) ���̺��� ����鼭 �ƿ����� �������� ����
    �÷����� ��� ������ ���Ŀ�
    , constraint ���������̸� ������������(�÷�)
    ��) , constraint pk_empno primary key(empno);
    
    3) �ζ��� �������� ����
    �÷����� ������Ÿ�� �ڿ� �������� ����
    ��) empno number primary key    
*/

--���̺� ���� �� �������� �߰��ϱ�

create table employee2
(
    empno   number,  --�����ȣ
    name    varchar2(30)    not null,  --����̸�
    dcode   char(3)         not null,  --�μ��ڵ�
    sal     number(10)  default 0, --�޿�
    email   varchar2(50), --�̸���
    hiredate    date    default sysdate  --�Ի���                        
);


--�������� �߰��ϱ�
--primary key �߰�
alter table employee2
add constraint pk_employee2_empno primary key(empno);

select * from user_constraints
where table_name='EMPLOYEE2';

--default�� ��ȸ
select column_name, data_default
from user_tab_columns
where table_name='EMPLOYEE2';

--foreign key �߰�
alter table employee2
add constraint fk_employee2_empno foreign key(dcode)
    references depart(dept_cd);

--�������� �̸� �����ϱ�
alter table employee2
rename constraint fk_employee2_empno to fk_employee2_dcode;

--�������� �����ϱ�
alter table employee2
drop constraint pk_employee2_empno;

select * from user_constraints
where table_name='EMPLOYEE2';

--check�������� �߰�
alter table employee2
add constraint ck_employee2_sal check(sal>=0);

--unique�������� �߰�
alter table employee2
add constraint unique_employee2_email unique(email);

--not null, default �������� �����ϱ�
alter table employee2
modify name null; --name�÷��� not null�̾��µ� null�� ����

desc employee2;

alter table employee2
modify name not null;

alter table employee2
modify sal default 1000; --sal �÷��� default���� 0�̾��µ� 1000���� ����


--���̺��� ����鼭 �ƿ����� �������� �����ϱ�

create table employee3
(
    empno   number,  --�����ȣ
    name    varchar2(30)    not null,  --����̸�
    dcode   char(3)         not null,  --�μ��ڵ�
    sal     number(10)  default 0, --�޿�
    email   varchar2(50), --�̸���
    hiredate    date    default sysdate,     --�Ի���
    --�ƿ����� ��������
    constraint pk_employee3_empno primary key(empno),
    constraint fk_employee3_dcode foreign key(dcode)
                references depart(dept_cd),
    constraint ck_employee3_sal check(sal>=0),
    constraint uk_employee3_email unique(email)
);

select * from employee3;

select * from user_constraints
where table_name='EMPLOYEE4';

--
create table employee4
(
    empno   number,  --�����ȣ
    name    varchar2(30)  constraint nn_employee4_name  not null,  --����̸�
    dcode   char(3)         not null,  --�μ��ڵ�
    sal     number(10)  default 0, --�޿�
    email   varchar2(50), --�̸���
    hiredate    date    default sysdate,     --�Ի���
    --�ƿ����� ��������
    constraint pk_employee4_empno primary key(empno),
    constraint fk_employee4_dcode foreign key(dcode)
                references depart(dept_cd),
    constraint ck_employee4_sal check(sal>=0),
    constraint uk_employee4_email unique(email)
);


--���� ���� �ý��� ��
/* - USER_TABLES : �ش� ����ڰ� ������ ���̺� ����
   - USER_CONSTRAINTS
   - USER_INDEXES
   - USER_OBJECTS, ��*/
   
select * from user_tables;
select * from user_constraints;
select * from user_indexes;
select * from user_objects;


/*
    create table ���̺��
    as
    select��
    
    �� �̿��ؼ� ���̺��� ����� null, not null�� ������ ���������� ������� ����
*/   
create table depart_temp1
as
select * from depart;

create table depart_temp2
as
select * from depart
where 0=1; --�����ʹ� �Էµ��� ����

select * from depart_temp1;
select * from depart_temp2;

select * from user_constraints
where table_name like '%DEPART_TEMP%'
order by table_name;

--������ ���̺� primary key �߰�
alter table depart_temp1
add constraint pk_depart_temp1_deptcd primary key(dept_cd);

--alter
--���̺� �����ϱ�
--1) ���ο� �÷� �߰��ϱ�
alter table depart
add pdept char(3);  --�߰��ɶ� ���� null�� ��

alter table depart
add country varchar2(50) default '�ѱ�';
--�߰��� �� ���� default���� ��

select * from depart;

--2) �÷��� ������ũ�� �����ϱ�
alter table depart
modify country varchar2(70);
--country �÷��� ������ Ÿ�� ���� varchar2(50) => varchar2(70)

desc depart;

--3) �÷� �̸� �����ϱ�
--loc => area�� ����
alter table depart
rename column loc to area;

select * from depart;

--cf. ���̺� �̸� �����ϱ�
rename depart_temp1 to depart_temp10; 
select * from depart_temp1;
select * from depart_temp10;

--4) �÷� �����ϱ�
alter table depart
drop column pdept;

select * from depart;
