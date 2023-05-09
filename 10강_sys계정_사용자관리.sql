--10강_sys계정_사용자관리.sql


--사용자 계정 정보 조회
select * from dba_users;

--데이터 파일에 대한 정보 조회
select * from dba_date_files;

--테이블스페이스에 대한 정보 조회
select * from dba_tablespaces;

/*
오라클 데이터베이스의 논리적 저장 구조
1) 데이터블럭(Data block) - 최소 저장단위
   데이터블럭의 default size : 8K
2) 익스텐트(Extent) - 8개의 데이터블럭이 모여서 하나의 익스텐트가 됨
3) 세그먼트(Segment) - 하나 이상의 익스텐트로 구성
4) 테이블스페이스(Tablespace) - 세그먼트들을 저장하는 논리적인 공간 이름

하나의 테이블스페이스는 최소 1개의 데이터파일(물리적 파일)로 구성됨
*/

--테이블스페이스 생성
/*
create tablespace 테이블스페이스명
datafile 데이터파일의 경로 size 크기
autoextend on next 크기 -- 자동 증가 옵션(선택)
*/

create tablespace tb_test1
datafile 'C:\mydata\tb_test1.dbf'   size 48m
autoextend on next 10m;

select * from dba_data_files;
select * from dba_tablespaces;

--
create tablespace tb_test2
datafile 'C:\mydata\tb_test2_01.dbf'   size 48m
autoextend on maxsize 1000m,
'C:\mydata\tb_test2_02.dbf'   size 48m
autoextend on maxsize 1000m,
'C:\mydata\tb_test2_03.dbf'   size 48m
autoextend on maxsize 1000m;

--테이블스페이스 제거
/*
    drop tablespace 테이블스페이스명;
    
    drop tablespace 테이블스페이스명
        including contents and datafiles;  --물리적인 데이터파일까지 삭제
*/
drop tablespace tb_test2
    including contents and datafiles;

--사용자 계정 만들기
/*
    create user 사용자이름
    identified by 비밀번호
    default tablespace 테이블스페이스명;
*/

alter session set "_ORACLE_SCRIPT" = true; 


--tb_test2 테이블스페이스를 사용하는 사용자계정 생성하기
create user testuser8
identified by testuser123
default tablespace tb_test1;


create user testuser1
identified by testuser123
default tablespace tb_test1;


create user testuser2
identified by testuser123
default tablespace tb_test1;

create user testuser3
identified by testuser123
default tablespace tb_test1;

create user testuser4
identified by testuser123
default tablespace tb_test1;

create user testuser5
identified by testuser123
default tablespace tb_test1;

create user testuser6
identified by testuser123
default tablespace tb_test1;

select * from dba_users
where username like '%TESTUSER%';

--권한 조회
select * from dba_sys_privs where grantee = 'TESTUSER1'; --권한조회
select * from dba_role_privs where grantee = 'TESTUSER1'; --롤 조회

--사용자에게 권한 부여하기
--grant 권한 to 사용자명;

--create session권한 부여(접속 권한)
grant create session to testuser1;


create table tbl_test1
(
    no  number primary key,
    name    varchar2(30)    
) tablespace tb_test1;


--테이블생성 권한 부여하기
grant create table to testuser1;


--권한박탈
--revoke 권한 from 사용자명;
revoke create session from testuser1;

--testuser2 사용자에게 resource, connect 롤 부여하기
grant resource, connect to testuser2;

select * from dba_sys_privs where grantee = 'TESTUSER2'; --권한조회
select * from dba_role_privs where grantee = 'TESTUSER2';

select * from dba_sys_privs where grantee = 'RESOURCE';
select * from dba_sys_privs where grantee = 'CONNECT';

select * from dba_sys_privs where grantee = 'HR';
select * from dba_role_privs where grantee = 'HR';


--사용자 삭제
--DROP USER 사용자이름
drop user testuser3;

--잠긴 계정 열기
--alter user 사용자ID account unlock;
alter user testuser2 account unlock;

--계정 잠그기
--alter user 사용자ID account lock;
alter user testuser2 account lock;

--기존 계정의 암호 변경하기
--alter user 사용자ID identified by 새로운암호;
alter user testuser2 identified by 123;

