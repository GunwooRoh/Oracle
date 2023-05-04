--8강_sql_index_view.sql
--[2023-05-04 목]
--sequence
/*
- 연속적인 숫자를 생성해내는 데이터베이스 객체
- 기본키가 각각의 입력되는 row를 식별할 수 있기만 하면 된다고 할때,
  시퀀스에 의해 생성된 값을 사용함
  
- 테이블에 있는 기본키 값을 생성하기 위해 사용되는 독립적인 객체
- 테이블에 종속되지 않음 => 하나의 시퀀스를 여러 개의 테이블에 동시에
  사용할 수 있다
  
  create sequence 시퀀스명
  minvalue      --시퀀스의 최소값
  maxvalue      --시퀀스의 최대값
  start with 시작값
  increment by 증가치
  nocache       --cache사용하지 않겠다
  nocycle       --생성된 시퀀스값이 최대치 혹은 최소치에 다다랐을 때
                   초기값부터 다시 시작할 지 여부
  order         --요청되는 순서대로 값을 생성
  
  ※ 시퀀스 사용
  nextval, currval 의사컬럼
  1) nextval - 바로 다음에 생성될 시퀀스를 가지고 있다
  2) currval - 현재 시퀀스값을 가지고 있다                  
*/


select * from pd;
select * from pd_temp1;


create table pd_temp1
as
select * from pd
where 0=1;

alter table pd_temp1
add constraint pk_pd_temp1_no primary key(no);

select * from user_constraints
where table_name = 'PD_TEMP1';


--시퀀스 생성
create sequence pd_temp1_seq
minvalue 1
maxvalue 9999999999999 --9가 13개
increment by 1
start with 50  --50부터 시작해서 1씩 증가
nocache;

--사용자가 생성한 시퀀스 조회
select * from user_sequences;

select pd_temp1_seq.currval from dual;
--[Error]시퀀스 PD_TEMP1_SEQ.CURRVAL은 이 세션에서는 정의 되어 있지 않습니다

insert into pd_temp1(no, pdname, price, regdate)
values(pd_temp1_seq.nextval, '컴퓨터',1200000,sysdate);  --seq:50

insert into pd_temp1(no, pdname, price, regdate)
values(pd_temp1_seq.nextval, '노트북',1500000,sysdate);  --seq:51

select * from pd_temp1;
select pd_temp1_seq.currval from dual;  --현재 시퀀스 번호 조회 : 51
select pd_temp1_seq.nextval from dual;  --다음 시퀀스 번호 조회 : 52
-->값이 증가되어 버림 => 이후 사용하면 그 다음값(53)부터 처리됨

insert into pd_temp1(no, pdname, price, regdate)
values(pd_temp1_seq.nextval, '모니터',200000,sysdate);  --seq:53

select * from pd_temp1;

create table pd2
(
    no  number primary key,
    pdcode  char(3) not null,
    pdname  varchar2(100),
    price   number(10)  check(price>=0),
    company varchar2(100),
    regdate date default sysdate
);

--1부터 시작해서 1씩 증가하는 시퀀스 객체 생성
create sequence pd2_seq
start with 1
increment by 1
nocache;

--데이터 입력
insert into pd2(no, pdcode, pdname, price, company)
values(pd2_seq.nextval, 'A01','삼성노트북',2500000,'삼성');

insert into pd2(no, pdcode, pdname, price)
values(pd2_seq.nextval, 'B01','키보드',37000);

select * from pd2;

select * from user_sequences;

create sequence test_seq
increment by 1
start with 1
nocache;

--시퀀스 삭제
--drop sequence 시퀀스명;
drop sequence test_seq;

--index
/*
    - 테이블의 데이터를 빨리 찾기 위한 꼬리표
    - 인덱스가 없다면 특정한 값을 찾기 위해 모든 데이터 페이지를 다 뒤져야 함
      (table full scan)
    - index seek
      인덱스를 사용하는 것이 더 효과적이라면, 오라클은 모든 페이지를 뒤지지 
      않고 인덱스 페이지를 찾아서 쉽게 데이터를 가져옴
    - 한 테이블에 여러 개의 인덱스를 생성할 수 있음
    
    create [unique] index 인덱스명
    on 테이블명(컬럼명1, 컬럼명2, ...)    
*/
--primary key나 unique 제약조건을 주면 자동으로 unique index가 생성됨

select * from pd2;

--상품코드 인덱스 만들기
create unique index idx_pd2_pdcode
on pd2(pdcode);

--상품명 인덱스
create index idx_pd2_pdname
on pd2(pdname);

--상품등록일, 회사 복합 인덱스
create index idx_pd2_regdate_company
on pd2(regdate, company);

--인덱스 조회
select * from user_indexes
where table_name='PD2';
select * from user_ind_columns
where table_name='PD2';
select * from user_constraints
where table_name='PD2';

--인덱스를 이용한 조회
select * from pd2
where pdcode='B01';
select * from pd2
where pdname='키보드';
select * from pd2
where regdate>='2023-05-04' and company='삼성';

