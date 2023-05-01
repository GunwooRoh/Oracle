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
    name1   char(3), --�������� 3����Ʈ
    name2   varchar2(3) --�������� 3����Ʈ
)



insert into char_exam1
values('AA','AA');

select name1, name2, length(name1), length(name2),
    replace(name1, ' ','*'), replace(name2,' ', '*') from char_exam1;

drop table char_exam1;


/*
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
*/

select * from char_exam1; 

select * from nls_session_parameters
where parameter='NLS_LENGTH_SEMANTICS'; --=> BYTE=> char, varchar2���� �����ϸ� byte

--[2] ������ - number
/*
    number
    number(��ü �ڸ���)
    number(��ü �ڸ���, �Ҽ����� �ڸ���)
*/


/*
insert into num_exam1(n1,n2,n3,n4,n5,n6)
values(1234567.89, 1234567.89,1234567.89,1234567.89,1234567.89,1234567.89);

insert into num_exam1(n1,n2,n3,n4,n5,n6,n7)
values(1234567.89, 1234567.89,1234567.89,1234567.89,1234567.89,1234567.89,1234567.89);
--n7�� ��ü �ڸ��� 6���� ����, 7���� �Է��ؼ� ����
*/

select * from num_exam1;

/*
    n8  number(3,5)
    - ��ü �ڸ����� �Ҽ����� �ڸ������� ���� ���
    - 1���� ���� �Ǽ� ǥ��
    - ��ü �ڸ��� 3��, �Ҽ����� �ڸ��� 5��
    => 5-3 => �Ҽ����� �ڸ����� 2���� 0�� �ٰ� ��
*/
/*
insert into num_exam1(n8)
values(0.00123);

insert into num_exam1(n8)
values(0.01234);  --error

insert into num_exam1(n8)
values(0.0012);

insert into num_exam1(n8)
values(0.000123);
*/

select * from num_exam1;

--[3] ��¥��
/*
    date - ����� �ú��� ���� ǥ��
    timestamp - �и��ʱ����� ǥ��
*/




/*
insert into date_exam1
values(sysdate, systimestamp);

insert into date_exam1
values(sysdate, sysdate);

insert into date_exam1
values(systimestamp, systimestamp);
*/

select * from date_exam1;

--���̺� ����� ����
--�̸�, �ֹι�ȣ, ����, ����, �ڱ�Ұ�, �����




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


/*
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
*/

select * from null_exam1
where col3 is null;

select * from null_exam1
where col3 is not null;



--[2] unique (U)
/*
    - �� ���ڵ带 �����ϰ� �ĺ��� �� �ִ� �Ӽ�
    - ����Ű�� unique������������ ����� �� �ִ�
    - �� ���̺� ���� ���� unique���������� �� �� �ִ�.
    - null�� �����
*/


/*
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
*/

select * from unique_exam1;
/*
    null�� ����� unique���� ���� �Է����� ���� �� �ִ�
    col2�� ���� null�� ���ڵ尡 ���� ��
    => unique ��󿡼� ���ܵ�
    
    unique �������ǿ��� not null�� �����ϴ� ���� �Ϲ�����
*/

--�������� ��ȸ
--user_constraints, user_cons_columns �� �̿�


--[3] primary key (P)
/*
    - �� ���ڵ带 �����ϰ� �ĺ��� �� �ִ� �Ӽ�
    - ���̺�� �ϳ��� �� �� �ִ�
    - not null + unique index
    - ����Ű�� ����
*/


/*
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
*/

select * from pk_exam1;


/*
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
*/


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


/*
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
*/


--[6] default
/*
- �⺻��
- �÷��� Ư������ ����Ʈ������ �����ϸ� ���̺� �����͸� �Է��� ��
  �ش� �÷��� ���� �Է����� ���� ��� ����Ʈ�� ������ ���� �ڵ����� �Էµ�
- �÷� Ÿ�� ������ 'default ����Ʈ��' �� ���
- �ݵ�� ������Ÿ�� ������, null�̳� not null �տ� ��ġ���Ѿ� ��
*/


