--1강_select기본.sql

--한줄 주석
/*
여러 줄 주석
*/

/*
    sqlplus (쿼리 작성 툴) 사용시 해당 계정에 연결하는 방법
    [1] sqlplus 들어가기 전
    sqlplus 아이디/비밀번호
    예) sqlplus hr/hr123
        sqlplus sys/123$ as sysdba
        sqlplus / as sysdba
    
    [2] sqlplus 들어간 후
    conn 아이디/비밀번호
    예) conn hr/hr123
        conn sys/123$ as sysdba
        conn / as sysdba
        
    ※ 오라클 설치 후 사용자 sample 계정에 들어가려면 lock을 풀고 사용해야 함
    sys계정으로 접속한 후
    
    - hr 계정의 lock 풀기
    alter user hr account unlock;
    
    - hr 계정의 비밀번호 변경하기
    alter user hr identified by hr123;
    => hr 계정의 비밀번호를 hr123으로 변경한다
    
    ※ sqlplus에서 접속한 계정을 확인하려면
    show user        
*/
select * from tab; --해당 계정의 테이블 목록 조회

desc job_history;



--테이블간의 관계
--부모 테이블의 기본키(primary key)는 
--자식 테이블의 foreign key(참조키, 외래키)로 전이된다.

--기본키(primary key) - 각 레코드를 유일하게 구별할 수 있는 컬럼
--foreign key - 다른 테이블을 참조할 때 사용하는 컬럼

select * from employees;
select * from jobs;
select * from departments;
select * from locations;
select * from countries;
select * from regions;
select * from job_history
order by employee_id;

--데이터 조회하기
--select 컬럼명, 컬럼명, 컬럼명... from 테이블명;

--1. 모든 컬럼 조회하기
--select * from 테이블명;

--employees 테이블에서 모든 컬럼 조회하기
select * from employees;

SELECT * FROM EMPLOYEES; --대소문자 구분 안함 / 단, 데이터는 대소문자 구분함

--2. 일부 컬럼만 조회하기
--select 컬럼명1, 컬럼명2, ...from 테이블명;

--employees 테이블에서 사원아이디, 이름, 입사일, 급여 조회하기
select employee_id, first_name, hire_date, salary from employees;

--3. 표현식을 사용하여 출력하기
select first_name, '님 환영합니다' from employees;

/*
표현식 (literal상수, 문자)
- 컬럼 이름 이외에 출력하기를 원하는 내용을 의미
select 구분 뒤에 '(홑따옴표)로 묶어서 사용
*/

--4. 컬럼 별칭 사용하여 출력하기
/*
컬럼명 뒤에 as "별칭" (공백이나 일부 특수기호가 있으면 반드시 ""로 묶어줘야 함)
또는 컬럼명 뒤에 "별칭"
또는 컬럼명 뒤에 별칭

- 원래 테이블의 컬럼명이 변경된 것이 아니라
출력될 때 임시로 바꾸어서 보여주는 것 */
select first_name; '님 환영합니다' as "인사말"
from employees;

select employee_id as "사원 아이디", first_name 이름,
    last_name 성, phone_number "전화번호", salary "급여"
from employees;

--5. distinct - 중복된 값을 제거하고 출력하기
select * from emp;

select deptno from emp;

select distinct deptno from emp; --중복 데이터 제거됨

select deptno, job from emp
order by deptno, job;

select distinct deptno, job from emp
order by deptno, job; --distinct 키워드는 1개의 컬럼에만 적어도 모든 컬럼에 적용됨

--6. 연결 연산자 ||
select * from professor;

select name, position from professor;
select name || ' ' || position as "교수 이름"
from professor;

--7. 산술 연산자 사용하기 +,-,*,/
select ename, sal, comm, sal + 100, sal + comm, sal + 100/2, (sal + 100)/2
from emp;

select first_name, salary, commission_pct,
    salary + salary * commission_pct
    from employees;
    
