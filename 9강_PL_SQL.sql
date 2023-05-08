--9강_PL_SQL.sql
--[2023-05-08 월]

--PL/SQL
/*
    - Procedural Language extension to Structured Query Language
    - SQL과 일반 프로그래밍 언어의 특성을 결합한 언어
    - 변수, 상수 선언 가능
    - 조건문, 반복문 사용 가능
    
    선언부
        - declare키워드 사용
        - 변수나 상수를 선언하는 부분
    
    실행부
        - begin ~ end 키워드 사용
        - 변수에 값 할당, 조건문, 반복문, sql문장 등을 처리
        - 실행해야 할 로직을 넣는 부분
        
    예외처리부
        - exception 키워드 사용
        - 실행부에서 예외가 발생했을때 처리하는 부분        
*/

--선언부, 실행부, 예외처리부가 하나의 PL/SQL블록을 구성하고
--오라클은 이 블록단위로 처리함
SET SERVEROUTPUT ON;
declare
    counter number;
begin
    counter := 1;
    
    counter := counter / 10;
    
    if counter is not null then
        dbms_output.put_line('counter => ' || counter);
    end if;
    
    exception when ZERO_DIVIDE then
         dbms_output.put_line('0으로 나누면 안됩니다.');
end;         


--1~10까지 for문을 이용하여 반복처리
declare
    i   number;
    result number;
begin
    for i in 1..10 loop
        result := i * 2;
        dbms_output.put_line(result);
    end loop;
    
    exception when others then
        dbms_output.put_line('error');
end;


--while 문 이용
declare
    i number;
    result number;
begin
    i := 1;
    while i <= 10 loop
        result := i * 3;
        dbms_output.put_line(i || '* 3 => ' || result);
        
        i := i + 1;
    end loop;
end;


--변수, 상수 선언
/*
   변수명  데이터타입;  --변수선언
   변수명  constant 데이터타입;  --상수선언
   변수명  테이블명.컬럼명%type;  --변수선언
        => 해당 테이블의 해당 컬럼과 동일한 타입의 변수 선언
        
   예) name  varchar2(30);
       curYear  constant number := 2019;
       empno    employees.employee_id%type;     
*/

--조건문
/*
    1) if문
    if 조건1 then
        문장1;
    elsif 조건2 then
        문장2;
    else
        문장3;
    end if;
    
    2) case문
    case
    when 조건 then
        문장1;
    else
        문장2;
    end case;
*/
--if 문 이용
declare
    grade char;
    result varchar2(50);
begin
    grade := 'B';
    
    if grade = 'A' then
        result := 'Excellent';
    elsif grade = 'B' then
        result := 'Good';
    elsif grade = 'C' then
        result := 'Fair';
    elsif grade = 'D' then
        result := 'Poor';
    else
        result := 'Not found';
    end if;
    
    dbms_output.put_Line(grade || ' => ' || result);
    
    exception when others then
        dbms_output.put_Line('error');
end;


--case문 이용
declare
    grade char;
    result varchar2(50);
begin
    grade := 'C';
    
    case grade
        when grade = 'A' then
            result := 'Excellent';
        when grade = 'B' then
            result := 'Good';
        when grade = 'C' then
            result := 'Fair';
        when grade = 'D' then
            result := 'Poor';
        else
            result := 'Not found';
        end case;
    dbms_output.put_Line('case : ' || grade || ' => ' result);
    
    excpetion when others then
    dbms_output.put_Line('error');
    
end;   


--반복문
/*
    1) 
        loop
            exit when 조건;
            
        end loop;
    
    2)
        for 변수 in [reverse] 초기값..종료값 loop
            처리할 문장;
        end loop;
    
    3)
        while 조건 loop
            처리할 문장;
        end loop;
*/
--loop문 이용
declare
    i   number;
    result number;
begin
    i := 1;
    
    loop
        result := i * 2;
        
        exit when result > 20;
        dbms_output.put_Line(result);
        
        i := i + 1;
    end loop; 

    exception when others then
    dbms_output.put_Line('error');
end;

--for문 이용
declare
    i number;
    result number;

begin for i in 1..10 loop
    result := i * 5;
    dbms_output.put_Line('i = ' || i || ', result = ' || result);
   end loop;
   dbms_output.put_Line('-----------------for문 reverse------------------');
   
   result := 0;
   for i in reverse 1..10 loop
        result := i * 4;
        dbms_output.put_Line('i = ' || i || ', result = i ' || result);
    end loop;
    
    exception when others then
        dbms_output.put_Line('error');
end; 

