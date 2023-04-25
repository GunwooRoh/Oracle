--[3강_그룹함수.sql]

--단일행 함수
select birthday, to_char(birthday, 'd'), name, length(name)
from student;

--복수행 함수(그룹함수)
select sum(pay) from professor;
select * from professor;


--count() - 입력되는 데이터의 건수를 리턴하는 함수
--대부분의 그룹함수는 null을 제외하고 계산함
--count(*)만 null 포함


 
--sum() - 합계 구하는 함수
/*
    문자, 날짜는 sum(), avg() 함수를 사용할 수 없다(연산 불가)
    count() 함수는 문자, 날짜에서도 사용 가능
*/
select sum(pay), sum(bonus), count(pay), count(bonus), count(*)
from professor;

select sum(name) from professor; --error
select sum(hiredate) from professor; --error

select count(name), count(hiredate) from professor; --사용가능


--avg() - 평균을 구하는 함수
select avg(pay), sum(pay), count(pay), count(*),
    avg(bonus), sum(bonus), count(bonus),
    sum(bonus)/count(bonus), sum(bonus)/count(*),
    avg(nvl(bonus, 0))
from professor;


/*
    그룹함수는 null을 제외하고 연산하므로 avg()는 정상적인 결과값이 나오지 않음
    => nvl() 함수를 이용하여 처리해야 함
    => avg(nvl(컬럼, 0))
*/

--max() - 최대값을 구하는 함수
--min() - 최소값을 구하는 함수
select may(pay), min(pay), max(bonus), min(bonus)
from professor;


--문자, 날짜도 최대값, 최소값은 구할 수 있다.(대소 비교가 가능하므로)
select max(name), min(name), max(hiredate), min(hiredate)
from professor;


--중복값을 제외한 건수 : count(distinct 컬럼명)
select count(grade), count(*), count(distinct grade)
from student;

select grade from student;
select distinct grade from student;

/*
sum(distinct 컬럼명) - 중복값을 제외한 합계
avg(distinct 컬럼명) - 중복값을 제외한 평균
min(distinct 컬럼명) - 중복값을 제외한 최소값
max(distinct 컬럼명) - 중복값을 제외한 최대값
*/

--그룹별 집계
--Professor 테이블에서 학과별로 교수들의 평균 급여를 출력하시오.
avg (distinct pay)

--group by절에 있는 컬럼과 그룹함수만 select절에 올 수 있다.


--group by
/*
   - 테이블 전체에 대한 집계를 구하는 것이 아니라, 특정 범위에서의 집계 데이터를 구함     
*/
--학과별, 직급별 급여의 평균 구하기
select deptno, position, pay
from professor
order by deptno, position;

select deptno, position, avg(nvl(pay, 0))
from professor
group by deptno, position;

select deptno as dno, position, avg(nvl(pay,0))
from professor
group by dno, position --error
order by dno, position; --order by 절에서 별칭 사용 가능

--부서별 평균급여를 구한 후, 평균 급여가 450 초과인 부서의 부서번호와 평균 급여를 구하시오.
select deptno, position, avg(nvl(pay, 0))
from professor
group by deptno, position
having avg(nvl(pay, 0)) > 450;


/*
    having
    - group by의 결과내에서 특정 조건을 만족하는 것을 구하려면 having을 이용한다
    - group by절에 의해 출력된 결과에 대한 조건을 정의한다.
    - group by된 결과를 제한하고자할 때 사용
    
    group by 컬럼
    having 조건
*/

--Student 테이블에서 grade별로 weight, height의 평균, 최대값 구하기
--위의 결과에서 키의 평균이 170 이하인 경우 구하기
select grade, avg(nvl(weight,0)), avg(nvl(height, 0)), max(weight), max(height)
from student
group by grade
having avg(nvl(height, 0)) <= 170;


--deptno1이 100번대인 학과 학생들에 대해서 학년별 키의 평균 구하고
--그 결과에서 키의 평균이 172 이상인 경우 구하기 
select grade as "학년", avg(nvl(height, 0)) "학년 별 키의 평균"
from student
where deptno1 < 200
group by grade
having avg(nvl(height, 0)) >= 172;

--실습
--1.  emp테이블의 부서별 급여의 총합 구하기.
select deptno as "부서", avg(nvl(sal, 0)) "급여 평균", sum(nvl(sal, 0))
from emp
group by deptno;

select * from emp;
       
--2. emp 테이블의 job별로 급여의 합계 구하기.
select job, sum(sal)
from emp
group by job;

--3. emp 테이블의 job별로 최고 급여 구하기
select job, max(sal)
from emp group by job;

--4. emp 테이블의 job별로 최저 급여 구하기
select job, min(sal)
from emp group by job;


--1. emp 테이블의 job별로 급여의 평균 구하기 - 소수이하 2자리만 표시



--4.  emp2 테이블에서 emp_type별로 pay의 평균을 구한 상태에서 
--평균 연봉이 3천만원 이상인 경우의 emp_type 과 평균 연봉을 읽어오기


--5. emp2의 자료를 이용해서 직급(position)별로 사번(empno)이 제일 늦은 
--사람을 구하고 그 결과 내에서 사번이 1997로 시작하는 경우 구하기
--	(사번의 최대값), like 이용
select position, max(empno)
from emp2
group by position
having max(empno) like '1997%';


--6. emp 테이블에서 hiredate가 1982년 이전인 사원들 중에서 deptno별, job별 
--sal의 합계를 구하되
--	그 결과 내에서 합계가 2000 이상인 사원만 조회



/*
※ select sql문 실행순서
5. select 컬럼
1. from 테이블
2. where 조건
3. group by 그룹핑할 컬럼
4. having 조건
6. order by 컬럼
*/

--rollup, cube : group by와 함께 사용
--[1] rollup() - 주어진 데이터들의 소계를 구해줌
--group by절에 주어진 조건으로 소계값을 구해줌

--학과별 평균급여
select deptno, round(avg(nvl(pay,0)), 1) 평균급여
from professor
group by deptno
order by deptno;


--rollup
select deptno, round(avg(nvl(pay,0)), 1) 평균급여
from professor
group by rollup(deptno)
order by deptno;

select deptno, position, avg(nvl(pay,0)) 평균급여
from professor
group by rollup(deptno, position)
order by deptno, position;


--cube
select deptno, position, avg(nvl(pay,0)) 평균급여
from professor
group by cube(deptno, position)
order by deptno, position;


--group by한 컬럼이 2개인 경우
--학과별, 직급별 평균급여
--rollup




--group by한 컬럼이 3개인 경우
--emp_details_view에서 지역별, 부서별, 직군별 평균급여



--rollup
select city, department_name, job_id, round(avg(nvl(salary, 0)), 1) 평균급여
from emp_details_view
group by rollup (city, department_name, job_id)
order by city, department_name, job_id;

--rollup(컬럼) => 컬럼의 개수+1 개의 소계가 만들어짐
--예) rollup(a,b,c) => (a,b,c), (a,b), (a), () => 3+1 => 4개의 소계가 만들어짐

--cube 
select city, department_name, job_id, round(avg(nvl(salary, 0)), 1) 평균급여
from emp_details_view
group by cube (city, department_name, job_id)
order by city, department_name, job_id;

--cube(컬럼) => 2의 컬럼승 개의 소계가 만들어짐 (모든 경우의 수)
--예) cube(a,b,c) => 모든 경우의 수만큼의 소계가 만들어짐, 2의 3승 개=>8개
--(a,b,c), (a,b),(a,c),(b,c),(a),(b),(c),()



--grouping() - rollup, cube 함수와 같이 사용됨
--소계에 대한 요약 정보를 줄 때 사용
--그룹핑 작업에 사용되었으면 0, 사용되지 않았으면 1을 리턴함

--group by한 컬럼이 1개인 경우, rollup
select deptno 학과, avg(nvl(pay, 0)) 평균급여, grouping(deptno)
from professor
group by rollup(deptno)
order by deptno;

select decode(grouping(deptno), 0, to_char(deptno), '[합계]') 학과,
    avg(nvl(pay, 0)) 평균급여, grouping(deptno)
from professor
group by rollup(deptno)
order by deptno;

--cube
select decode(grouping(deptno), 0, to_char(deptno), '[합계]') 학과,
    avg(nvl(pay, 0)) 평균급여, grouping(deptno)
from professor
group by cube(deptno)
order by deptno;


--group by한 컬럼이 2개인 경우
--rollup
select deptno, position, avg(nvl(pay, 0)), grouping(deptno), grouping(position)
from professor
group by rollup(deptno, position)
order by deptno, position;

select decode(grouping(deptno), 1, '[전체]', deptno) 학과,
       decode(grouping(position), 1, 
       decode(grouping(deptno), 1,'[소계]', '[학과별소계]') , position) 직급,
avg(nvl(pay, 0)), grouping(deptno), grouping(position)
from professor
group by rollup(deptno, position)
order by deptno, position;

--cube
select deptno, position, avg(nvl(pay, 0)), grouping(deptno), grouping(position)
from professor
group by cube(deptno, position)
order by deptno, position;

select decode(grouping(deptno), 1, '[전체]', deptno) 학과,
       decode(grouping(position), 1, 
       decode(grouping(deptno), 1,'[소계]', '[학과별소계]') , position) 직급,
avg(nvl(pay, 0)), grouping(deptno), grouping(position)
from professor
group by cube(deptno, position)
order by deptno, position;

select decode(grouping(deptno),1,decode(grouping(position),1,'[전체]','[직급별소계]'), deptno) 학과,
       decode(grouping(position),1,decode(grouping(deptno),1,'[소계]','[학과별소계]'),position) 직급,
avg(nvl(pay,0)), grouping(deptno), grouping(position)
from professor
group by cube(deptno, position)
order by deptno, position;

--grouping sets - 원하는 집계만 수행할 수 있다
--그룹핑 조건이 여러 개일 경우 유용하게 사용

--예) STUDENT 테이블에서 학년별로 학생들의 인원수 합계와 학과별로 인원수의 합계를 
--구해야 하는 경우에 기존에는 학년별로 인원수 합계를 구하고 별도로 학과별로 인원수 
--합계를 구한 후 UNION 연산을 했음

--학년별 인원수 union 학과별 인원수
select grade, deptno1, count(*) as "학년별 인원 수"
from student
group by grade, deptno1;

select * from student;
--cf. 학년별, 학과별 인원수


--grouping sets 이용



--rollup
select deptno, position, avg(nvl(pay, 0)) 평균급여
from professor
group by rollup(deptno, position);


--grouping sets을 이용한 rollup과 동일한 상황
select deptno, position, avg(nvl(pay, 0)) 평균급여
from professor
group by grouping sets((deptno, position), (deptno), ());


--cube
select deptno, position, avg(nvl(pay, 0)) 평균급여
from professor
group by cube(deptno, position);


--grouping sets을 이용한 cube와 동일한 상황
select deptno, position, avg(nvl(pay, 0)) 평균급여
from professor
group by grouping sets((deptno, position), (deptno), (position), ())
order by deptno, position;

--원하는 집계만
select deptno, position, avg(nvl(pay, 0)) 평균급여
from professor
group by grouping sets((deptno, position), (deptno), (position), ())
order by deptno, position;


--panmae 테이블에서 수량(p_qty)이 3개 이상인 데이터에 대해 판매일(p_date)별, 
--판매점(p_store)별로 판매금액(p_total)의 합계 구하기
--rollup, cube이용하여 소계 출력
--각각의 경우 grouping함수를 이용해서 요약정보 출력하기(decode()도 이용)
select p_date, p_store, sum(nvl(p_total, 0)) as "합계"
from panmae
group by rollup (p_date, p_store);

select p_date, p_store, sum(nvl(p_total, 0)) as "합계"
from panmae
group by cube (p_date, p_store);

select p_date, p_store, decode(p_qty >= 3, sum(nvl(p_total, 0))) as "합계"
from panmae
group by grouping sets (p_date, p_store);

select decode(grouping(p_date), 1, '총', p_date) as "판매일",
    decode(grouping(p_store), 1, decode(grouping(p_date), 1, '[합산]','[일일합산]'),p_store) "판매지점", sum(p_total) "매출액"
from panmae
where p_qty >= 3
group by rollup(p_date, p_store)
order by p_date, p_store;

select decode(grouping(p_date), 1, decode(grouping(p_store), 1, '[총]','[판매점 소계]'), p_date) as "판매일",
    decode(grouping(p_store), 1, decode(grouping(p_date), 1, '[합산]','[일일합산]'),p_store) "판매지점", sum(p_total) "매출액"
from panmae
where p_qty >= 3
group by cube(p_date, p_store)
order by p_date, p_store;


select decode(grouping(p_date),1,'[총]',p_date) 판매일,
    decode(grouping(p_store),1,decode(grouping(p_date),1,'[합산]','[일일합산]'),p_store) 판매지점, sum(p_total) 매출액
from panmae
where p_qty>=3
group by rollup(p_date,p_store);

select * from panmae;



--emp 테이블에서 부서별로 각 직급별 sal의 합계가 몇인지 계산해서 출력
select deptno, job, sum(sal)
from emp
group by deptno, job
order by deptno, job;



--월별 매출(월별로 price의 합계 구하기)
--[1] group by 이용
select sum(price) as "매출 합계", extract(month from regdate)as "월"
from pd
group by extract(month from regdate)
order by extract(month from regdate);

select * from pd;



--student에서 deptno1(학과)별, 학년별 키의 평균 구하기
--[1] group by 이용
select deptno1, grade, avg(nvl(height, 0)) as "평균 키"
from student
group by deptno1, grade
order by deptno1, grade;