select 100 * 0.3, 200 - 60, 100 + null, 20 * null from dual;
--오라클은 select 절과 from 절이 필수이며 from 절 생략 불가,
--뒤에 가상 테이블 dual을 써준다


--null : 존재하지 않는다는 것
--null에 연산을 하더라도 결과는 null

select * from dual;
desc dual;



--실습 - dept2 테이블을 사용하여 dcode를 부서#, dname을 부서명, area를 위치로 별명을 
--설정하여 출력하기
select * from dept2;
select dcode as "#", dname 부서명, area 위치 from dept2;


--실습 - student 테이블을 사용하여 모든 학생들이 '서진수의 키는 180 cm, 
--몸무게는 55kg 입니다' 와 같은 형식으로 출력되도록 리터럴 문자를 추가하고, 
--칼럼이름은 "학생의 키와 몸무게"라는 별명으로 출력하기
select * from student;
select name, '의 키는 ' || height || 'cm, 몸무게는 ' || weight || '입니다' 
from student;

--8. 조건에 맞는 데이터 조회하기
/*
    select 컬럼명 from 테이블명
    where 조건;
*/
--emp 테이블에서 10번 부서에 근무하는 사원의 이름과 급여, 부서번호를 출력
select * from emp;

select ename, sal, deptno
from emp
where deptno = 10;

--emp 테이블에서 급여(sal)가 4000보다 큰 사람의 이름과 급여를 출력
select ename, empno, sal
from emp
where sal > 4000;

--emp 테이블에서 이름이 scott인 사람의 이름과 사원번호, 급여를 출력
select ename, empno, sal
from emp
where ename = 'SCOTT';


--문자열과 날짜는 '(작은 따옴표)로 감싸주어야 함
--professor 테이블에서 입사일이 1987-01-30 인 레코드 조회하기
select * from professor
where hiredate = '1987-01-30';

--또는
select * from professor
where hiredate = '1987/01/30';


--9. 조건에서 다양한 연산자 이용
/*
    비교연산자  =,!=, >,<,>=,<=
    논리연산자  and, or, not
    범위연산자  between A and B
    목록연산자   in(A,B,C)
    특정패턴검색  like
*/

--비교 연산자를 사용하여 student 테이블에서 키(height)가 180cm 보다 크거나 같은 사람 출력
select * from student
where height < 180;

--키가 180보다 작은 사람 조회
select * from student
where not (height >= 180);

--[1]between
--Between 연산자를 사용하여 student 테이블에서 몸무게(weight)가 60~80kg 인 사람의 
--이름과 체중 출력
select name, weight from student
where weight between 60 and 80; -- 60 이상 80 이하


--몸무게가 60~80 사이가 아닌 사람 조회
select name, weight from student
where not weight between 60 and 80;


--문자, 날짜도 between을 이용해 범위값을 구할 수 있다
--ename이 B~G 사이인 사람 조회
select * from emp
where ename >= 'B' and ename <= 'G';

--ename이 B~G 사이가 아닌 사람 조회
select * from emp
where ename<'B' or ename>'G';

select * from emp
where ename not between 'B' and 'G';

select * from emp
where ename not between 'B' and 'G';

select ascii('A'), ascii('a'), chr(65), chr(48)
from dual;


--employees에서 입사일이 2005~2006년 사이의 사원 조회
select * from employees
where hire_date between '2005/01/01' and '2006/12/31';

select * from employees
where hire_date >= '2005/01/01' and hire_date <= '2006/12/31';


--student에서 4학년이 아닌 학생들 조회하기
--같지 않다  !=, <>,  ^=
select * from student
where grade != '4';

select * from student
where grade <> '4';

select * from student
where grade ^= '4';


--[2] in
--In 연산자를 사용하여 student 테이블에서 101번 학과 학생과 102번 학과 학생들을 모두 출력
select * from student
where deptno1 in (101, 102);

--학과가 101,102가 아닌 학생 조회
select * from student
where deptno1 != 101 and deptno1 != 102;

