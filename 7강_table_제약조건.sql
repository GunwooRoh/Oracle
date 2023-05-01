--7강_table_제약조건.sql

/*
   DDL - 데이터베이스 오브젝트들을 생성, 변경, 삭제, 관리하는 명령어
   [1] create - 오브젝트의 생성 명령어
    create 오브젝트타입  오브젝트명...
    예) create table 테이블명...
        create sequence 시퀀스명..
        
   [2] drop - 오브젝트 제거(영구 소멸)
    drop 오브젝트타입 오브젝트명;
    예) drop table 테이블명;
        drop sequence 시퀀스명;
        
   [3] alter - 오브젝트 구조 변경
    alter 오브젝트타입 오브젝트명..
    예) alter table dept5
        add loc varchar2(20);
        
   [4] truncate 
    truncate table : 테이블의 데이터 삭제
    truncate table 테이블명;
    
    ※ drop, truncate, delete비교
    1) delete - 메모리상의 데이터를 삭제, rollback으로 되돌릴 수 있다
    2) truncate - 메모리상의 데이터와 데이터 파일까지 삭제, 자동커밋됨
                 delete보다 수행속도가 빠름
       => delete, truncate는 데이터만 삭제, 테이블 구조는 살아있다           
    3) drop - 테이블의 구조까지 영구히 소멸시킴
*/
/*
    ※ 테이블 만들기
    create table 테이블명
    (
        컬럼명1    데이터타입,
        컬럼명2    데이터타입,
        컬럼명3    데이터타입,
        ....
    )
    
    ※ 데이터타입
    문자형, 숫자형, 날짜형
    [1] 문자형
    char(크기) - 고정길이 문자형, 최대 2000byte까지 저장 
    varchar2(크기) - 가변길이 문자형, 최대 4000byte까지 저장
    CLOB 타입(Character Large Object) 
        - 크기가 큰 문자열이나 문서의 저장이 가능
        - long 타입이 확장된 형태, 4GB까지 저장 
*/

--char, varchar2 비교
create table char_exam1
(
    name1   char(3), --고정길이 3바이트
    name2   varchar2(3) --가변길이 3바이트
)



insert into char_exam1
values('AA','AA');

select name1, name2, length(name1), length(name2),
    replace(name1, ' ','*'), replace(name2,' ', '*') from char_exam1;

drop table char_exam1;


/*
insert into char_exam1(name1,name2,name3,name4,name5,name6)
values('AAA','가','ABCDEF','ABCDEFG','AB',null);  --error
--name4가 6개 문자만 입력 가능하므로 에러

insert into char_exam1(name1,name2,name3,name4,name5,name6)
values('AAA','가','ABCDEF','가나다라마바','가나',null);
--인코딩에 따라 한글 1글자는 2바이트나 3바이트
--UTF-8 : 한글 1글자가 3바이트

insert into char_exam1(name1,name2,name3,name4,name5,name6)
values('AAA','가','ABCDEF','가나다라마바','가나다',null); --error
--name5는 6바이트이므로 한글 2글자만 입력 가능

insert into char_exam1(name1,name3,name6)
values('ABC','ABCDEF','ABCdefg가나다 clob 연습!!');
*/

select * from char_exam1; 

select * from nls_session_parameters
where parameter='NLS_LENGTH_SEMANTICS'; --=> BYTE=> char, varchar2에서 생략하면 byte

--[2] 숫자형 - number
/*
    number
    number(전체 자리수)
    number(전체 자리수, 소수이하 자리수)
*/


/*
insert into num_exam1(n1,n2,n3,n4,n5,n6)
values(1234567.89, 1234567.89,1234567.89,1234567.89,1234567.89,1234567.89);

insert into num_exam1(n1,n2,n3,n4,n5,n6,n7)
values(1234567.89, 1234567.89,1234567.89,1234567.89,1234567.89,1234567.89,1234567.89);
--n7은 전체 자리수 6개만 가능, 7개를 입력해서 에러
*/