--오라클이 제공하는 role 조회
select * from dba_roles;

/*
롤(Role)
- 권한에 대한 부여와 관리를 보다 편리하게 하기 위해서 사용
- 권한의 그룹
- 롤 속에 여러 가지 권한을 넣어 두고 사용자에게 롤 하나를 주면 
  그 안에 있는 모든 권한을 다 받게 되는 것
*/
--testrole이라는 이름의 롤을 생성하고, 접속권한, 테이블생성권한 부여하기
--1) 롤 생성하기
create role testrole;

select * from dba_roles where rule = 'TESTROLE';
select * from dba_sys_privs where grantee = 'TESTROLE';

--2) 롤에 권한 부여하기
grant create session to testrole;
grant create table to testrole;

select * from dba_sys_privs where grantee = 'TESTROLE';
--3) testuser3 사용자에게 testrole 부여하기
create role testuser3;

grant testrole to testuser3;

select * from dba_sys_privs where grantee = 'TESTUSER3'
select * from dba_role_privs where grantee = 'TESTUSER3'

--전역 데이터베이스명 조회 - xe, orcl
select * from global_name; --xe



--object 권한 주기
--해당 object의 소유자 계정에서 권한을 부여하거나 박탈할 수 있다

--testuser3에게 hr계정의 employees 테이블을 조회하고, 수정할 수 있는 권한 부여
--(hr계정에서 처리 가능)
grant select on hr.employees to testuser3;

--select권한 박탈
revoke select on hr.employees from testuser3;

--update권한 부여
grant update on hr.employees to testuser3;

--update권한 박탈
revoke update on hr.employees from testuser3;


testuser3 계정에서 처리

select first_name from hr.employees where salary>=17000;

update hr.employees
set salary=20000
where employee_id=100; 


--with grant option
grant resource, connect to testuser4;




/*
    with grant option
    - 권한을 위임하는 기능
    또 다른 사용자에게 권한을 할당해 줄 수 있게 됨
    object 권한에서 사용
*/

    testuser3에서 처리
    grant select on hr.employees to testuser4;
    => testuser3계정이 testuser4계정에게 hr의 employees에 select할 수 있는
    권한을 부여함
    
    => testuser4로 접속해서 hr의 employees를 select하면 조회됨


--with admin option
/*
    - 권한을 위임하는 기능
    또 다른 사용자에게 권한을 할당해줄 수 있게 됨
    system 관련 권한에서 사용
*/

grant resource, connect to testuser5 with admin option;

/*
    testuser5로 접속해서 testuser6에게 resouce, connect 권한(롤) 부여하기
    grant resource, connect to testuser6;
*/
grant resource, connect to testuser6;

--data dictionary
/*
    - 데이터베이스 내에 저장된 모든 객체의 정보를 제공해 주는 테이블
    
    Data Dictionary의 종류
    1) DBA_XXX : 데이터베이스 관리를 위한 정보를 제공
    2) User_XXX : 자신이 생성한 object 정보를 제공
                  현재 데이터베이스에 접속한 사용자가 소유한 객체의 정보를 제공
    3) ALL_XXX : 자신이 생성한 object와 다른 사용자가 생성한 object 중에
                 자신이 볼 수 있는 정보를 제공
                 - 사용자가 접근 가능한 모든 스키마의 정보를 제공
                 - 권한을 부여받음으로써 가능
*/

--모든 자료 사전의 정보를 출력
select * from dictionary where table_name like '%USER_%';

--자료사전 테이블의 각 컬럼에 대한 설명을 출력
select * from dict_columns
where table_name = 'USER_CONS_COLUMNS';

select * from user_cons_columns;



--[1] user_xxx
grant select on hr.employees to testuser3 with grant option;

select * from user_objects;
select * from user_tables;
select * from user_constraints;
select * from user_cons_columns;
select * from user_indexes;
select * from user_ind_columns;
select * from user_sequences;
select * from user_views;
select * from user_source;


--[2] all_xxx
select owner, table_name from all_tables
where table_name = 'EMPLOYEES';

--[3] DBA_XXX
select * from dba_users;

select * from dba_data_files;
select * from dba_tablespaces;

select * from dba_rules;

select * from dba_sys_privs;
select * from dba_role_privs;

