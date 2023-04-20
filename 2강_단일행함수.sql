--2강_단일행함수.sql
select * from pd order by no desc;
/*
1) 단일 행 함수 - 데이터가 여러 건 존재하지만 단일 행 함수에 들어가는 데이터는 
                한번에 한 개
                - 여러 건의 데이터를 한꺼번에 처리하는 것이 아니라 한번에 하나씩 
                처리하는 함수
2) 복수 행 함수 - 여러 건의 데이터를 동시에 입력 받아서 결과값 1건을 만들어 주는 함수
                그룹 함수라고도 함
*/

select * from emp; --14건

--단일행 함수 예
select ename, initcap(ename), job, length(job), sal from emp; --14건

--복수행 함수 예


/*
단일행 함수 -입력되는 데이터의 종류에 따라
[1] 문자함수 - 입력되는 값(매개변수)이 문자인 함수
[2] 숫자 함수
[3] 날짜 함수
[4] 형변환 함수
[5] 일반함수(기타함수)
*/

--[1] 문자함수
--initcap() - 영문 첫글자만 대문자로 바꾼다
select id, initcap(id) from student;

select 'preTTy girl', initcap('preTTy girl') from dual;
--공백 뒤의 문자도 대문자로 바꿔줌

--upper() - 대문자로 변환해줌
--lower() - 소문자로 변환
select id, initcap(id), upper(id), lower(id) from student;

select lower('JAVA') from dual;

select * from emp
where ename = 'SCOTT';

select * from emp
where lower(ename) = 'scott';


--length(), lengthb() - 문자열의 길이를 리턴해주는 함수
--lengthb() - 문자열의 바이트수를 리턴함(한글 1글자는 2바이트나 3바이트로 처리)
--oracle express 버전은 한글 1글자가 3바이트로 설정되어 있다
select name, id, length(name) as "이름의 길이",
    length(name) as "이름의 바이트 수",
    length(id) "id 길이", length(id) "id 바이트 수"
from student;

--concat('','') -  두 문자열을 연결해 주는 함수
--3개 이상의 문자열을 연결하려면 || 연산자 이용
select name || position as "교수 이름",
    concat(name, position) as "concat 이용",
    name || ' ' || position as "|| 연산자 이용"
from professor;

--select concat(name, ' ' position) from professor;
--> error 인수의 개수 부적합

--substr() - 문자열에서 특정 길이의 문자열을 추출할 때 사용
--substr('문자열', 시작위치, 추출할 글자수)
--시작위치를 - 로 하면 뒤에서부터 자리수를 계산함
select substr('java오라클', 5, 2),
    substr('java오라클', 3, 3),
    substr('java오라클', 6),
    substr('java오라클', -3, 1) from dual;
--오라 / va오 / 라클 / 오

--캐릭터셋 확인
select parameter, value from nls_database_parameters
where parameter like '%CHAR%'; --uft8

select name, substr(name, 1, 2), substr(name, 1, 3) from student;
 

--STUDENT 테이블에서 ID가 9글자 이상인 학생들의 이름과 ID와 글자수를 출력
select * from student;
select name, id, length(name), length(id) from student
where length(id) >= 9;

--STUDENT 테이블에서 1전공이 201번인 학생들의 이름과 이름의 글자수, 이름의 바이트 수를 출력
select name, length(name), lengthb(name) from student
where deptno1 = 201;

--student 테이블에서 JUMIN 칼럼을 사용하여 1전공이 101번인 학생들의 이름과 생년월일을 출력
select name, substr(jumin, 1, 6) from student
where deptno1 = 101;

--student 테이블에서 JUMIN 칼럼을 사용하여 태어난 달이 8월인 사람의 이름과 생년월일을 출력
select name, substr(jumin, 1, 6) from student
where substr(jumin, 3, 2)='08';

--instr() - 주어진 문자열이나 컬럼에서 특정 글자의 위치를 찾아주는 함수
--instr('문자열', '찾는 글자')
--instr('문자열', '찾는 글자', 시작위치, 몇번째인지)
--몇번째의 기본값은 1
select 'A*B*C', instr('A*B*C', '*'),
    instr('A*B*C', '*',3), instr('A*B*C', '*',3,2) from dual;


select 'A*B*C', instr('A*B*C', '*', -1),
    instr('A*B*C', '*', -2), instr('A*B*C', '*', -2, 2),
    instr('A*B*C', '*', -3, 2),
    instr('A*B*C', '*', -3, 4) from dual;