select * from student
where deptno1 not in (101, 102); 

select * from student
where not (deptno1 in (101, 102));

--Like 연산자를 사용하여 student 테이블에서 성이 "김"씨인 사람을 조회
select * from student
where name = '김';

select * from student
where name like '김%';

--이름이 수로 끝나는 사람 조회
select * from student
where name like '%수';

--이름에 재가 포함되는 사람 조회
select * from student
where name like '%재%';


/*
like 와 함께 사용되는 기호 : %   _
% : 글자수 제한 없고 어떤 글자가 와도 됨
_ : 글자수는 한 글자만 올 수 있고, 어떤 글자가 와도 됨
*/

--id에 in이 포함된 것
select * from student
where id like '%in%';

--in앞에 한글자 , in 뒤에 두 글자가 오는 것만 조회
select * from student
where id like '_in__';

--employees에서 job_id가 AD_PRES 인 것 조회
select * from employees
where job_id like 'AD_PRES';

--employees에서 job_id가 PR이 포함된 것 조회
select * from employees
where job_id like '%PR%';

--employees에서 job_id가 PR_ 가 포함된 것 조회
select * from employees
where job_id like '%PR\_%' escape '\'; 

select * from employees
where job_id like '%PR@_%' escape '@';

select * from employees
where job_id like '%PR*_%' escape '*';


--student에서 이름이 김재수인 사람 조회
select * from student
where name like '김재수';

--성이 김씨보다 크거나 같은 사람 조회
select * from student
where name >= '김%';

/*
null :  오라클의 데이터 종류 중 한가지로 어떤 값인지 모른다는 의미
        데이터가 없음을 의미함, 아직 정의되지 않은 미지의 값
- null에는 어떤 연산을 수행해도 결과값은 항상 null이 나옴

- null 값은 '=' 연산을 사용할 수 없음
=> is null, is not null을 이용해야 함        
*/

--professor에서 bonus가 null인 데이터 조회
select * from professor
where bonus is null;

--null이 아닌 데이터 조회
select * from professor
where bonus not null

--검색 조건이 2개 이상인 경우
--논리 연산자 우선순위 : () > not > and > or

--student 테이블을 사용하여 4학년 중에서 키가 170cm 이상인 사람의 이름과 학년, 
--키를 조회
select name, grade, height from student
where grade = 4 and height >= 170;

--student 테이블을 사용하여 1학년이거나 또는 몸무게가 80kg 이상인 학생들의 이름과 학년, 
--키, 몸무게를 조회
select name, grade, height, weight from student
where grade = 2 and weight >= 80;

--student 테이블을 사용하여 2학년 중에서 키가 180cm 보다 크면서 몸무게가 70kg 보다 
--큰 학생들의 이름과 학년, 키와 몸무게를 조회
select name, grade, height, weight from student
where grade = 2 and height > 180 and weight >= 70;

--student 테이블을 사용하여 2학년 학생 중에서 키가 180cm 보다 크거나 
--또는 몸무게가 70kg 보다 큰 학생들의 이름과 학년, 키, 몸무게를 조회
select * from student
where grade = '2' and (height >'180' or weight > '70');


--실습> professor 테이블에서 교수들의 이름을 조회하여 성 부분에 'ㅈ'이 포함된 사람의 명단을 출력


--[10] order by 절을 사용하여 출력결과 정렬하기
/*
오름차순 정렬(기본값) : asc
내림차순 정렬 : desc
sql 문장의 가장 마지막에 적어야 함

오름차순 => order by 컬럼명 
내림차순 => order by 컬럼명 desc
*/

--student 테이블을 사용하여 1학년 학생의 이름과  키를 출력. 단, 키가 작은 순서대로 출력
select name, height 
from student
where grade = 1
order by height;

--또는
select name, height 
from student
where grade = 1
order by height asc;

--키가 큰 순서
select name, height
from student
where grade = 1
order by height desc;



