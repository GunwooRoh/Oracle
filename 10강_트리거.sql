--10강_트리거.sql

/*
    ※ 트리거
    - 서브 프로그램 단위의 하나인 트리거는 테이블, 뷰, 스키마 또는 데이터베이스
    에 관련된 PL/SQL 블록으로
    관련된 특정 사건(event)이 발생될 때마다 자동으로 해당 PL/SQL 블록이
    실행됨
    
    -insert, update, delete 의 DML문이나 DDL문의 실행을
     데이터베이스에서는 특정 이벤트가 발생되었다고 함
     
    ※ 주요 트리거 유형
    [1] DML 트리거
        1) 문장 트리거 - 영향을 받는 행이 전혀 없더라도 트리거가 한번은 실행됨
        2) 행 트리거 - 테이블이 트리거 이벤트의 영향을 받을 때마다 실행되고,
            트리거 이벤트의 영향을 받는 행이 없을 경우에는 실행되지 않음
            
    [2] DML이 아닌 트리거
        1) DDL 이벤트 트리거
        - DML 트리거와 거의 동일하지만 트리거를 활용하여 DDL작업을 하는 것만
          다름
          
        2) 데이터베이스 이벤트 트리거
        - 데이터베이스 내에서 생기는 일들을 관리하기 위해서 생성하는 트리거         
*/

/*
    create or replace trigger 트리거 이름
        트리거 실행시점 [before/after]
        이벤트 [insert | update | delete]
        on {테이블이름 | 뷰이름 | 스키마 | 데이터베이스}
    [for each row]
    begin
        트리거 몸체
    end;    
*/
--[1] 부서 테이블(dept)에 insert문 실행 후 메시지를 출력하는 트리거
--(문장 레벨 트리거)
create or replace trigger tr_dept_insert
after insert on dept
begin
    dbms_output.put_line('정상적으로 입력됨!');
end;

select * from user_triggers; --사용자가 만든 트리거 정보 조회
select * from dept;

insert into dept(deptno, dname, loc)
values(60, 'TEST', 'seoul'); --dept테이블에 insert 이벤트가 발생한 후에
--tr_dept_insert 트리거가 수행됨


--[2] 테이블에 데이터를 입력할 수 있는 시간 지정하기(문장 레벨 트리거)

create table t_order(
    no number,
    ord_code    varchar2(10),
    ord_date    date
);


--입력시간이 17:45 ~ 17:50 일 경우만 입력을 허용하고, 
--그 외 시간일 경우는 에러를 발생시키는 트리거
create or replace trigger tr_check_time
before insert on t_order
begin
    if to_char(sysdate, 'HH24:mi') not between '17:45' and '17:50' then
        raise_application_error(-20009, '17:45 ~ 17:50 일 경우만 입력 가능!');
    end if;
end;

insert into t_order(no, ord_code, ord_date)
values(3, 'A03', sysdate);

select * from t_order;

--[3] 테이블에 입력될 데이터 값을 지정하고, 그 값 외에는 에러를 발생시키는 트리거
--(행 레벨 트리거)
--제품 코드가 'C100'인 제품이 입력될 경우 입력을 허용하고, 나머지 제품은 모두 에러를 발생시키는 트리거
drop trigger tr_check_time;

create or replace trigger tr_code_check
before insert on t_order
for each row  --행 레벨 트리거
begin
    if :new.ord_code != 'C100' then
        raise_application_error(-20010, '제품코드가 C100인 제품만 입력 가능!');
    end if;
end;

select * from t_order;

insert into t_order(no, ord_code)
values(4, 'C100');

insert into t_order(no, ord_code)
values(5, 'C200'); --error


/*
old - 변경할 때 변경 전의 값을 가지고 있음
new - 데이터가 추가 혹은 변경되면 new 연산자로 변경 후의 값을 얻을 수 있음
user - 현재 접속중인 사용자를 나타냄
*/



--[4] 기존 테이블(t_test1)에 데이터가 업데이트될 때 기존 내용을 
--백업 테이블(t_test1_bak)로 이동시키는 트리거

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

select * from t_test1;
select * from t_test1_bak;

create or replace trigger tr_backup_t_test1
after update on t_test1
for each row
begin 
    insert into t_test1_bak(no, name)
    values (:old.no, :old.name);
end;

update t_test1
set name = 'CCC'
where no = 1;

update t_test1
set name = 'DDD';