--student 테이블의 TEL 칼럼을 사용하여 학생의 이름과 전화번호, ')'가 나오는 위치를 출력
select name, tel, instr(tel, ')') from student;

--실습 ) student 테이블을 참조해서 1전공이 101번인 학생의 이름과 전화번호와 
--지역번호를 출력. 단, 지역번호는 숫자만 나와야 함
select name, tel, instr(tel, ')'), substr(tel, 1, 3),
    substr(tel, 1, instr(tel, ')') -1)
from student;


--파일명만 추출하기
create table test_file
(
    no  number,
    filePath    varchar2(100)
);
                               --123456789012345678901234567890
insert into test_file values(1, 'c:\test\js\example.txt'); --19-11=8 -1 =>7
insert into test_file values(2, 'd:\css\sample\temp\abc.java'); --23-19=4 -1=>3

commit;

select * from test_file;
--1) 파일명만 추출 => example.txt, abc.java
select substr(filepath, instr(filepath,'\', -1) + 1)
from test_file;

--2) 확장자만 추출=> txt, java
select substr(filepath, instr(filepath, '.') + 1)
from test_file;



--3) 순수 파일명만 추출=> example, abc
select substr(filepath, instr(filepath,'\', -1, 1) + 1,
        instr(filepath, '.', 1)- instr(filepath, '\', -1) -1)
from test_file;
--lpad('문자열' 또는 컬럼명, 자릿수, '채울문자')
--문자열의 남은 자릿수를 채울 문자로 채운다, 왼쪽부터 채워줌
--rpad() - 오른쪽부터 채워줌

--student 테이블에서 1전공이 101번인 학과 학생들의 ID를 총 10자리로 출력하되 왼쪽 
--빈 자리는 '$'기호로 채우세요
select name, id, lpad(id, 10, '$') from student
where deptno1 = 101;


--실습) DEPT2 테이블을 사용하여 DNAME을 다음 결과가 나오도록 쿼리 작성하기
--dname을 총 10바이트로 출력하되 원래 dname이 나오고 나머지 빈 자리는 해당 자리의 
--숫자가 나오면 됨. 즉, 사장실은 이름이 총 6바이트이므로 숫자가 1234까지 나옴
select dname, lpad(dname, 10, '1') from dept2;
select dname, lpad(dname, 10, '1234567890') from dept2;


--student 테이블에서 ID를 12자리로 출력하되 오른쪽 빈 자리에는 '*'기호로 채우세요
select id, rpad(id, 12, '*') from student;

--ltrim('문자열' 또는 컬럼명, '제거할 문자')
--왼쪽에서 해당문자를 제거한다
--제거할 문자를 생략하면 공백을 제거한다
--rtrim() - 오른쪽에서 해당 문자를 제거한다

select ltrim('abcdab', 'a'), ltrim('    가 나다    ') || '|',
    rtrim('abcdab', 'a'), rtrim('    가 나다    ') || '|' from dual;

select ltrim('javaoracle', 'abcdefghijvw'),
    ltrim('javaoracle', 'java'), rtrim('javaoracle', 'oracle'),
    rtrim('javaoracle', 'abcelmnopqr') || '|' from dual;

--DEPT2 테이블에서 DNAME을 출력하되 왼쪽에 '영'이란 글자를 모두 제거하고 출력
select dname, ltrim(dname, '영') from dpet2;

--DEPT2 테이블에서 DNAME을 출력하되 오른쪽 끝에 '부'라는 글자는 제거하고 출력
select dname, rtrim(dname, '부') from dpet2;

--reverse () - 어떤 문자열을 거꾸로 보여주는 것

 
--replace('문자열' 또는 컬럼명, '문자1','문자2')
--첫번째 문자열에서 문자1이 있으면 문자2로 바꾸어 출력하는 함수
select replace('javajsp', 'j', 'J'),
    replace('javajsp', 'jsp', 'oracle') from dual;


--student 테이블에서 학생들의 이름을 출력하되 성 부분은 '#'으로 표시되게 출력
select name, substr(name, 1, 1),
    replace(name, '서', '#'),
    replace(name, '', '#')
from student;

--실습) student 테이블에서 1전공이 101번인 학생들의 이름을 출력하되 가운데 글자만 '#'으로 표시되게 출력
select * from student;

select name,
    replace(name, substr(name, 2, 1), '#')
from student
where deptno1 = 101;

--실습) student 테이블에서 1전공이 101번인 학생들의 이름과 주민번호를 출력하되 
--주민번호의 뒤 7자리는 '*'로 표시되게 출력
select name, jumin,
    replace(jumin, substr(jumin, 7), '*******')
