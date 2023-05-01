--6강_insert.sql
--[2023-05-01]
--1. insert문 - 데이터를 입력하는 DML
/*
    [1] 단일행 입력하기
    insert into 테이블명(컬럼1, 컬럼2, ...)
    values(값1, 값2, ...);
*/

/*
예1) dept2 테이블에 아래의 새로운 부서 정보를 입력하시오
부서번호 : 9000, 부서명: 특판1팀
상위부서 : 1006 (영업부), 지역 : 임시지역
*/
select * from dept2
order by dcode desc;

insert into dept2(dcode, dname, pdept, area)
values('9000', '특판1팀', '1006', '임시지역');

insert into dept2(dname, dcode, area,  pdept)
values('특판2팀',9001, '임시지역',  1006); --지정한 컬럼 순서대로 입력

--일부 컬럼만 입력하는 경우 - not null인 컬럼은 반드시 값을 입력해야 함
insert into dept2(dcode, dname)
values(9003, '특판3팀');

insert into dept2(dcode, pdept)
values(9004, 1006); --error:NULL을 DNAME 안에 삽입할 수 없습니다
--dname이 not null인데 값을 입력하지 않아서 에러 발생

desc dept2;

--모든 컬럼의 데이터를 입력하는 경우 => 컬럼명 생략 가능
insert into dept2
values(9002,'특판4팀',1006, '임시지역');

select * from dept2
order by dcode desc;


--null 입력하기
/*
1) 데이터를 입력하지 않으면 null 이 입력됨
2) 직접 null을 입력해도 null이 입력됨
*/
select * from dept2 
order by dcode desc;

insert into dept2(dcode, dname, pdept)
values(9004, '특판5팀', null);

--예3) 날짜 데이터 입력하기
/*
아래 정보를 professor 테이블에 입력하시오
교수번호 : 5001, 교수이름: 김설희
ID : kimsh, Position : 정교수
Pay : 510, 입사일 : 2013년 2월 19일
*/
select * from professor;

insert into professor(profno, name, id, position, pay, hiredate)
values(5001,'김설희','kimsh', '정교수',510,'2013-02-19');

desc professor;

--[2] 여러 행 입력하기
/*
    insert into 테이블명(컬럼1, 컬럼2, ...)
    select문
    
    => select문의 컬럼의 개수와 데이터 타입이 일치해야 입력 가능함
*/

select * from pd
order by no desc;

select * from product;

insert into pd(no, pdname, price, regdate)
select p_code, p_name, p_price, sysdate
from product
where p_code in (102,103,104);

commit;

/*
※ 트랜잭션(Transaction)
-은행에서 계좌 입,출금(송금)과 같은 개념
-은행에서는 송금 자체를 하나의 트랜잭션(거래)로 보고 A통장에서 출금한 돈이 
B통장에 정확히 입금이 확인되면 그 때 거래를 성사시킴(commit)
네트워크 장애로 인해 출금만 발생하고 입금이 되지 않았을 경우에는 
이를 모두 취소(rollback)하게 됨

Transaction
-논리적인 작업 단위
-여러 가지 DML 작업들을 하나의 단위로 묶어 둔 것
-해당 트랜잭션 내에 있는 모든 DML이 성공해야 해당 트랜잭션이 성공하는 것이고 
만약 1개의 DML이라도 실패하면 전체가 실패하게 됨

commit - 트랜잭션 내의 작업의 결과를 확정하는 명령어
         메모리 상에서 변경된 내용을 데이터 파일에 반영.
Rollback - 트랜잭션 내의 모든 명령어들을 취소하는 명령어
         메모리 상에서 변경된 내용을 데이터 파일에 반영하지 않고 종료.
*/

--[3] 테이블을 생성하면서 데이터 입력하기
/*
    create table 신규 테이블명
    as
    select 선택컬럼1, 선택컬럼2, ...from 기존 테이블명;
    
    - 신규 테이블을 만들고 동시에 다른 테이블에서 select된 컬럼과 결과 데이터를
      insert시킴
    - select문의 테이블과 컬럼의 제약조건은 복제되지 않기 때문에 신규 테이블에
      대해 테이블과 컬럼 제약조건을 정의해야 함
      pk(primary key)값도 생성하지 않음   
*/
create table professor2  --professor2 테이블이 생성됨
as
select * from professor;

select * from professor2;

desc professor;
desc professor2;