select * from t_test1;
select * from t_test1_bak;
--[5] 기존 테이블(t_test2)의 데이터가 삭제될 때 기존 내용을 
--백업 테이블(t_test2_bak)로 이동시키며 이때 백업 테이블에 삭제한 시간, 
--삭제 전 데이터를 모두 기록하는 트리거

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


create or replace trigger tr_backup_t_test2
after delete on t_test2
for each row
begin
    insert into t_test2_bak
    values(:old.no, :old.name, sysdate);
end;

select * from user_triggers;

delete from t_test2;

insert into t_test2 values(5, 'FFF');
insert into t_test2 values(6, 'GGG');
rollback;
commit;

delete from t_test2
where no = 5;

select * from t_test2;
select * from t_test2_bak;

--[6] 기존 테이블(t_test3)의 추가, 변경, 삭제된 내용을 별도의 로그 테이블을 
--생성하여 기록을 남기도록 트리거를 설정

create table t_test3(
    no number,
    name    varchar2(10)
);

create table t_test3_history(
    o_no number, --변경전이나 삭제된 데이터를 저장하는 칼럼은 o로 시작
    o_name    varchar2(10),    
    n_no number, --변경 후나 추가된 데이터를 저장하는 칼럼은 시작은 n으로 정의
    n_name    varchar2(10),
    who varchar2(30), --어떤 사용자가 어떤 작업을 언제작업 했는지 정보를 저장
    regdate    date default sysdate,
    chk char(1)        
);

insert into t_test3 values(1, 'AAA'); 
insert into t_test3 values(2, 'BBB'); 

commit;

create or replace trigger tr_insert_t_test3
after insert on t_test3
for each row
begin
        insert into t_test3_history(n_no, n_name, who, regdate, chk)
        values (:new.no, :new.name, user, sysdate, 'I');
end;        

select * from t_test3;
select * from t_test3_history;

create or replace trigger tr_regdate
before insert on t_test3
for each row
begin
    insert into t_test3_history(n_no, n_name, who, regdate, chk)
    values (:new.no, :new.name, user||':insert', sysdate, 'I');
end;

update t_test3
set name = 'CCC'
where  no = 1;

select * from t_test3;
select * from t_test3_history;


create or replace trigger tr_delete_t_test3
after delete on t_test3
for each row
begin
        insert into t_test3_history(n_no, n_name, who, regdate, chk)
        values (:new.no, :new.name, user, sysdate, 'D');
end;   

--실습
/*
-상품이 입고되면 재고 테이블에서 자동으로 해당 상품의 재고 수량과 금액이 증가되는 트리거 작성하기
insert into 입고 values(100, 2, 1800);

-상품이 판매되면 재고 테이블에서 자동으로 해당 상품의 재고 수량과 금액이 감소되는 트리거 작성하기
insert into 판매 values(100, 3, 2700);
*/

create table 상품(
    품번 number,
    항목명 varchar2(20), 
    단가 number
);
create table 입고(
    품번 number,
    수량 number, 
    금액 number
);
create table 판매(
    품번 number,
    수량 number, 
    금액 number
);
create table 재고(
    품번 number,
    수량 number, 
    금액 number
);
insert into 상품
values(100, '새우깡',900);
insert into 상품
values(200, '감자깡',900);
insert into 상품
values(300, '맛동산',1000);

insert into 입고 values(100, 10,9000);
insert into 입고 values(200, 10,9000);
insert into 입고 values(300, 10,10000);

insert into 재고 values(100, 10,9000);
insert into 재고 values(200, 10,9000);
insert into 재고 values(300, 10,10000);

commit;


select * from 상품;
select * from 입고;
select * from 판매;
select * from 재고;

--구매
insert into 입고 values(100, 2, 1800);

create or replace trigger tr_구매
after insert on 입고
for each row
begin
    update 재고 set
    수량 = 수량 + :new.수량,
    금액 = 금액 + :new.금액;
end;

select * from 상품;
select * from 입고;
select * from 재고;
select * from 판매;

--판매
insert into 판매 values(100, 3, 2700);

create or replace trigger tr_판매
after delete on 입고
for each row
begin
    update 재고 set
    수량 = 수량 - :new.수량,
    금액 = 금액 - :new.금액;
end;

select * from 상품;
select * from 입고;
select * from 재고;
select * from 판매;


--분석함수
--순위함수 - rank(), dense_rank(), row_number()

/*
    rank | dense_rank | row_number()
    over(<partition by절>, <order by 절>)
*/
--급여가 높은 순서대로 순위를 부여하여 출력
select * from employees;