from student
where deptno1 = 101;

--실습) student 테이블에서 1전공이 102번인 학생들의 이름과 전화번호, 전화번호에서 
--국번 부분만 '#' 처리하여 출력. 단, 모든 국번은 3자리로 간주함
select name,
    replace(tel, substr(tel, 5, 3), '###')
from student
where deptno1 = 102;

--[2] 숫자함수
--round(숫자, 원하는 자릿수) - 반올림
select 12345.457, round(12345.457), round(12345.457, 1),
    round(12345.457, 2), round(12345.457, -1), round(12345.457, -2),
    round(12345.457, -3) from dual;
--12345 / 12345.5

/*
    정수로 반올림(소수이하 첫째자리에서 반올림)
    1: 소수이하 1자리만 남긴다(소수이하 2째자리에서 반올림)
    2: 소수이하 2자리만 남긴다(소수이하 3째자리에서 반올림)
    -1: 1의 자리에서 반올림(자릿수가 음수인 경우에는 소수 이상에서 처리)
    -2: 10의 자리에서 반올림
    -3: 100의 자리에서 반올림
*/

--trunc(숫자, 원하는 자릿수) - 버림
select 12345.457, trunc(12345.457), trunc(12345.457, 1),
    trunc(12345.457, 2), trunc(12345.457, -1), trunc(12345.457, -2),
    trunc(12345.457, -3) from dual;

--employees에서 salary를 100의 자리에서 반올림, 버림해서 출력
select salary, round(salary, -3), trunc(salary, -3)
from employees;

--mod(숫자, 나누는 수) - 나머지를 구하는 함수
--ceil(소수점이 있는 실수) - 올림(주어진 숫자와 가장 근접한 큰 정수 출력)
--floor(실수) - 내림(가장 근접한 작은 정수)
--power(숫자1, 숫자2) - 숫자1의 숫자2승
select mod(13, 3), ceil(12.3), floor(17.85), power(3, 4) from dual;

 
--[3] 날짜함수
--sysdate : 현재일자를 리턴하는 함수
select sysdate from dual;

--1) 며칠전, 며칠 후
/*
오늘부터 100일 후, 100일전

2019-03-27 + 100 => 날짜
2019-03-27 - 100
=> 더하고 빼는 기준은 일수
*/
select sysdate as "현재일자", sysdate + 100 "100일 후",
    sysdate - 100 "100일 전", sysdate + 1 "내일", sysdate - 1 "어제" from dual;

    
--2일 1시간 5분 10초 후 날짜 구하기
SELECT SYSDATE, SYSDATE + 2 + 1/24 + 5/1440 + 10/86400
from dual;

--3달 후 날짜, 3개월전 날자
--add_months(날짜, 개월수) : 해당날짜로부터 개월수만큼 더하거나 뺀 날짜를 구한다
--=> 몇 개월후, 몇 개월전에 해당하는 날짜를 구할 수 있다


--1년 후, 1년전 날짜
select sysdate, add_months(sysdate, 12) "내년", add_months(sysdate, -12) "작년"
from dual;


--2년 4개월 1일 3시간 10분 20초 후의 날짜 구하기
    
--to_yminterval() --year - month
--to_dsinterval() -

select sysdate, (sysdate + to_yminterval('02 - 04') + to_dsinterval('1 03:10:20'))
    as "2년 4개월 1일 3시간 10분 20초 후"
from dual;

select sysdate, add_months(sysdate, 28)+1+3/24+10/(24*60)+20/(24*60*60) from dual;
    
--7년 3개월 5일 2시간 30분 15초 전 날짜 구하기
select sysdate, (sysdate - to_yminterval('07 - 03') - to_dsinterval('5 02:30:15'))
    as "7년 3개월 5일 2시간 30분 15초 전"
from dual;
 
--2) 두 날짜 사이의 경과된 시간(일수)
--올해 1월 1일 부터 며칠 경과되었는지
--2021-04-15 - 2021-01-01 => 숫자
select sysdate, sysdate- '2023-01-01' from dual; --error


--날짜로 형변환한 후 계산해야 함
select sysdate, to_date('2023-01-01'),
    sysdate - to_date('2023-01-01') from dual;
 