select * from num_exam1;

/*
    n8  number(3,5)
    - 전체 자리수가 소수이하 자리수보다 적은 경우
    - 1보다 작은 실수 표현
    - 전체 자리수 3개, 소수이하 자리수 5개
    => 5-3 => 소수이하 자리수에 2개의 0이 붙게 됨
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

--[3] 날짜형
/*
    date - 년월일 시분초 까지 표현
    timestamp - 밀리초까지도 표현
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

--테이블 만들기 연습
--이름, 주민번호, 성별, 나이, 자기소개, 등록일




--무결성 제약조건
/*
    데이터 무결성
    - 오라클 서버에서 데이터를 흠 없이 안정되게 지켜주는것
    - 제대로된 데이터들이 올바르게 저장될 수 있도록 하기 위해
      데이터베이스 측에서 제공하는 기능들 => 무결성 제약조건
    - 무결성을 지키기 위해 제약조건들을 제공함
    - 제약조건들은 테이블의 컬럼에 적용됨
    
    ※ 무결성 제약조건 (Integrity Constraint)
    [1] NULL/NOT NULL
    [2] UNIQUE
    [3] PRIMARY KEY
    [4] FOREIGN KEY
    [5] CHECK
    [6] DEFAULT 
*/
--[1] NULL (NOT NULL => C)
/*
    - 데이터가 없음을 의미
    - 컬럼의 속성 중 하나로 해당 컬럼이 NULL값을 허용하는지 허용하지 않는지 지정
    - 데이터타입 다음에 명시함
    - NULL을 허용하면 NULL, 허용하지 않으면 NOT NULL 명시
    - 명시하지 않으면 디폴트값 : NULL
*/


/*
insert into null_exam1(col1, col2)
values('AA','BB');

insert into null_exam1(col2, col3)
values('B2','C2');  
--col1은 not null이므로 값을 입력해야 함

insert into null_exam1(col1, col2, col3)
values('A2',null, '');  --null을 직접 입력하는 경우 : null, ''입력

insert into null_exam1(col1, col3)
values('A3',' ');  --' '은 null이 아님

insert into null_exam1(col1)
values('A4');
*/

select * from null_exam1
where col3 is null;

select * from null_exam1
where col3 is not null;



--[2] unique (U)
/*
    - 각 레코드를 유일하게 식별할 수 있는 속성
    - 복합키를 unique제약조건으로 사용할 수 있다
    - 한 테이블에 여러 개의 unique제약조건이 올 수 있다.
    - null을 허용함
*/


/*
insert into unique_exam1
values('AA','BB','CC','DD');

insert into unique_exam1(col1,col3,col4)
values('AA','C1','D1'); 
--unique제약조건 위배, col1에 AA가 이미 있으므로 중복될 수 없다

insert into unique_exam1(col1,col3,col4)
values('A4','CC','DD'); --error: col3, col4는 복합키로 unique해야 하므로

insert into unique_exam1(col1,col3,col4)
values('A1','C1','C2');  --col2는 unique 이지만, null허용하므로 입력 가능

insert into unique_exam1
values('A2',null,'C2','D2');

insert into unique_exam1
values('A3','','C3','D3');
*/

select * from unique_exam1;
/*
    null을 허용한 unique에는 값을 입력하지 않을 수 있다
    col2의 값이 null인 레코드가 여러 개
    => unique 대상에서 제외됨
    
    unique 제약조건에는 not null을 지정하는 것이 일반적임
*/

--제약조건 조회
--user_constraints, user_cons_columns 뷰 이용


--[3] primary key (P)
/*
    - 각 레코드를 유일하게 식별할 수 있는 속성
    - 테이블당 하나만 올 수 있다
    - not null + unique index
    - 복합키도 가능
*/