--employees, departments 테이블을 조인한 결과를 imsi_tbl을 만들면서 입력
create table imsi_tbl
as
select e.EMPLOYEE_ID, e.FIRST_NAME || '-' || e.LAST_NAME as Name,
    e.HIRE_DATE, nvl2(e.COMMISSION_PCT, salary+salary*e.commission_pct, salary) as Pay,
    e.DEPARTMENT_ID, d.DEPARTMENT_NAME
from employees e join departments d
on e.DEPARTMENT_ID=d.DEPARTMENT_ID;

select * from imsi_tbl;
/*
=> insert문에 컬럼 리스트가 없는 상태에서 select문 컬럼 리스트에 함수가 
적용됐다면 별칭을 써서 insert되는 데이터의 컬럼명을 지정해줘야 함
그렇지 않으면 에러
*/

create table imsi_tbl2(emp_id, name, hiredate, pay, dept_id, dept_name)
as
select e.EMPLOYEE_ID, e.FIRST_NAME || '-' || e.LAST_NAME,
    e.HIRE_DATE, nvl2(e.COMMISSION_PCT, salary+salary*e.commission_pct, salary),
    e.DEPARTMENT_ID, d.DEPARTMENT_NAME
from employees e join departments d
on e.DEPARTMENT_ID=d.DEPARTMENT_ID;

select * from imsi_tbl2;

/*
=> create table에서 컬럼명을 지정하면
신규 테이블에 컬럼 리스트가 정의되면서 select문을 통해 필요한 데이터가 
insert됨
*/

--2. update문
--기존 데이터를 다른 데이터로 변경할 때 사용하는 방법
/*
    update 테이블
    set 컬럼명1=값1, 컬럼명2=값2, ... 
    where 조건
*/

--[1] update
--예1) Professor 테이블에서 직급이 조교수인 교수들의 bonus를 100만원으로 인상하시오
select * from professor
where position ='조교수';

update professor
set bonus=100
where position ='조교수';

rollback;

--예2) student 테이블에서  4학년 '김재수' 학생의 2전공(deptno2)을 101로, 
-- weight를 80으로 수정하시오.
select * from student
where grade=4 and name='김재수';

update student
set deptno2=101, weight=80
where grade=4 and name='김재수';

rollback;

--예3) Professor 테이블에서  차범철교수의 직급과 동일한 직급을 가진 교수들 
--중 현재 급여가 250만원이 안 되는 교수들의 급여를 15% 인상하시오.
select * from professor
where position = (select position from professor where name='차범철')
and pay < 250;

update professor
set pay=pay*1.15
where position = (select position from professor where name='차범철')
and pay < 250;

rollback;

--[2] 다중건의 update - 서브쿼리를 이용한 update
/*
    서브쿼리를 사용하면 한 번의 update명령으로 여러 개의 컬럼을 수정할 수 있다
    여러 컬럼을 서브쿼리의 결과로 update하면 된다.
    
    다중건의 update를 하기 위해서는 기본적인 update문의 폼을 사용하고
    subquery로 추출한 데이터를 setting하려는 컬럼의 데이터값으로 사용함
*/
--1) EMP01 테이블의 사원번호가 7844인 사원의 부서번호와 직무(JOB)를 
--사원번호가 7782인 사원과 같은 직무와 같은 부서로 배정하라                 

--cf. 다중컬럼 서브쿼리
--학년별 최대키를 갖는 학생의 정보 조회
select grade, height, studno, name from student
where (grade, height) in (select grade, max(height) from student 
                            group by grade);
                            
--1) 7782번의 job, deptno 구하기
select job, deptno from emp
where empno=7782;  --MANAGER, 10

--2) 7844의 정보 update
select * from emp
where empno=7844;

/*
update emp
set job='MANAGER', deptno=10
where empno=7844;
*/

--subquery 이용
update emp
set (job, deptno) = (select job, deptno from emp
                        where empno=7782)
where empno=7844;

select * from emp
where empno=7844;

rollback;

--[3] exists를 이용한 다중 건의 update
/*
    - 서브쿼리의 컬럼값이 존재하는지 여부를 체크
    - 존재여부만 체크하기 때문에 존재하면 true, 존재하지 않으면 false를 리턴함
    - true가 리턴되면 set컬럼의 update를 진행시키고
      false가 리턴되면 update는 진행되지 않음
*/ 
select * from panmae
order by p_code desc;

select * from product;

--삭제된 코드가 panmae 테이블에 있다면 새 코드로 update하기
select * from panmae a
where exists ( select 1 from product b
                where b.p_code = a.p_code
                and b.del_yn = 'Y');