--어제부터 오늘까지 경과된 일수, 오늘부터 내일까지 남은 일수
--to_date(문자) => 문자를 날짜형태로 변환해주는 함수
select to_date('2023-04-20') - to_date('2023-04-19') "어제부터 경과된 일수",
    to_date('2023-04-21') - to_date('2023-04-20') "내일까지 남은 일수" from dual;

select sysdate - to_date('2023-04-19') "어제부터 경과된 일수",
    to_date('2023-04-21') - sysdate "내일까지 남은 일수" from dual;

--시간을 제외한 두 날짜 사이의 일수를 구하는 경우
--trunc(날짜) 함수를 이용하면 해당 날짜를 리턴해줌 (시분초 버림, 제거)
select to_date('2023-04-21') - trunc(sysdate) "내일까지 남은 일수",
    sysdate, trunc(sysdate) from dual;

--두 날짜 사이의 개월 수
--months_between() - 두 날짜 사이의 개월수를 구해줌
select months_between('2023-03-27', '2023-01-27'),
    months_between('2023-05-27', '2023-01-01'),
    months_between('2023-05-10', '2023-01-27')
from dual;

--next_day() 함수
/*
주어진 날짜를 기준으로 돌아오는 가장 최근 요일의 날짜를 리턴해주는 함수
요일명 대신 숫자를 입력할 수도 있다.
1:일, 2:월, 3:화 ... 7:토
*/
select sysdate, next_day(sysdate, '월'), next_day(sysdate, '화요일'),
    next_day(sysdate, 1), next_day('2023-04-01', '금') from dual;


--last_day() 함수
--주어진 날짜가 속한 달의 가장 마지막 날을 리턴해주는 함수
select sysdate, last_day(sysdate), last_day('2023-02-03'),
    last_day('2023-05-08'), last_day('2024-02-03') from dual;

--round() - 정오기준으로 그 이전에는 오늘 날짜를 리턴하고, 그 이후에는 그 다음 날짜를
--리턴함

--trunc() - 무조건 오늘 날짜를 리턴
--=> 시간은 제외됨
select sysdate, round(sysdate)


--[4] 형변환 함수
/*
※ 오라클의 자료형
문자 - char(고정길이형), varchar2(가변길이형)
숫자 - number
날짜 - date

형변환
1) 자동형변환
2) 명시적 형변환
    to_char() - 숫자, 날짜를 문자로 변환
    to_number() - 문자를 숫자로 변환
    to_date() - 문자를 날짜로 변환
*/

--자동형변환
select 1 + '2', 2 + '003', '004', 1 + to_number('2'),
    2 + to_number('003') from dual;

select * from employees
where hire_date >= '2008-01-01'; --날짜로 자동 형편환

select * from employees
where hire_date >= to_date('2008-01-01');

--(1-1) to_char(날짜, 패턴) - 날짜를 패턴이 적용된 문자로 변환한다.
select sysdate, to_char(sysdate, 'yyyy'),
    to_char(sysdate, 'mm'),
    to_char(sysdate, 'dd'),
    to_char(sysdate, 'd') "요일",
    to_char(sysdate, 'year'),
    to_char(sysdate, 'mon'),
    to_char(sysdate, 'month'),
    to_char(sysdate, 'ddd'), --1년 중 며칠인지
    to_char(sysdate, 'day'), --요일을 한글로
    to_char(sysdate, 'dy'), --요일(월, 화, 수)
    to_char(sysdate, 'q'), --분기
from dual;

select sysdate, to_char(sysdate, 'yyyy-mm-dd'),
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss am day'),
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss pm day')
from dual;

--extract()함수 - 해당 날짜에서 년,월,일을 추출하는 함수
select extract(year from sysdate) 년도,
    extract(month from sysdate) 월,
    extract(day from sysdate) 일
from dual;

select extract(year from to_date('2023-05-08')) 년도,
    extract(month from to_date('2023-05-08')) 월,
    extract(day from sysdate) 일
from dual;

--실습) STUDENT 테이블의 birthday 칼럼을 참조하여 생일이 3월인 학생의 이름과 birthday를 출력
select name, birthday
from student
where to_char(birthday, 'mm') = 03;
    

--실습
--emp테이블에서 사원의 입사일 90일 후의 날짜?
select ename, hiredate, hiredate + interval '90' day
from emp;

--emp테이블에서 사원의 입사후 1년이 되는 날짜?
select ename, hiredate, hiredate + interval '1' year
from emp;

--오늘부터 크리스마스까지 남은 일수는?
 select sysdate, to_date('2023-12-25') - sysdate as "크리스마스까지 남은 일수"
 from dual;