/*
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
*/

--���������� �̿��Ͽ� ���̺� �����
--1) �μ� ���̺� �����
--�μ�(�θ�) <--> ���(�ڽ�)


/*
=> �ڽ� ���̺��� �����ϰ� �ִ� �θ� ���̺��� drop�� �� ������,
�����������Ǳ��� ���� �����ϰ� ������ drop�� cascade constraint �ɼ��� �ش�
(�ڽ��� foreign key�� �����ϰ� �θ� ���̺� ������)
*/



--2) ��� ���̺� �����
--���(�θ�) <--> �������(�ڽ�)
--drop table employee;



select a.TABLE_NAME, a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, a.INDEX_NAME,
    b.COLUMN_NAME, b.POSITION
from user_constraints a join user_cons_columns b
on a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
and  a.table_name = 'EMPLOYEE';

--���̺� ���� �� �������� �߰�
--foreign key �߰��ϱ�



--3) ������� ���̺� �����
--drop table family;


--insert - �θ� ���̺� ���� �����͸� �Է�
--1) �μ� ���̺� insert


--2) ��� ���̺� insert
--�θ��� �μ� ���̺��� ���ڵ尡 ������ �ڽ��� ��� ���̺��� insert�� �� ����


--3) ������� ���̺� insert


--delete
--�ڽ��� �����ϰ� �ִ� �θ� ���̺��� ���ڵ带 �����ϴ� ���
--1) on delete cascade �ɼ��� ���� ���� ���
--=> �θ� ���̺��� ���ڵ带 �����ϸ� ���� �߻�


--=> ������ �ݵ�� �ؾ� �ȴٸ�, �ڽ� ���ڵ带 ���� ������ �� �θ� ���ڵ带 �����Ѵ�

--2) on delete cascade �ɼ��� �� ���
--=> �θ� ���̺��� ���ڵ带 �����ϸ� �ش� ���ڵ带 �����ϴ� �ڽ� ���̺� ���� ������




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
/*
create table employee2
(
    empno   number,  --�����ȣ
    name    varchar2(30)    not null,  --����̸�
    dcode   char(3)         not null,  --�μ��ڵ�
    sal     number(10)  default 0, --�޿�
    email   varchar2(50), --�̸���
    hiredate    date    default sysdate  --�Ի���                        
);
*/

--�������� �߰��ϱ�
--primary key �߰�



select * from user_constraints
where table_name='EMPLOYEE2';

--default�� ��ȸ


--foreign key �߰�


--�������� �̸� �����ϱ�


--�������� �����ϱ�


--check�������� �߰�


--unique�������� �߰�


--not null, default �������� �����ϱ�


--���̺��� ����鼭 �ƿ����� �������� �����ϱ�
/*
create table employee3
(
    empno   number,  --�����ȣ
    name    varchar2(30)    not null,  --����̸�
    dcode   char(3)         not null,  --�μ��ڵ�
    sal     number(10)  default 0, --�޿�
    email   varchar2(50), --�̸���
    hiredate    date    default sysdate,     --�Ի���
    --�ƿ����� ��������
    
				 
);
*/

select * from employee3;


--���� ���� �ý��� ��
/* - USER_TABLES : �ش� ����ڰ� ������ ���̺� ����
   - USER_CONSTRAINTS
   - USER_INDEXES
   - USER_OBJECTS, ��*/



/*
    create table ���̺��
    as
    select��
    
    �� �̿��ؼ� ���̺��� ����� null, not null�� ������ ���������� ������� ����
*/   



--������ ���̺� primary key �߰�


--alter
--���̺� �����ϱ�
--1) ���ο� �÷� �߰��ϱ�


--2) �÷��� ������ũ�� �����ϱ�


--3) �÷� �̸� �����ϱ�
--loc => area�� ����



--cf. ���̺� �̸� �����ϱ�



--4) �÷� �����ϱ�

