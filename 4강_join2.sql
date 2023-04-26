--4강_join.sql

/*
    조인
    - 각각의 테이블에 분리되어 있는 연관성 있는 데이터들을 연결하거나 조합하는 
      일련의 작업들
    - 여러 테이블에 흩어져 있는 정보 중에서 사용자가 필요한 정보만 가져와서
      가상의 테이블간 공통된 열을 기준으로 검색
      
    조인의 종류
    1) 내부조인(inner join)
       - 양쪽 테이블에 모두 데이터가 존재해야 결과가 나옴
    2) 외부조인(outer join)    
    3) self 조인
    4) cross join(카디션 곱)
    
    오라클용 조인
    표준 ANSI 조인
*/
--[1] inner join (내부 조인)
--학생 테이블(student)과 학과 테이블(department)을 사용하여 학생이름, 
--1전공 학과번호(deptno1), 1전공 학과이름을 출력하시오.
select * from student;
select * from department;

--1) 오라클 조인
select student
from student, department
where student.deptno1 = deparatement


--2)ANSI  join
select s.STUDNO, s.NAME, s.GRADE, s.DEPTNO1, d.DNAME
from student s inner join department d
on s.DEPTNO1 = d.DEPTNO;


--inner는 생략 가능
select s.STUDNO, s.NAME, s.GRADE, s.DEPTNO1, d.DNAME
from student s join department d
on s.DEPTNO1 = d.DEPTNO;


--4학년 학생들의 정보를 조회, 학과명도 출력
select s.*, d.dname
from student s, department d
where s.deptno1 = d.deptno --조인조건
and s.grade = 4; --검색조건(조회조건)

--ansi join
select s.*, d.dname
from student s join department d
on s.deptno1 = d.deptno --조인조건
and s.grade = 4; --검색조건(조회조건)

--또는
select s.*, d.dname
from student s join department d
on s.deptno1 = d.deptno --조인조건
where s.grade = 4; --검색조건(조회조건)

--학생 테이블(student)과 교수 테이블(professor)을 join하여 학생이름, 지도교수 번호, 
--지도교수 이름을 출력하시오
select s.name, s.grade, s.profno, p.name
from student s join professor p
on s.profno = p.profno
order by s.grade
where s.grade = 4;

select * from student;


--ansi join
select s.studno, s.name, s.grade, s.profno, p.name as "지도교수명"
from student s, professor p
where s.profno = p.profno;


--employees, jobs를 조인해서 사원정보와 job_title도 조회
select * from employees;
select * from jobs;

select e.*, j.job_title
from employees e, jobs j
where e.job_id = j.job_id;

--ansi join
select e.*, j.job_title
from employees e join jobs j
on e.job_id = j.job_id;


--3개 테이블 조인
--학생 테이블(student)과 학과 테이블(department), 교수 테이블(professor)을 join하여 
--학생이름, 학과 이름, 지도교수 이름을 출력하시오
select s.*, d.dname, p.name as "교수명"
from student s, department d, professor p
where s.deptno1 = d.deptno and s.profno = p.profno;

--ansi join
select s.*, d.dname, p.name as "교수명"
from student s join department d
on s.deptno1 = d.deptno
join professor p
on s.profno = p.profno;

--emp2 테이블과 학과 p_grade 테이블을 join하여 사원이름, 직급, 현재연봉, 
--해당 직급의 연봉의 하한 금액과 상한 금액을  출력하시오
select * from emp2;
select * from p_grade;

select e.name, e.position, e.pay, p.s_pay, p.e_pay
from emp2 e join p_grade p
on e.position = p.position;

--dept2 테이블 이용해서 부서명도 출력
select * from dept2;

select e.name, e.position, e.pay, p.s_pay, p.e_pay, d.dname
from emp2 e, p_grade p, dept2 d
where e.position = p.position
and e.deptno = d.dcode;

--ansi join
select e.name, e.position, e.pay, p.s_pay, p.e_pay, d.dname
from emp2 e join p_grade p
on e.position = p.position
join dept2 d
on e.deptno = d.dcode;


--사원정보, 사원의 부서정보, 부서의 지역정보, 지역의 나라정보 조회
 select * from employees;
 select * from departments;
 select * from locations;
 select * from countries;
-- department_id / location_id / country_id
select e.*, d.department_name, l.city, c.country_name
from employees e, departments d, locations l, countries c
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id;


--ansi join 
select e.*, d.department_name, l.city, c.country_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
join countries c
on l.country_id = c.country_id;

--검색(조회) 조건이 있는 경우
--1전공(depton1)이 101번인 학생들의 학생이름과 지도교수 이름을 출력하시오.
select s.*, p.name 교수명
from student s, professor p
where s.profno = p.profno
and deptno1 = 101;

--ansi join
select s.*, p.name 교수명
from student s join professor p
on s.profno = p.profno
and deptno1 = 101;

--emp2, dept2 테이블 이용 - 사원이름, 급여, 직급, 부서명 조회
select * from emp2;
select * from dept2;

select e.*, d.dname 부서명
from emp2 e, dept2 d
where e.deptno = d.dcode;

--emp2, dept2 테이블에서 부서이름별 pay의 평균 구하기
--1) emp2에서 부서번호별 평균급여
-- / dcode
select deptno, avg(nvl(pay, 0)) 평균급여
from emp2
group by deptno;

--2) 조인이용해서 부서이름별 평균급여
select d.dname, avg(nvl(pay, 0)) 평균급여
from emp2 e join dept2 d
on e.deptno = d.dcode
group by d.dname;

--3) 위의 결과에서 부서이름이 영업으로 시작하는 부서의 평균만 조회
select d.dname, avg(nvl(pay, 0)) 평균급여
from emp2 e join dept2 d
on e.deptno = d.dcode
group by d.dname
having d.dname like '영업%';

select * from emp;
select * from dept;

--실습
--emp, dept 테이블에서 부서번호,사원명,직업,부서명,지역 조회
--	단, 직업(job)이 CLERK인 사원 데이터만 조회
select e.*, d.*
from emp e join dept d
on e.deptno = d.deptno
where e.job = 'CLERK';

--emp, dept 테이블에서 부서번호,사원명,직업,부서명,지역 조회
--	단, 직업(job)이 CLERK인 사원이거나 Manager인 사원만 조회
select e.*, d.*
from emp e join dept d
on e.deptno = d.deptno
where e.job = 'CLERK' or e.job = 'MANAGER';

--emp, dept 테이블에서 지역(loc)별 급여(sal)의 평균 조회
--Join, group by 모두 이용
select d.loc, avg(nvl(e.sal, 0))
from emp e join dept d
on e.deptno = d.deptno
group by d.loc;

--student 테이블과 exam_01 테이블을 조회하여 학생들의 학번, 이름, 점수, 학점을 출력하시오
-- (학점은 dcode나 case이용- 90 이상이면'A', 80이상이면 'B', 70이상이면 'C', 
--60이상이면'D' 60미만이면 'F' )
select s.studno 학번,s.name 이름, e.total 점수,
    case
        when total >= 90 then 'A'
        when total >= 80 and total <= 89 then 'B'
        when total >= 70 and total <= 79 then 'C'
        when total >= 60 and total <= 69 then 'D'
        else 'F'
    end as "학점"    
from exam_01 e join student s
on e.studno = s.studno;
 

select * from student;


--[2] outer join (외부 조인)
/*
    inner join과는 반대로 한쪽 테이블에는 데이터가 있고, 한쪽 테이블에 없는 경우에
    데이터가 있는 쪽 테이블의 내용을 전부 출력하게 하는 방법
*/

--예제)student 테이블과 professor 테이블을 조인하여 학생이름과 지도교수 이름을 출력하시오.
--단, 지도교수가 결정되지 않은 학생의 명단도 함께 출력하시오.
--(학생 데이터는 전부 출력되도록)

--cf. inner join : 양쪽에 데이터가 존재하는 것만 조회
select s.*, p.name 교수명
from student s join professor p
on s.profno = p.profno;


--outer join - 학생은 모두 출력
--oracle join
select s.*, p.name 교수명
from student s, join professor p
where s.profno = p.profno(+);

--ansi join
select s.*, p.name 교수명
from student s left outer join join professor p
on s.profno = p.profno;


--student 테이블과 professor 테이블을 조인하여 학생이름과 지도교수 이름을 출력하시오.
--단, 지도학생이 결정되지 않은 교수의 명단도 함께 출력하시오.
--(교수 데이터는 전부 출력되도록)
select * from professor;

select s.*, p.name 교수명, p.position
from student, join professor p
where s.profno(+) = p.profno
order by p.name;

--ansi join


--student 테이블과 professor 테이블을 조인하여 학생이름과 지도교수 이름을 출력하시오.
--단, 지도학생이 결정되지 않은 교수의 명단과 지도교수가 결정 안 된 학생 명단을 한꺼번에 출력하시오.

--oracle join => union을 이용하여 각각의 외부조인 결과를 합친다
select s.*, p.name 교수명
from student s, join professor p
where s.profno = p.profno(+)
union
select s.*, p.name 교수명
from student s, join professor p
where s.profno(+) = p.profno;

--ansi join
select s.*, p.NAME 지도교수명, p.POSITION
from student s full outer join professor p
on s.profno = p.profno;


--학생정보 출력, 학과명, 지도교수명도 출력
--학생 데이터는 전부 출력되도록
select * from department;

select s.*, d.name 학과명, p.name 지도교수명
from student s, department d, professor p
where s.deptno = d.deptno(+)
on 

--ansi join
select s.*, d.dname 학과명, p.name 지도교수명
from student s left join department d
on s.deptno1 = d.deptno
left join professor p
on s.profno = p.profno;

--student - deptno2 이용
select s.*, d.dname 학과명, p.name 지도교수명
from student s left join department d
on s.deptno2 = d.deptno
left join professor p
on s.profno = p.profno;

--cf. inner join

--ansi join


--사원정보 출력, 부서정보, 지역정보 추가
--사원전체 출력(사원-부서간), 부서전체 출력(부서-지역간)
select * from employees;
select * from departments;
select * from locations;

select e.*, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+);

--ansi join
select e.*, d.department_name, l.city
from employees e left join departments d
on e.department_id = d.department_id
left join locations l
on d.location_id = l.location_id;

--나라 정보도 추가
--지역전체 데이터 출력(지역-나라간)
select * from countries;

select e.*, d.department_name, l.city, c.country_name
from employees e, departments d, locations l, countries c
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
and l.country_id = c.country_id(+);

--ansi join
select e.*, d.department_name, l.city, c.country_name
from employees e left join departments d
on e.department_id = d.department_id
left join locations l
on d.location_id = l.location_id
left join countries c
on l.country_id = c.country_id;


--employees, departments, locations 테이블에서 city별, department_name별,
--job_id별로 그룹화하여 city, department_name, job_id, 인원수, salary합계 구하기
--outer join 이용
--사원전체 출력(사원-부서간), 부서전체 출력(부서-지역간)
select l.city, d.department_name, e.job_id,  count(*), sum(salary)
from employees e left join departments d
on e.department_id = d.department_id
left join locations l
on d.location_id = l.location_id
group by l.city, d.department_name, e.job_id;



--[3] self join
/*
-원하는 데이터가 하나의 테이블에 다 들어있을 경우
 하나의 테이블을 메모리상에서 별명을 두 개로 사용해서 가상으로 2개의 테이블로 만든 후
 조인 작업을 수행
*/
--상위 부서명 조회하기
--부서테이블에서 상위부서코드(pdept)에 해당하는 상위부서명 출력


--inner join이용
select a.DCODE, a.DNAME, a.PDEPT 상위부서코드, b.dname 상위부서명
from dept2 a, dept2 b
where a.PDEPT = b.DCODE
order by a.dcode;

--outer join 이용
select a.DCODE, a.DNAME, a.PDEPT 상위부서코드, b.dname 상위부서명
from dept2 a, dept2 b
where a.PDEPT = b.DCODE(+)
order by a.dcode;

--ansi
select a.DCODE, a.DNAME, a.PDEPT 상위부서코드, b.dname 상위부서명
from dept2 a left join dept2 b
on a.PDEPT = b.DCODE
order by a.dcode;

--사원정보와 해당 사원의 직속 상관의 이름 조회
select * from employees;
select a.EMPLOYEE_ID, a.FIRST_NAME, a.hire_date, a.MANAGER_ID 직속상관아이디,
    b.FIRST_NAME 직속상관이름
from employees a, employees b
where a.manager_id = b.employee_id(+)
order by a.EMPLOYEE_ID;


--ansi
select a.EMPLOYEE_ID, a.FIRST_NAME, a.hire_date, a.MANAGER_ID 직속상관아이디,
    b.FIRST_NAME 직속상관이름
from employees a left join employees b
on a.manager_id = b.employee_id
order by a.EMPLOYEE_ID;


--[4] cross join(카티션 곱)
/*
조인 조건이 없는 경우
두 테이블의 데이터를 곱한 개수만큼의 데이터가 출력됨
*/
select * from emp; --14건
select * from dept; --4건



--ansi join


--실습
--1. emp2, p_grade 테이블에서 name(사원이름),  position(직급), 시작연도(s_year), 끝연도(e_year)을 조회
--단, emp2 테이블의  데이터는 전부 출력되도록 할 것
select a.name 이름, a.position 직급, b.s_year 시작연도, b.e_year 끝연도
from emp2 a left join  p_grade b
on a.position = b.position;


select * from emp2;
select * from p_grade;

--2. EMP Table에 있는 EMPNO와 MGR을 이용하여 서로의 관계를 다음과 같이 출력하라. 
--‘FORD의 매니저는 JONES’
select a.empno 사원번호, a.ename 사원이름, a.job 직업명, a.mgr 매니저사원번호, b.ename 매니저
from emp a left join emp b
on a.mgr = b.empno;