--인덱스 삭제
--drop index 인덱스명;
create index idx_pd2_company
on pd2(company);

drop index idx_pd2_company;

select * from user_indexes
where table_name='PD2';

--실습
/*
    1. employees 테이블을 이용하여 employees_temp1 테이블 생성
    2. employee_id에 일련번호가 기본키로 들어가도록 sequence 생성
        기존 데이터에 이어서 다음 값이 들어가도록
    3. 임의의 데이터 2건 insert - sequence 이용할 것
    4. last_name에 인덱스 생성
    5. email에 인덱스 생성
    6. job_id, hire_date에 복합 인덱스 생성
    7. 생성한 인덱스를 이용하여 select    
*/
select * from employees;

-- 1. employees 테이블을 이용하여 employees_temp1 테이블 생성
   create table employees_temp1
   as
   select * from employees;
   
   -- 2. employee_id에 일련번호가 기본키로 들어가도록 sequence 생성
   --기존 데이터에 이어서 다음 값이 들어가도록
   select * from employees_temp1;
   
   create sequence employees_temp1_seq
   increment by 1
   start with 207
   nocache;
   
   -- 3. 임의의 데이터 2건 insert - sequence 이용할 것
   select * from employees_temp1;
   desc employees_temp1;
   
   insert into employees_temp1(employee_id,first_name,last_name,email,phone_number,
   hire_date,job_id)
   values(employees_temp1_seq.nextval,'jerry','queen','jerry','515.23.454',
   sysdate,'IT_PROG');
   
   insert into employees_temp1(employee_id,first_name,last_name,email,phone_number,hire_date,job_id)
   values(employees_temp1_seq.nextval,'kai','sa','kia','515.234.454',sysdate,'IT_PROG');
   
   -- 4. last_name에 인덱스 생성
   create index idx_employees_temp1_last_name
   on employees_temp1(last_name);
   
   -- 5. email에 인덱스 생성
   create unique index idx_employees_temp1_email
   on employees_temp1(email);
   
   -- 6. job_id, hire_date에 복합 인덱스 생성
   create index idx_employees_temp1_job_hire
   on employees_temp1(job_id,hire_date);
   
   select * from user_indexes
   where table_name='EMPLOYEES_TEMP1';
   
   -- 7. 생성한 인덱스를 이용하여 select    
    select * from employees_temp1
    where last_name = 'queen';
    
    select * from employees_temp1
    where email = 'kia';
    
    select * from employees_temp1
    where job_id = 'IT_PROG' and hire_date >= '2022-09-15';
    
    
--뷰(view)
/*
    - view는 테이블에 있는 데이터를 보여주는 형식을 정의하는
      select문장의 덩어리하고 할 수 있다
      
    - view는 실제로 데이터를 가지고 있지는 않지만,
      뷰를 통해 데이터를 조회할 수 있고, 또 데이터를 입력,수정,삭제할 수 있으며
      다른 테이블과 조인도 할 수 있기 때문에 
      가상의 논리적 테이블이라고 함
      
    create [or replace] view 뷰이름
    as
    select문장;    
*/
--뷰를 사용하는 목적
--1) 보안성
--2) 편의성

--scott 사용자는 emp의 영업부(deptno=30) 사원들의 기본정보(이름, job, 입사일)를
-- 검색할 수 있어야 한다면..

--hr사용자가 emp테이블의 일부 컬럼만 볼 수 있는 뷰를 만들어서
--scott사용자가 해당 뷰를 볼 수 있게 한다

--1) hr계정에게 뷰 생성 권한을 부여해야 함
--sys 관리자 계정에서 권한 부여를 해야 함
--grant create view to hr;

--view 생성권한 제거하기
--revoke create view from hr;

--2) hr사용자가 view를 만든다
create or replace view v_emp
as
select ename,job, hiredate
from emp
where deptno=30;

--select * from 테이블 또는 뷰
--생성한 뷰 조회하기
select * from v_emp;

--3) scott에게 해당 뷰를 select할 수 있는 권한을 부여한다

/*
    - sys계정에서 scott 사용자 계정 만들기
    oracle 12c부터 계정을 생성할 때,  'c##계정이름'  이런식으로 생성해야한다. 
    따라서 18c에서 부터는 저런식으로 사용하지 않기 위해서 세션을 설정해준다
    alter session set "_ORACLE_SCRIPT"=true; 

    create user scott
    identified by scott123
    default tablespace users;
    
    - 권한 부여하기
    grant resource, connect to scott;     
*/

grant select on v_emp to scott;  --hr계정의 뷰이므로 select 권한 부여가 가능

--권한제거
--revoke select on v_emp from scott;

--scott계정에서 뷰 select하기
select * from hr.v_emp; --스키마이름.데이터베이스 오브젝트명

--뷰 변경하기
--scott사용자가 research부서의 사원정보도 조회해야 한다면
select * from emp;
select * from dept;  --20, 30