--while 문 이용
declare
    i   number;
    result number;
begin
    i := 1;
    result := 0;
    
    while result < 20 loop
        result := i * 2;
        dbms_output.put_Line(result);
        
        i := i + 1;
    end loop;
    
    exception when others then
        dbms_output.put_Line('error');
end;

/*
    실습
    
    [1] 1~20까지의 합 - for문 이용

    [2] if 문 이용  
    1~3 => 1사분기
    4~6 => 2사분기
    7~9 => 3사분기
    10~12 => 4사분기
*/

--1

declare 
    i   number;
    result number;

begin
    result := 0;
    for i in 1..20 loop
        result := result + i;
    end loop;
    dbms_output.put_line(result);
    
    
    exception when others then
        dbms_output.put_line('error');
end;

--2
declare
    m number;
    result varchar2(50);

begin
    m := 3;
    
    if m between 1 and 3 then
        result := '1분기';
    elsif m between 4 and 6 then
        result := '2분기';
    elsif m between 7 and 9 then
        result := '3분기';
    elsif m between 10 and 12 then
        result := '4분기';
    else
        result := 'Not found';
    end if;
    
    dbms_output.put_Line(result);
    
    exception when others then
        dbms_output.put_Line('error');
end; 


--PL/SQL 서브 프로그램
/*
    - 데이터베이스 객체로 저장해서 필요할 때마다 호출하여 사용할 수 있는
      PL/SQL블록
      
    1) 함수(Function) - 결과값을 반환함
        사용자 정의 함수를 말함
        특정 기능을 수행한 뒤, 결과값을 반환하는 서브프로그램
    
    2) 저장 프로시저(내장 프로시저, Stored Procedure) - 결과값을 반환하지 않음   
*/

--함수
/*
    create or replace function 함수명
    (
        파라미터1   데이터타입,
        파라미터2   데이터타입, ...
    )
        return 데이터타입
    is 또는 as
        변수선언
    begin
        처리할 로직
        
        exception when others then
            예외처리할 문장
    end;    
*/

--주민번호를 넣으면 성별을 리턴하는 함수 만들기
create or replace function get_gender
(
    p_ssn   varchar2
)
return varchar2
is

    v_gender    varchar2(10);
begin
    select case when substr(p_ssn, 7, 1) in ('1', '3') then '남자'
                else '여자' end
                into v_gender
    from dual;
    
    return v_gender;
    
    exception when others then
        dbms_output.put_Line('error');
end;        


--함수 실행시키기
select get_gender('9909221066711'), get_gender('6805242676026') from dual;
select length('java')from dual;

select gname, jumin, get_gender(jumin) 성별,length(gname) 이름길이
    from gogak;


--주민번호를 이용해서 나이를 구하는 함수 만들기
--함수이름 - get_age
create or replace function get_age
(
    p_ssn   varchar2
)
return varchar2
is

    v_age    number;
begin
    select extract(year from sysdate) - (substr(p_ssn,1,2) +
    case when substr(p_ssn, 7, 1) in (1, 2) then 1900 
                else 2000 end)
                into v_age
    from dual;
    
    return v_age;
    
    exception when others then
        dbms_output.put_Line('error');
end;    

--함수 실행
select gname, jumin, get_age(jumin) 나이,length(gname) 이름길이
    from gogak;


--stored procedure(저장 프로시저, 내장 프로시저)
--특정 기능을 수행하지만 값을 반환하지는 않는 서브프로그램
/*
    create or replace procedure 프로시저명
    (
        파라미터1   데이터타입,
        파라미터2   데이터타입, ...
    )
    is [as]
        변수선언
    begin
        처리할 로직
        
        exception when others then
            예외처리
    end;    
*/


--pd2테이블에 입력하는 프로시저
create or replace procedure pd2_insert
(
    p_pdcode    char,
    p_pdname    varchar2,
    p_price     number,
    p_company   varchar2
)
is

begin
    insert into pd2(no, pdcode, pdname, price, company)
    values(pd2_seq.nextval, p_pdcode, p_pdname, p_price, p_company);
    
    commit;
    
    exception when others then
        dbms_output.put_Line('error');
        rollback;
end;        
    
select * from pd2; 

--저장 프로시저 실행시키기
/*
    execute 프로시저이름(파라미터);
    또는
    exec 프로시저이름(파라미터);
*/
execute pd2_insert('C01', '마우스', 34000, '로지텍');
exec pd2_insert('C02', '모니터', 200000, 'LG');

select * from pd2;