--오늘부터 크리스마스까지 남은 달수는? (months_between)
 select months_between('2023-12-25', sysdate) "크리스마스까지 남은 달수"
 from dual;


--emp테이블에서 입사한지 오늘까지 몇일 되었나?
select ename, hiredate, (to_date(sysdate) - hiredate) "경과 일 수"
from emp;

--emp테이블에서 입사한지 오늘까지 몇달 되었나?
select ename, hiredate, months_between(sysdate, hiredate) "경과 달 수"
from emp;

--emp테이블에서 입사한지 오늘까지 몇 년이 되었나?
select hiredate, extract(year from sysdate) - extract(year from hiredate) "경과 년 수"
from emp;


--현재 날짜에 해당하는 달의 마지막 날짜는? (last_day)
select last_day(sysdate)
from dual;

--2016-02-13에 해당하는 달의 마지막 날짜는?
select last_day('2016-02-13')
from dual;

--(1-2) to_char(숫자, 패턴) - 숫자를 패턴이 적용된 문자로 변환
/*
    9 : 남은 자리를 공백으로 채움
    0 : 남은 자리를 0으로 채움
*/
select 1234, to_char(1234, '99999'), to_char(1234, '099999'),
    to_char(1234, '$99999'), to_char(1234, 'L99999'),
    to_char(1234.56, '9999.9'), to_char(1234, '99,999'),
    to_char(1234.56, '9999')from dual;


--Professor 테이블을 참조하여 101번 학과 교수들의 이름과 연봉을 출력하시오. 
--단 연봉은 (pay*12)+bonus 로 계산하고 천 단위 구분기호로 표시하시오.
select name as "이름", to_char((pay*12) + bonus,'999,999') "연봉"
from professor
where deptno = 101;

--(2) to_date(문자, 패턴) - 문자를 날짜로 변환
select to_date('2023-05-20'), to_date('2023-06-07', 'yyyy-mm-dd'),
    to_date('2023-02-05 17:39:20', 'yyyy-mm-dd hh24:mi:ss')from dual;
    
select * from professor where hiredate >= '1995-01-01';
select * from professor where hiredate >= to_date('1995-01-01');

select '2023-04-20' - '2023-04-01' from dual; --error
select to_date('2023-04-20') - to_date('2023-04-01')from dual;
--2021-04-14 ~ 2019-05-05까지의 데이터 조회



--등록한지 몇시간이 지났는지 조회
--pd테이블, regdate이용



--(3) to_number(문자) - 문자를 숫자로 변환

	

--[실습]Professor 테이블을 사용하여 1990년 이전에 입사한 교수명과 입사일, 
--현재 연봉과 10% 인상 후 연봉을 출력하시오.
--연봉은 상여금(bonus)를 제외한 (pay*12)로 계산하고 연봉과 인상 후 연봉은 천 단위 구분 
--기호를 추가하여 출력하시오.



--[5] 일반 함수
--nvl(컬럼, 치환할 값) - 해당 컬럼이 null이면 치환할 값으로 바꾸는 함수


--Professor 테이블에서 101번 학과 교수들의 이름과 급여, bonus, 연봉을 출력하시오. 
--단, 연봉은 (pay*12+bonus)로 계산하고 bonus가 없는 교수는 0으로 계산하시오.


--nvl2(col1, col2, col3) : col1 이 null이 아니면 col2를
--                                 null이면 col3를 출력


--Professor 테이블에서 101번 학과 교수들의 이름과 급여, bonus, 연봉을 출력하시오. 
--단, 연봉은 (pay*12+bonus)로 계산하고 bonus가 없는 교수는 0으로 계산하시오.

    
--이름(first_name - last_name), 입사일, salary(기본급), 수당퍼센트(commission_pct),
--연봉(기본급+기본급*수당퍼센트)*12
--수당퍼센트가 null이면 연봉은 기본급*12
--nvl()이나 nvl2() 이용
--employees테이블 이용


--decode() 함수
--if문을 대신하는 함수
/*
    decode(A, B, 참, 거짓)
    - A가 B와 같으면 참을 처리하고, 그렇지 않으면 거짓을 처리한다.
*/

--student 에서 grade가 1이면 1학년, 2이면 2학년, 3이면 3학년, 4이면 4학년이라고 출력

				  
--Professor 테이블에서 교수명, 학과번호, 학과명을 출력하되 deptno가 101번인 교수만 
--컴퓨터 공학과로 출력하고 101번이 아닌 교수들은 학과명에 아무것도 출력하지 마세요.