create or replace view v_emp
as
select ename, job, hiredate
from emp
where deptno in(20,30);

select * from v_emp;

select ename, job, hiredate, deptno
from emp
where deptno in(20,30);


--영업부, research 부에 속하는  사원들 중에 1982년 이전에 입사한 사람의 정보를 조회하려면
--1) emp 테이블 이용
select * from emp
where deptno in (20,30) and hiredate<'1982-01-01';

--2) v_emp 뷰 이용
select * from v_emp
where hiredate<'1982-01-01';


--조인을 이용하는 경우나 복잡한 쿼리문의 경우 뷰를 만들어서 사용
--employees, departments join
create or replace view v_employees
as
select e.EMPLOYEE_ID, e.FIRST_NAME || '-' || e.LAST_NAME 이름,
    e.HIRE_DATE, e.DEPARTMENT_ID, d.DEPARTMENT_NAME,
    e.SALARY+e.SALARY*nvl(e.COMMISSION_PCT,0) 급여
from employees e left join departments d
on e.DEPARTMENT_ID=d.DEPARTMENT_ID;

select * from v_employees;

--해당 뷰에서 급여가 10000이상인 사원 조회하기
select * from v_employees
where 급여>=10000;

select * 
from 
(
    select e.EMPLOYEE_ID, e.FIRST_NAME || '-' || e.LAST_NAME 이름,
        e.HIRE_DATE, e.DEPARTMENT_ID, d.DEPARTMENT_NAME,
        e.SALARY+e.SALARY*nvl(e.COMMISSION_PCT,0) 급여
    from employees e left join departments d
    on e.DEPARTMENT_ID=d.DEPARTMENT_ID
)
where 급여>=10000;


--gogak 테이블에서 고객 정보와 고객의 성별, 나이 정보를 view로 만들기
--v_gogak_info
create or replace view v_gogak_info
as
select gno, gname, jumin,
    case when substr(jumin,7,1) in('1','3') then '남'
         else '여' end "성별",
    extract(year from sysdate) 
        - (substr(jumin,1,2) +  case when substr(jumin,7,1) in ('1','2') then 1900
                                     else 2000 end) + 1 "나이"     
from gogak;

--해당 뷰를 이용하여 20대, 30대 여자만 조회하기
select * 
from v_gogak_info
where trunc(나이, -1) in (20,30) and 성별='여';

--cf. inline 뷰 이용
select * 
from
(
    select gno, gname, jumin,
        case when substr(jumin,7,1) in('1','3') then '남'
             else '여' end "성별",
        extract(year from sysdate) 
            - (substr(jumin,1,2) +  case when substr(jumin,7,1) in ('1','2') then 1900
                                     else 2000 end) + 1 "나이"     
    from gogak
)
where trunc(나이, -1) in (20,30) and 성별='여';


--뷰를 통한 데이터 수정
/*
    1. updatable view - 뷰를 통한 조회도 가능하고, 입력,수정,삭제도 가능함
    2. read only view - 조회만 가능한 뷰
*/

--updatable view만들기
/*
    create or replace view 뷰이름
    as 
        select문;
*/

--read only view만들기
/*
    create or replace view 뷰이름
    as 
        select문
    with read only;
*/
create or replace view v_emp_readonly
as
select ename, job, hiredate
from emp
where deptno in(20,30)
with read only;

select * from v_emp_readonly; --read only view
select * from v_emp; --updatable view
select * from emp;

update v_emp_readonly
set ename='SMITH2'
where ename='SMITH'; --ERROR:읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.

update v_emp
set ename='SMITH2'
WHERE ename='SMITH';  --updatable view는 입력,수정,삭제 가능

select * from emp;
select * from v_emp;

insert into v_emp(ename, job, hiredate)
values('홍길동','CLERK',sysdate); --error:NULL을 EMPNO안에 삽입할 수 없습니다
-->뷰를 통한 입력을 하는 경우, 뷰에 없는 컬럼은 null을 허용하거나 default값이 있어야 함
--그렇지 않으면 에러 발생

desc emp;

create or replace view v_emp_2
as
select empno, ename, job, hiredate
from emp
where deptno in(20,30);

insert into v_emp_2(empno, ename, job, hiredate)
values(9999,'홍길동','CLERK',sysdate);  --입력가능
--뷰의 조건을 벗어나는 범위이지만 입력가능함 

select * from v_emp_2
where empno=9999;  --입력은 되었지만 뷰의 조건을 벗어나므로, 뷰에서는 조회불가

select * from emp
where empno=9999;  --테이블에서는 조회 가능

delete from v_emp_2
where empno=9999;  --뷰의 조건을 벗어나므로, 조회도 안되고 삭제도 안됨

select * from emp
where empno=8888;
delete from emp
where empno=8888;


/*
    기본적으로 뷰를 만들때 뷰의 조건을 벗어나는 범위로 데이터를 수정할 수 있으며
    이를 허용하지 않고자 할때는 with check option을 사용
*/


