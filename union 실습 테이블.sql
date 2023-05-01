drop table set1;
create table set1(
    id1 number,
    name1   char(10)
);

drop table set2;
create table set2(
    id2 number,
    name2   char(10),
    age number
);

insert into set1(id1, name1) values(1, 'AAA');
insert into set1(id1, name1) values(1, 'AAA');
insert into set1(id1, name1) values(2, 'BBB');

insert into set2(id2, name2, age) values(2, 'BBB',20);
insert into set2(id2, name2, age) values(3, 'CCC',15);
insert into set2(id2, name2, age) values(3, 'CCC',23);

commit;