/*
insert into pk_exam1(col1,col2,col3)
values('A01','AA',1);

insert into pk_exam1(col1,col2,col3)
values('A01','BB',2);  
--col1은 unique해야 하므로 

insert into pk_exam1(col1,col2,col3)
values(null,'CC',3); 
--primary key는 not null이므로, null허용하지 않음

insert into pk_exam1(col1)
values('A02');
*/

select * from pk_exam1;


/*
insert into pk_exam2
values('A01', 'B01', 10);

insert into pk_exam2
values('A01', 'B01', 20);  --error:col1, col2가 복합키, unique 제약조건 위배

insert into pk_exam2
values('A01', 'B02', 30);

select * from pk_exam2;

update pk_exam2
set col2='B01'
where col1='A01' and col2='B02'; --error: unique제약조건 위배

commit; 

select a.TABLE_NAME, a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, a.INDEX_NAME,
    b.COLUMN_NAME, b.POSITION
from user_constraints a join user_cons_columns b
on a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
and  a.table_name like '%EXAM%';
*/


--[4] foreign key(R) 외래키 제약조건
/*
    - 다른 테이블을 참조하기 위하여 사용되는 속성들
    - 테이블간에 관계를 설정할 때 사용되는 키
    - 부모 테이블의 primary key나 unique는 자식 테이블의 foreign key로 전이된다
    
    - 입력시 부모 테이블을 먼저 insert하고, 그 후에 자식 테이블을 insert해야 함
    - 부모 테이블에 있는 참조컬럼의 값만 자식 테이블에서 사용할 수 있다
    (부모 테이블에 없는 값을 자식 테이블에서 사용하는 것은 불가능)
    
    - 삭제시 자식 테이블을 먼저 삭제하고, 그 후에 부모 테이블을 삭제해야 함
    - foreign key 지정시 on delete cascade 옵션을 주면
      부모 테이블의 레코드를 삭제하면 자식 테이블의 해당 레코드도 삭제됨
*/




--[5] CHECK 제약 조건 (C)
/*
    - 입력되는 값을 체크하여 일정한 조건에 해당되는 값만 입력될 수 있게 하는 제약조건
    예) 성별(gender) 컬럼 => 남자, 여자만 입력되고 다른 값은 입력될 수 없도록
*/


/*
insert into check_exam1(no, name)
values(1,'홍길동');

insert into check_exam1(no, name, gender, pay, age)
values(2,'김길동','남자', 5000000,35);

insert into check_exam1(no, name, gender, pay, age)
values(3,'이길순','여', 500000,30);  
--gender check제약조건 위배

insert into check_exam1(no, name, gender, pay, age)
values(4,'김길자','여자', -300000,31); --error:pay check 제약조건 위배

insert into check_exam1(no, name, gender, pay, age)
values(5,'김길동','남자', 5000000,135); --error: age check제약조건 위배

select * from check_exam1;

select a.TABLE_NAME, a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, a.INDEX_NAME,
    b.COLUMN_NAME, b.POSITION
from user_constraints a join user_cons_columns b
on a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
and  a.table_name = 'CHECK_EXAM1';
*/


--[6] default
/*
- 기본값
- 컬럼에 특정값을 디폴트값으로 설정하면 테이블에 데이터를 입력할 때
  해당 컬럼에 값을 입력하지 않을 경우 디폴트로 설정한 값이 자동으로 입력됨
- 컬럼 타입 다음에 'default 디폴트값' 을 명시
- 반드시 데이터타입 다음에, null이나 not null 앞에 위치시켜야 함
*/


/*
insert into default_exam1(no, hiredate)
values(1, sysdate);

insert into default_exam1(no)
values(2);

insert into default_exam1(no, name, gender, hiredate, score)
values(3,'홍길선','여', default, 90);

insert into default_exam1
values(4,'감길동',default, default, default);

insert into default_exam1(no, name)
values(5,'이길동');

select * from default_exam1;
*/

--제약조건을 이용하여 테이블 만들기
--1) 부서 테이블 만들기
--부서(부모) <--> 사원(자식)