--Professor 테이블에서 교수명, 학과번호, 학과명을 출력하되 deptno가 101번인 교수만 
--컴퓨터 공학과로 출력하고 101번이 아닌 교수들은 학과명에 ‘기타학과’로 출력하세요.


--Professor 테이블에서 교수명, 학과명을 출력하되 deptno가 101번이면 ‘컴퓨터 공학과’, 
--102번이면 ‘멀티미디어 공학과’, 103번이면 ‘소프트웨어 공학과’, 나머지는 ‘기타학과’로 출력하세요.

			      
--Professor 테이블에서 교수명, 부서번호를 출력하고, deptno가 101번인 부서 중에서 
--이름이 조인형인 교수에게 ‘석좌교수 후보’라고 출력하세요. 나머지는 null 값 출력.


--Professor 테이블에서 교수명, 부서번호를 출력하고, deptno가 101번인 부서 중에서 
--이름이 조인형인 교수에게 비고란에 ‘석좌교수 후보’라고 출력하세요. 
--101번 학과의 조인형 교수 외에는 비고란에 ‘후보아님’을 출력하고 
--101번 교수가 아닐 경우는 비고란이 공란이 되도록 



--Student 테이블을 사용하여 제 1전공(deptno1)이 101번인 학과 학생들의 이름(name)과 
--주민번호(jumin), 성별을 출력하되 성별은 주민번호 칼럼을 이용하여 7번째 숫자가 1일 경우
-- ‘남자’, 2일 경우 ‘여자’로 출력하세요



--Student 테이블에서 제 1전공(deptno1)이 101번인 학생들의 이름(name)과 전화번호(tel),
--지역명을 출력하세요. 지역명은 지역번호가 02는 서울, 031은 경기, 051은 부산,052는 울산,
-- 055는 경남으로 출력하세요




--to_char() 이용 - 1이면 일, 2이면 월, ..7이면 토


 
--case 함수 - if문을 대신하는 함수, 조건이 범위값을 가질때도 사용 가능
/*
    [1] 동일값 비교시 (=로 비교되는 경우)
        case 조건 when 결과1 then 출력1
                  when 결과2 then 출력2
                  else 출력3
                  end "별칭"
                  
    [2] 범위값 비교시
        case when 조건1 then 출력1
             when 조건2 then 출력2
             else 출력3
             end "별칭"
*/ 
--1) 동일값 비교
--학년 출력하기

--2) 범위값 비교
--professor 테이블에서 pay기준으로 400초과, 300~400사이, 300미만으로 출력


 
--Student 테이블에서 학생들의 이름과 전화번호, 지역명을 출력하세요. 
--단, 지역번호가 02는 서울, 031은 경기, 051은 부산,052는 울산, 055는 경남, 
--나머지는 기타로 출력하세요


--Student 테이블의 JUMIN 칼럼을 참조하여 학생들의 이름과 태어난 달, 분기를 출력하세요. 
--태어난 달이 01~03월은 1/4분기, 04~06월은 2/4분기, 07~09월은 3/4분기, 
--10~12월은 4/4분기로 출력하세요


 
--성별 - gogak테이블에서 주민번호 이용
--1:남, 2:여, 3:남, 4:여



--exam_01에서 total을 이용해서 학점구하기
--90이상이면 A, 80이상이면 B, 70이상이면 C, 60이상이면 D, 나머지는 F

 
--Professor 테이블을 조회하여 교수의 급여액수(pay)를 기준으로 200 미만은 4급, 
--201~300은 3급, 301~400은 2급, 401 이상은 1급으로 표시하여 교수의 번호(profno), 
--교수이름(name), 급여(pay), 등급을 출력하세요. 단, pay 칼럼을 내림차순으로 정렬하세요.



--gogak 테이블에서 나이 구하기
--jumin에서 연도만 추출 - substr
--현재일자에서 연도만 - to_char() 나 extract()
--추출한 생년에 1900이나 2000 더하기 - substr(), decode()/case
--현재일자의 년도 - 1900이나 2000을 더한 생년 + 1


 
--매월 말일이 월급날, 월급날이 토요일이면 전날인 금요일에,
--일요일이면 전전날인 금요일에 월급을 받는다
--월급날 출력하기


    
--emp 테이블에서 sal 이 2000 보다 크면 보너스는 1000, 1000보다 크면 500, 
--나머지는 0 으로 표시하세요

    
