drop table product purge ;

CREATE TABLE product
( p_code  number(3) primary key,
  p_name varchar2(20) not null ,
  p_price  number,
  p_code_new  number(3) null,
  del_yn    char(1) default  'N'
  ) ;


insert into product(p_code, p_name, p_price) values (100,'»õ¿ìÂ¯',800);
insert into product(p_code, p_name, p_price)  values (101,'°¨ÀÚÂ¯',900);
insert into product(p_code, p_name, p_price)  values (102,'¸ÀÅ«»ê',1000);
insert into product(p_code, p_name, p_price)  values (103,'¿¡ÀÌ¼­',900);
insert into product(p_code, p_name, p_price)  values (104,'¸ÀÂ¯±¸',800);
insert into product(p_code, p_name, p_price)  values(105,'»þº¸·¹',1500);
insert into product values (106,'ÄÜÂý',900, 201, 'Y');
insert into product values (107,'µµ¸®Åä¸®',800, 202, 'Y');
insert into product values(108,'Æ÷Å×Åä',1500, 203, 'Y');

commit;


drop table panmae purge ;

create table panmae
( p_date varchar2(8) not null,
  p_code number not null,
  p_qty  number ,
  p_total number ,
  p_store varchar2(5) );


insert into panmae values ('20110101',100,3,2400,'1000');
insert into panmae values ('20110101',101,5,4500,'1001');
insert into panmae values ('20110101',102,2,2000,'1003');
insert into panmae values ('20110101',103,6,5400,'1004');
insert into panmae values ('20110102',102,2,2000,'1000');
insert into panmae values ('20110102',103,5,4500,'1002');
insert into panmae values ('20110102',104,3,2400,'1002');
insert into panmae values ('20110102',105,2,3000,'1000');
insert into panmae values ('20110103',100,10,8000,'1004');
insert into panmae values ('20110103',100,2,1600,'1000');
insert into panmae values ('20110103',100,3,2400,'1001');
insert into panmae values ('20110103',101,4,3600,'1003');
insert into panmae values ('20110104',100,2,1600,'1002');
insert into panmae values ('20110104',100,4,3200,'1003');
insert into panmae values ('20110104',100,5,4000,'1004');
insert into panmae values ('20110104',101,3,2700,'1001');
insert into panmae values ('20110104',101,4,3600,'1002');
insert into panmae values ('20110104',101,3,2700,'1003');
insert into panmae values ('20110104',102,4,4000,'1001');
insert into panmae values ('20110104',102,2,2000,'1002');
insert into panmae values ('20110104',103,2,1800,'1003');

insert into panmae values ('20110105',106,3,2700,'1003');
insert into panmae values ('20110105',107,4,4000,'1001');
insert into panmae values ('20110106',107,2,2000,'1002');
insert into panmae values ('20110107',108,2,1800,'1003');

commit;