update panmae a
set p_code=(select p_code_new from product b
            where b.p_code=a.p_code and del_yn='Y')
where exists ( select 1 from product b
                where b.p_code = a.p_code
                and b.del_yn = 'Y');

select * from panmae
order by p_code desc;
 
select * from product;

rollback;
 
--emp에서 comm은 기존값보다 100인상하고,
--sal은 job이 CLERK이면 2배, MANAGER이면 3배, 나머지는 4배로 수정하시오
select * from emp;

update emp
set comm=comm+100, sal=case job when 'CLERK' then sal*2
                                when 'MANAGER' then sal*3
                                else sal*4 
                                end; 

rollback;

--employees에서 직원번호가 100인 직원의 job_id를 IT_PROG로 수정
select * from employees
where employee_id=100;

update employees
set job_id='IT_PROG'
where employee_id=100;

rollback;

/*
select * from job_history where job_id='IT_PROG';

select * from user_constraints
where constraint_name='JHIST_EMP_ID_ST_DATE_PK';

select * from user_triggers;

desc job_history;
*/

--employees에서 직원번호가 100인 직원의 job_id를 직원번호가 101인
--job_id로 수정

select job_id from employees
where employee_id=101;  --AD_VP

update employees
set job_id=(select job_id from employees
                where employee_id=101)
where employee_id=100;

rollback;

--3. delete문 - 삭제
/*
    delete from 테이블
    where 조건
*/

--예1) dept2 테이블에서 부서번호(dcode)가 9000번에서 9100번 사이인 매장들을 삭제하시오
select * from dept2
where dcode between 9000 and 9100;

delete from dept2
where dcode between 9000 and 9100;

rollback;
commit;

--delete문에서 서브쿼리 이용
--단일행
--departments에서 10번 부서의 부서장을 employees에서 삭제
select * from departments;
select * from employees;

select manager_id from departments
where department_id=10;  --200

select * from employees
where employee_id=(select manager_id from departments
                    where department_id=10);
                    
delete from employees
where employee_id=(select manager_id from departments
                    where department_id=10); --자식 레코드 발견-무결성제약조건 위반

--                                       
create table new_employees
as
select * from employees;

delete from new_employees
where employee_id=(select manager_id from departments
                    where department_id=10); 
                    
select * from new_employees
where employee_id=200;

rollback;

--다중 행
--departments에서 location_id가 1700인 사원들 삭제 - employees에서 삭제
select department_id from departments
where location_id=1700;

select * from new_employees
where department_id in (select department_id from departments
                        where location_id=1700);
                        
delete from new_employees
where department_id in (select department_id from departments
                        where location_id=1700);
                        
rollback;

select * from new_employees a
where exists (select 1 from departments b
                        where b.department_id=a.DEPARTMENT_ID 
                         and location_id=1700);

delete from new_employees a
where exists (select 1 from departments b
                        where b.department_id=a.DEPARTMENT_ID 
                         and location_id=1700);
                                                 
--다중컬럼 서브쿼리
--employees에서 직업별 최대급여를 받는 사원 삭제
select * from new_employees 
where (job_id,salary) in (select job_id,max(salary) from new_employees
                            group by job_id);
                 
delete from new_employees 
where (job_id,salary) in (select job_id,max(salary) from new_employees
                            group by job_id);

rollback;
                                             
--상관관계 서브쿼리 예제
--employees에서 자신의 job_id의 평균급여보다 많이 받는 사원 삭제
select * from new_employees a
where salary> (select avg(nvl(salary,0)) from new_employees b
                where b.job_id=a.job_id);

delete from new_employees a
where salary> (select avg(nvl(salary,0)) from new_employees b
                where b.job_id=a.job_id);
      
rollback;
                       
/*
dept => dept01 테이블 만들기
emp => emp01 테이블 만들기
--insert
1) dept01, emp01 테이블에 데이터 입력하기
dept01 테이블에는 모든 칼럼 입력, emp01 테이블에는 일부 칼럼만 입력

--update
1) DEPT01 테이블의 부서번호가 30인 부서의 위치(LOC)를 '부산'으로 수정
2) DEPT01 테이블의 지역을 모두 '서울'로 수정
3) emp01 테이블에서 job이 'MANAGER' 인 사원의 급여(sal)를 10% 인상

--서브쿼리를 이용한 update
1) 사원번호가 7934인 사원의 급여와, 직무를 사원번호가 7654인 사원의 직무와 급여로 수정(emp01 테이블 이용)

--다른 테이블을 참조한 UPDATE
1) DEPT01 테이블에서 부서이름이 SALES인 데이터를 찾아 그 부서에 해당되는 EMP01 테이블의 사원업무(JOB)를
 'SALSEMAN'으로 수정
2) DEPT01 테이블의 위치(loc)가  'DALLAS'인 데이터를 찾아 
그 부서에 해당하는 EMP01 테이블의 사원들의 직무(JOB)을 'ANALYST'로 수정
*/
CREATE TABLE DEPT01
AS
SELECT * FROM DEPT;