--student 테이블을 사용하여 1학년 학생의 이름과  키, 몸무게를 출력. 
--단, 키는 작은 순서대로 출력하고 몸무게는 많은 사람부터 출력
select name, height, weight from student
--where grade = 1
order by height, weight desc;

--student 테이블을 사용하여 1학년 학생의 이름과  생일, 키, 몸무게를 출력. 
--단, 생일이 빠른 사람 순서대로 정렬
select name, birthday, height, weight from student
where grade = 1
order by birthday;

--student 테이블을 사용하여 1학년 학생의 이름과  키를 출력. 
--단, 이름을 오름차순으로 정렬
--이름, 키 별칭 지정하기
select name as "이름", height 키 from student
where grade = 1
order by "이름"; --별칭을 사용해서 정령 가능

--실습]employees 테이블에서 사원아이디, 이름 - 성(예 : Steven-King), 입사일, 기본급(salary), 
--수당(salary*commission_pct), 급여(salary+수당) 조회하기
--모든 컬럼은 별칭을 사용한다
--입사일이 2005년 이후인 사원만 조회
--기본급이 많은 사람 순으로 정렬
select * from employees;
select employee_id as "사원아이디", last_name 성, hire_date 입사일, salary 기본급,
salary*commission_pct 수당, salary+commission_pct 급여 from employees
where "입사일" = '2005/01/01'
order by "기본급";




/*
※ 집합 연산자

union - 두 집합을 더해서 결과를 출력, 중복제거, 정렬해줌 (합집합)
union all - 두 집합을 더해서 결과를 출력, 중복제거하지 않고, 정렬해주지 않음
intersect - 두 집합의 교집합 결과를 출력, 정렬해줌
minus - 두 집합의 차집합 결과를 출력, 정렬해줌

=> 집합 연산자 사용시 주의사항
1) 컬럼의 개수가 일치해야 함
2) 컬럼의 자료형이 일치해야 함
(컬럼명은 달라도 상관 없음)
*/
--set1 테이블과 set2 테이블 union


--union all



--학과가 101인 교수와 학생 명단 조회하기


--set1, set2 intersect


/*
set1 => AAA,AAA,BBB
set2 => BBB,CCC,CCC
*/



/*
product 테이블의 모든 컬럼 가져오기
dept  테이블의 모든 컬럼 가져오기
student 테이블에서 일부 컬럼만 가져오기
  -ID,NAME, BIRTHDAY 
  -name 을 ‘학생 이름’으로 컬럼 제목 바꾸기

1. professor 테이블의 모든 컬럼을 조회하는데, name 내림차순으로 조회하기
조건 : position 이 ‘조교수’ 인 것만 조회
2. department 테이블에서 deptno, dname, build 컬럼만 조회
조건 : 학과(dname)에 ‘공학’이라는 단어가 들어간 학과만을 조회하기
정렬 : dname 순으로 오름차순으로 정렬
3. emp2 테이블에서 name, emp_type, tel, pay, position 컬럼만 조회하되, position 컬럼은 컬럼제목을 ‘직위’로 나타내고
조건 : pay가 3000만원에서 5000만원인 것들만 조회하기

4. emp2 테이블에서 name, emp_type, tel, birthday 컬럼만 조회하되, 다음 조건에 맞는 데이터만 조회
조건 : 생일(birthday)가 1980년도 인 것들만 조회하기(between 이용)

5. gift 테이블에서 모든 컬럼을 조회하되
조건 : gname에 ‘세트’라는 단어가 들어간 레코드만 조회하기

6. emp2 테이블에서 name, position, hobby, birthday 컬럼을 조회하되
조건 : position 이 null 이 아닌 것만 조회
생일(birthday) 순으로 오름차순으로 정렬

7. emp2 테이블에서 모든 컬럼을 조회하되
조건 : emp_type이 ‘정규직’이거나 ‘계약직’인 것만 조회(in 이용)

8. emp2 테이블에서 emp_type, position 컬럼을 조회하되
중복된 행(레코드)은 제거
*/