/*
=> 자식 테이블이 참조하고 있는 부모 테이블은 drop할 수 없으나,
참조제약조건까지 같이 삭제하고 싶으면 drop시 cascade constraint 옵션을 준다
(자식의 foreign key를 삭제하고 부모 테이블도 삭제됨)
*/



--2) 사원 테이블 만들기
--사원(부모) <--> 사원가족(자식)
--drop table employee;



select a.TABLE_NAME, a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, a.INDEX_NAME,
    b.COLUMN_NAME, b.POSITION
from user_constraints a join user_cons_columns b
on a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
and  a.table_name = 'EMPLOYEE';

--테이블 생성 후 제약조건 추가
--foreign key 추가하기



--3) 사원가족 테이블 만들기
--drop table family;


--insert - 부모 테이블에 먼저 데이터를 입력
--1) 부서 테이블 insert


--2) 사원 테이블 insert
--부모인 부서 테이블의 레코드가 없으면 자식인 사원 테이블을 insert할 수 없다


--3) 사원가족 테이블 insert


--delete
--자식이 참조하고 있는 부모 테이블의 레코드를 삭제하는 경우
--1) on delete cascade 옵션을 주지 않은 경우
--=> 부모 테이블의 레코드를 삭제하면 에러 발생


--=> 삭제를 반드시 해야 된다면, 자식 레코드를 먼저 삭제한 후 부모 레코드를 삭제한다

--2) on delete cascade 옵션을 준 경우
--=> 부모 테이블의 레코드를 삭제하면 해당 레코드를 참조하는 자식 테이블도 같이 삭제됨




/*
    1) 테이블 생성 후 제약조건 추가
    alter table 테이블명
    add constraint 제약조건이름  제약조건종류(컬럼);
    예) alter table emp
        add constraint pk_empno primary key(empno);
        
    2) 테이블을 만들면서 아웃라인 제약조건 지정
    컬럼명을 모두 나열한 이후에
    , constraint 제약조건이름 제약조건종류(컬럼)
    예) , constraint pk_empno primary key(empno);
    
    3) 인라인 제약조건 지정
    컬럼명의 데이터타입 뒤에 제약조건 종류
    예) empno number primary key    
*/

--테이블 생성 후 제약조건 추가하기
/*
create table employee2
(
    empno   number,  --사원번호
    name    varchar2(30)    not null,  --사원이름
    dcode   char(3)         not null,  --부서코드
    sal     number(10)  default 0, --급여
    email   varchar2(50), --이메일
    hiredate    date    default sysdate  --입사일                        
);
*/

--제약조건 추가하기
--primary key 추가



select * from user_constraints
where table_name='EMPLOYEE2';

--default값 조회


--foreign key 추가


--제약조건 이름 변경하기


--제약조건 제거하기


--check제약조건 추가


--unique제약조건 추가


--not null, default 제약조건 변경하기


--테이블을 만들면서 아웃라인 제약조건 지정하기
/*
create table employee3
(
    empno   number,  --사원번호
    name    varchar2(30)    not null,  --사원이름
    dcode   char(3)         not null,  --부서코드
    sal     number(10)  default 0, --급여
    email   varchar2(50), --이메일
    hiredate    date    default sysdate,     --입사일
    --아웃라인 제약조건
    
				 
);
*/

select * from employee3;


--각종 참조 시스템 뷰
/* - USER_TABLES : 해당 사용자가 생성한 테이블 내역
   - USER_CONSTRAINTS
   - USER_INDEXES
   - USER_OBJECTS, …*/



/*
    create table 테이블명
    as
    select문
    
    을 이용해서 테이블을 만들면 null, not null을 제외한 제약조건은 복사되지 않음
*/   



--복사한 테이블에 primary key 추가


--alter
--테이블 변경하기
--1) 새로운 컬럼 추가하기


--2) 컬럼의 데이터크기 변경하기


--3) 컬럼 이름 변경하기
--loc => area로 변경



--cf. 테이블 이름 변경하기



--4) 컬럼 삭제하기