CREATE TABLE EMP01
AS
SELECT * FROM EMP;

SELECT * FROM EMP01;
SELECT * FROM DEPT01;

insert into dept01
values(50, '관리부','대전');

insert into emp01(empno, ename, job,  sal, deptno)
values(9992, '김길동', 'CLERK', 3500, 10);

desc emp01;


    UPDATE DEPT01
    SET LOC='부산' 
    WHERE DEPTNO=30;

    UPDATE DEPT1
    SET LOC = '서울';

	UPDATE EMP01
    SET sal = sal*1.1
    WHERE job = 'MANAGER';

	UPDATE EMP01
    SET (JOB, SAL) = (SELECT JOB, SAL FROM EMP01
                       WHERE EMPNO = 7654)
    WHERE EMPNO = 7934;

	UPDATE EMP01
    SET JOB='SALESMAN' 
    WHERE DEPTNO= (SELECT DEPTNO FROM DEPT01  
                   WHERE DNAME='SALES');

	UPDATE EMP01
    SET JOB = 'ANALYST'
    WHERE DEPTNO = (SELECT DEPTNO
                    FROM DEPT01
                    WHERE loc = 'DALLAS');
                    
                    

--insert all을 이용한 여러 테이블에 여러 행 입력하기
--[1] 다른 테이블에 한꺼번에 데이터 입력하기
select * from p_01;
select * from p_02;

insert all into p_01 values(1,'AA')
           into p_02 values(2, 'BB')
select * from dual;          
    
--[2] 다른 테이블의 데이터를 가져와서 입력하기
/*
Professor 테이블에서 교수번호가 1000번에서 1999번까지인 교수의 번호와 교수이름은 
p_01 테이블에 입력하고, 교수번호가 2000번에서 2999번까지인 교수의 번호와 교수이름은 
p_02 테이블에 입력하시오.
*/
insert all
    when profno between 1000 and 1999 then
        into p_01 values(profno, name)
    when profno between 2000 and 2999 then
        into p_02 values(profno, name)
select profno, name from professor;

select * from p_01;
select * from p_02;

--[3] 다른 테이블에 동시에 같은 데이터 입력하기
--Professor 테이블에서 교수번호가 3000번에서 3999번까지인 교수들의 번호와 교수이름을 
--p_01 테이블과 p_02 테이블에 동시에 입력하시오.
                    
insert all into p_01 values(profno, name)
           into p_02 values(profno, name)
select profno, name from professor
where profno between 3000 and 3999;
            
select * from p_01;
select * from p_02;

/*
-- DELETE
1) EMP01테이블에서 7782의 사원번호인 사원정보를 모두 삭제
2) EMP01테이블에서 직무(JOB)이 'CLERK'인 사원들의 정보를 삭제
3) EMP01테이블의 모든 정보를 삭제 후 rollback

--서브쿼리를 이용한 데이터의 삭제
1) 'ACCOUNTING'부서명에 대한 부서코드를 DEPT01테이블에서 검색한 후 
	해당 부서코드를 가진 사원의 정보를 EMP01테이블에서 삭제
2) DEPT01테이블에서 부서의 위치가 'NEW YORK'인 부서를 찾아 
	EMP01테이블에서 그 부서에 해당하는 사원을 삭제
*/

DELETE FROM EMP01
WHERE EMPNO = 7782;

	DELETE FROM EMP01
    WHERE JOB='CLERK';

	DELETE from EMP01;

    SELECT * FROM EMP01; 

    ROLLBACK;

	DELETE EMP01
    WHERE DEPTNO=(SELECT DEPTNO 
                  	    FROM DEPT01
	                      WHERE DNAME='ACCOUNTING');
      
	DELETE EMP01
    WHERE DEPTNO= (SELECT DEPTNO 
                 		FROM DEPT01
                 		WHERE LOC = 'NEW YORK');
                 		                        	