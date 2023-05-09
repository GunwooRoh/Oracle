--10��_Ʈ����.sql

/*
    �� Ʈ����
    - ���� ���α׷� ������ �ϳ��� Ʈ���Ŵ� ���̺�, ��, ��Ű�� �Ǵ� �����ͺ��̽�
    �� ���õ� PL/SQL �������
    ���õ� Ư�� ���(event)�� �߻��� ������ �ڵ����� �ش� PL/SQL �����
    �����
    
    -insert, update, delete �� DML���̳� DDL���� ������
     �����ͺ��̽������� Ư�� �̺�Ʈ�� �߻��Ǿ��ٰ� ��
     
    �� �ֿ� Ʈ���� ����
    [1] DML Ʈ����
        1) ���� Ʈ���� - ������ �޴� ���� ���� ������ Ʈ���Ű� �ѹ��� �����
        2) �� Ʈ���� - ���̺��� Ʈ���� �̺�Ʈ�� ������ ���� ������ ����ǰ�,
            Ʈ���� �̺�Ʈ�� ������ �޴� ���� ���� ��쿡�� ������� ����
            
    [2] DML�� �ƴ� Ʈ����
        1) DDL �̺�Ʈ Ʈ����
        - DML Ʈ���ſ� ���� ���������� Ʈ���Ÿ� Ȱ���Ͽ� DDL�۾��� �ϴ� �͸�
          �ٸ�
          
        2) �����ͺ��̽� �̺�Ʈ Ʈ����
        - �����ͺ��̽� ������ ����� �ϵ��� �����ϱ� ���ؼ� �����ϴ� Ʈ����         
*/

/*
    create or replace trigger Ʈ���� �̸�
        Ʈ���� ������� [before/after]
        �̺�Ʈ [insert | update | delete]
        on {���̺��̸� | ���̸� | ��Ű�� | �����ͺ��̽�}
    [for each row]
    begin
        Ʈ���� ��ü
    end;    
*/
--[1] �μ� ���̺�(dept)�� insert�� ���� �� �޽����� ����ϴ� Ʈ����
--(���� ���� Ʈ����)
create or replace trigger tr_dept_insert
after insert on dept
begin
    dbms_output.put_line('���������� �Էµ�!');
end;

select * from user_triggers; --����ڰ� ���� Ʈ���� ���� ��ȸ
select * from dept;

insert into dept(deptno, dname, loc)
values(60, 'TEST', 'seoul'); --dept���̺� insert �̺�Ʈ�� �߻��� �Ŀ�
--tr_dept_insert Ʈ���Ű� �����


--[2] ���̺� �����͸� �Է��� �� �ִ� �ð� �����ϱ�(���� ���� Ʈ����)

create table t_order(
    no number,
    ord_code    varchar2(10),
    ord_date    date
);


--�Է½ð��� 17:45 ~ 17:50 �� ��츸 �Է��� ����ϰ�, 
--�� �� �ð��� ���� ������ �߻���Ű�� Ʈ����
create or replace trigger tr_check_time
before insert on t_order
begin
    if to_char(sysdate, 'HH24:mi') not between '17:45' and '17:50' then
        raise_application_error(-20009, '17:45 ~ 17:50 �� ��츸 �Է� ����!');
    end if;
end;

insert into t_order(no, ord_code, ord_date)
values(3, 'A03', sysdate);

select * from t_order;

--[3] ���̺� �Էµ� ������ ���� �����ϰ�, �� �� �ܿ��� ������ �߻���Ű�� Ʈ����
--(�� ���� Ʈ����)
--��ǰ �ڵ尡 'C100'�� ��ǰ�� �Էµ� ��� �Է��� ����ϰ�, ������ ��ǰ�� ��� ������ �߻���Ű�� Ʈ����
drop trigger tr_check_time;

create or replace trigger tr_code_check
before insert on t_order
for each row  --�� ���� Ʈ����
begin
    if :new.ord_code != 'C100' then
        raise_application_error(-20010, '��ǰ�ڵ尡 C100�� ��ǰ�� �Է� ����!');
    end if;
end;

select * from t_order;

insert into t_order(no, ord_code)
values(4, 'C100');

insert into t_order(no, ord_code)
values(5, 'C200'); --error


/*
old - ������ �� ���� ���� ���� ������ ����
new - �����Ͱ� �߰� Ȥ�� ����Ǹ� new �����ڷ� ���� ���� ���� ���� �� ����
user - ���� �������� ����ڸ� ��Ÿ��
*/



--[4] ���� ���̺�(t_test1)�� �����Ͱ� ������Ʈ�� �� ���� ������ 
--��� ���̺�(t_test1_bak)�� �̵���Ű�� Ʈ����
/*
create table t_test1(
    no number,
    name    varchar2(10)
);

create table t_test1_bak
as 
select * from t_test1;

insert into t_test1 values(1, 'AAA'); 
insert into t_test1 values(2, 'BBB'); 
commit;
*/