--pd2 테이블 컬럼을 수정하는 프로시저 만들기
create or replace procedure pd2_update
(
    p_no        pd2.no%type,
    
    p_pdcode pd2.pdcode%type,
    p_pdname pd2.pdname%type,
    p_price pd2.price%type,
    p_company pd2.company%type
)
is

    v_cnt      number(3);
begin
    select count(*) into v_cnt
    from PD2
    where no = p_no;
    
    if v_cnt > 0 then
        update pd2
        set pdcode = p_pdcode, pdname = p_pdname, price = p_price,
                     company = p_company
        where no = p_no;
    end if;
    
    commit;
    
    exception when others then
    dbms_output.put_Line('error');
end;
        
--실행
exec pd2_update(4, 'B03', '컴퓨터', 1500000, 'hp');
select * from pd2;

--저장 프로시저, 함수 확인
select * from user_source
where name = 'PD2_UPDATE';

--exists 이용한 update
create or replace procedure pd2_update2
(
    p_no        pd2.no%type,
    p_pdcode pd2.pdcode%type,
    p_pdname pd2.pdname%type,
    p_price pd2.price%type,
    p_company pd2.company%type
)
is
begin
    update pd2 a
    set pdcode = p_pdcode, pdname = p_pdname, price = p_price, company = p_company
    where exists (select 1 from pd2 b where b.no = a.no and b.no = 4);
    
        commit;
    
    exception when others then
     raise_application_error(-20001, '예외발생');
     
     rollback;
end;
--실행
exec pd2_update2(4, 'B04', '키보드', -500, 'qnix');
--error

exec pd2_update2(4, 'B04', '키보드', -500, 'qnix');

select * from pd2;

select * from user_constraints
where table_name = 'PD2';
select * from user_cons_columns
where table_name = 'PD2';

--%rowtype
/*
    - %type과 유사하나, 한 개 이상의 값에 대해 적용
    - 로우타입 변수를 선언해 테이블에 있는 row 대입 가능
*/


--사용자 정의 예외



--out 매개변수(파라미터)
--결과를 출력하는 용도의 매개변수

--in 매개변수 - 일반적인 매개변수, 입력용 매개변수
--생략하면 in 매개변수



--out 매개변수가 있는 프로시저 실행하기


--member 테이블에 update하는 프로시저 만들고 실행하기



--PL/SQL 커서
/*
    커서
    - 쿼리에 의해 반환되는 결과는 메모리 상에 위치하게 되는데,
    PL/SQL에서는 커서를 사용하여 이 결과 집합에 접근할 수 있다.
    - 커서를 사용하면 결과집합의 각 개별 데이터에 접근이 가능하다
    
    명시적 커서
    - 사용자가 직접 쿼리의 결과에 접근해서 이를 사용하기 위해 명시적으로
      선언한 커서
      
    명시적 커서를 사용하기 위한 절차
    [1] 커서 선언 - 쿼리 정의
    cursor  커서명 is select문장;
    
    [2] 커서 열기(open) - 쿼리 실행
    open 커서명;
    
    [3] 패치(fetch) - 쿼리의 결과에 접근, 루프를 돌며 개별 값들에 접근
    fetch 커서명 is 변수...;
    
    [4] 커서 닫기(close) - 메모리상에 존재하는 쿼리의 결과를 소멸시킴
    close  커서명;  
*/



/*
    %notfound - 커서에서만 사용 가능한 속성
    - 더 이상 패치(할당)할 로우가 없음을 의미
    - 쿼리의 마지막 결과까지 패치한 후에 자동으로 루프를 빠져나가게 됨
*/

--for loop cursor문
/*
    커서의 for loop문을 사용하면 커서의 open, fetch, close가 자동적으로 발생
    되어지기 때문에 open, fetch, close문을 기술할 필요가 없다
    
    형식
    for 변수명 (레코드 정보가 담기는 변수) in 커서명 loop
        실행 문장;
    end loop;
*/



--sys_refcursor
/*
    저장 프로시저의 select 결과물을 java에서 읽기 위해서는 sys_refcursor
    타입을 사용해야 함
*/
-- 실습
create table person
(
  no number(4) primary key,
  name varchar2(20) not null,
  tel varchar2(20),
  regdate  date default sysdate
 );

create sequence person_seq
start with 1
increment by 1
nocache;



create or replace procedure cart_insert
(
    p_no IN cart.no%TYPE,
    p_name IN cart.name%TYPE,
    p_tel IN cart.tel%TYPE,
)
is
begin
    insert into (no, name, tel)
    values(p_no, p_name, p_tel);
    
    commit;
    
    exception when others then
        dbms_output.put_line('error');
end;
     