select employee_id, first_name || '-' || last_name 이름, hire_date, salary,
        department_id,
        rank() over(order by salary desc) as "전체순위(rank)",
        rank() over(partition by department_id order by salary desc) as "부서내 순위 (rank)",
        dense_rank() over(order by salary desc) as "현재순위(dense_rank)",
        dense_rank() over(partition by department_id order by salary desc) as "부서내 순위 (dense_rank)",
        row_number() over(order by salary desc) as "현재순위(row_number)",
        row_number() over(partition by department_id order by salary desc) as "부서내 순위 (row_number)"
from employees
--order by department_id, salary desc;

order by salary desc;

--급여가 가장 많은 사원 (1~5위)까지만 조회하기
--rank이용



--top-n 분석
--입사일 기준으로 정렬한 후 조회하기 - emp
select row_number() over(order by hiredate desc) No,
    empno, ename, hiredate
from emp;

select rownum No, A.*
from
(
    select empno, ename, hiredate from emp
    order by hiredate desc
)A;

--최근에 입사한 7명을 순서대로 조회
--1) rownum 이용
select rownum No, A.*
from
(
    select empno, ename, hiredate from emp
    order by hiredate desc
)A
where rownum <= 7;

--2) row_number() 이용
select row_number() over(order by hiredate desc) No,
    empno, ename, hiredate
from emp
where rownum <= 7;



--professor 테이블에서 교수들의  교수번호와 이름, 급여, 급여 순위를 조회하시오
select * from professor;
select  profno, name, pay,
        rank() over(order by pay desc) as "전체순위(rank)",
        rank() over(partition by deptno order by pay desc) as "부서내 순위 (rank)"
from professor; 


--위 예제에서 급여 순위 1~7위 까지만 조회 - inline view 이용
select *
from
(       select profno, name, pay,
            rank() over(order by pay desc) as "전체순위(rank)",
            rank() over(partition by deptno order by pay desc) as "부서내 순위 (rank)"
        from professor)
where "전체순위(rank)" <= 7;

--emp 테이블을 사용하여 사번, 이름, 급여, 부서번호, 부서별 급여순위를 조회하시오
--partition by - 이 구문 뒤에 그룹핑 할 컬럼을 적어주면 됨
select * from emp;

select empno, ename, sal, deptno, 
        rank() over(order by sal desc) as "전체순위(rank)",
        rank() over(partition by deptno order by sal desc) as "부서내 순위 (rank)"
from emp;

--emp 테이블을 사용하여 사번, 이름, 급여, 부서번호, 부서 내 job별로 급여순위를 조회하시오
select empno, ename, sal, deptno, job,
        rank() over(partition by deptno, job order by sal desc) as "부서 내 job별 급여 순위"
from emp
order by deptno, job, "부서 내 job별 급여 순위";


--누적 합계 구하기
--제품 코드별, 날짜별 누적 판매량
select p_code, p_date, p_qty,
    sum(p_qty) over(partition by p_code order by p_date) 누적판매량
from panmae
order by p_code, p_date;


select p_code, p_date, qty_total 판매량,
    sum(qty_total) over(partition by p_code order by p_date) 누적판매량
from
(
    select p_code, p_date, sum(p_qty) as qty_total
    from panmae
    group by p_code, p_date
);
   
create or replace view v_panmae
as
select p_code, p_date, qty_total 판매량,
    sum(qty_total) over(partition by p_code order by p_date) 누적판매량
from
(
    select p_code, p_date, sum(p_qty) as qty_total
    from panmae
    group by p_code, p_date
);    

select * from v_panmae;

--전체 일자별로 누적 판매량, 누적 판매금액 구하기
select p_date, sum(p_qty) qty, sum(p_total) price
from panmae
group by p_date
order by p_date desc;

select p_date, qty 판매량, price 판매금액,
        sum(qty) over(order by p_date) 누적판매량,
        sum(price) over(order by p_date) 누적판매금액
from
(
    select p_date, sum(p_qty) qty, sum(p_total) price
    from panmae
    group by p_date
);

--p_store별로 누적 판매금액 구하기
--판매일자로 정렬해서 누적

select p_date, p_store, sum(p_total)
from panmae
group by p_store,p_date;

select p_store, p_date, sum(price) over(partition by p_store order by p_date) 누적금, price
from 
(
    select p_store, p_date, sum(p_total) price
    from panmae 
    group by p_store, p_date
);