--[5] ���� ���̺�(t_test2)�� �����Ͱ� ������ �� ���� ������ 
--��� ���̺�(t_test2_bak)�� �̵���Ű�� �̶� ��� ���̺� ������ �ð�, 
--���� �� �����͸� ��� ����ϴ� Ʈ����
/*
create table t_test2(
    no number,
    name    varchar2(10)
);
create table t_test2_bak(
    no number,
    name    varchar2(10),
    regdate date default sysdate
);
insert into t_test2 values(1, 'AAA'); 
insert into t_test2 values(2, 'BBB'); 
commit;
*/




--[6] ���� ���̺�(t_test3)�� �߰�, ����, ������ ������ ������ �α� ���̺��� 
--�����Ͽ� ����� ���⵵�� Ʈ���Ÿ� ����
/*
create table t_test3(
    no number,
    name    varchar2(10)
);

create table t_test3_history(
    o_no number, --�������̳� ������ �����͸� �����ϴ� Į���� o�� ����
    o_name    varchar2(10),    
    n_no number, --���� �ĳ� �߰��� �����͸� �����ϴ� Į���� ������ n���� ����
    n_name    varchar2(10),
    who varchar2(30), --� ����ڰ� � �۾��� �����۾� �ߴ��� ������ ����
    regdate    date default sysdate,
    chk char(1)        
);

insert into t_test3 values(1, 'AAA'); 
insert into t_test3 values(2, 'BBB'); 

commit;
*/



--�ǽ�
/*
-��ǰ�� �԰�Ǹ� ��� ���̺��� �ڵ����� �ش� ��ǰ�� ��� ������ �ݾ��� �����Ǵ� Ʈ���� �ۼ��ϱ�
insert into �԰� values(100, 2, 1800);

-��ǰ�� �ǸŵǸ� ��� ���̺��� �ڵ����� �ش� ��ǰ�� ��� ������ �ݾ��� ���ҵǴ� Ʈ���� �ۼ��ϱ�
insert into �Ǹ� values(100, 3, 2700);
*/
/*
create table ��ǰ(
    ǰ�� number,
    �׸�� varchar2(20), 
    �ܰ� number
);
create table �԰�(
    ǰ�� number,
    ���� number, 
    �ݾ� number
);
create table �Ǹ�(
    ǰ�� number,
    ���� number, 
    �ݾ� number
);
create table ���(
    ǰ�� number,
    ���� number, 
    �ݾ� number
);
insert into ��ǰ
values(100, '�����',900);
insert into ��ǰ
values(200, '���ڱ�',900);
insert into ��ǰ
values(300, '������',1000);

insert into �԰� values(100, 10,9000);
insert into �԰� values(200, 10,9000);
insert into �԰� values(300, 10,10000);

insert into ��� values(100, 10,9000);
insert into ��� values(200, 10,9000);
insert into ��� values(300, 10,10000);

commit;
*/





--�м��Լ�
--�����Լ� - rank(), dense_rank(), row_number()

/*
    rank | dense_rank | row_number()
    over(<partition by��>, <order by ��>)
*/
--�޿��� ���� ������� ������ �ο��Ͽ� ���
select * from employees;



--�޿��� ���� ���� ��� (1~5��)������ ��ȸ�ϱ�
--rank�̿�



--top-n �м�
--�Ի��� �������� ������ �� ��ȸ�ϱ� - emp


--�ֱٿ� �Ի��� 7���� ������� ��ȸ
--1) rownum �̿�


--2) row_number() �̿�




--professor ���̺��� ��������  ������ȣ�� �̸�, �޿�, �޿� ������ ��ȸ�Ͻÿ�


--�� �������� �޿� ���� 1~7�� ������ ��ȸ - inline view �̿�


--emp ���̺��� ����Ͽ� ���, �̸�, �޿�, �μ���ȣ, �μ��� �޿������� ��ȸ�Ͻÿ�
--partition by - �� ���� �ڿ� �׷��� �� �÷��� �����ָ� ��



--emp ���̺��� ����Ͽ� ���, �̸�, �޿�, �μ���ȣ, �μ� �� job���� �޿������� ��ȸ�Ͻÿ�



--���� �հ� ���ϱ�
--��ǰ �ڵ庰, ��¥�� ���� �Ǹŷ�


--��ü ���ں��� ���� �Ǹŷ�, ���� �Ǹűݾ� ���ϱ�


--p_store���� ���� �Ǹűݾ� ���ϱ�
--�Ǹ����ڷ� �����ؼ� ����


