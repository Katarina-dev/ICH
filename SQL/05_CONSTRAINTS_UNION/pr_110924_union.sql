use ich;

CREATE TABLE if not exists goods (
id integer primary key,
title varchar(30),
quantity integer check (quantity > 0),
in_stock char(1) check (in_stock in ('Y', 'N'))
);

insert into goods (id, title, quantity, in_stock) values (1, 'Велосипед', 2, 'Y');
insert into goods (id, title, quantity, in_stock) values (2, 'Скейт', 4, 'Y');
insert into goods (id, title, quantity, in_stock) values (3, 'Самокат', 2, 'Y');
insert into goods (id, title, quantity, in_stock) values (4, 'Сноуборд', 7, 'N');
insert into goods (id, title, quantity, in_stock) values (5, 'Санки', 1, 'Y');
insert into goods (id, title, quantity, in_stock) values (6, 'Коньки', 3, 'N');
insert into goods (id, title, quantity, in_stock) values (7, 'Ролики', 5, 'Y');

select * from goods;

CREATE TABLE if not exists goods_2 (
id integer primary key,
title varchar(30),
quantity integer check (quantity > 0),
price integer,
in_stock char(1) check (in_stock in ('Y', 'N'))
);

insert into goods_2 (id, title, quantity, price, in_stock) values (1, 'Тюбинг', 5,
1000, 'Y');
insert into goods_2 (id, title, quantity, price, in_stock) values (2, 'Санки', 2,
1500, 'Y');
insert into goods_2 (id, title, quantity, price, in_stock) values (3, 'Снегокат', 2,
900, 'Y');
insert into goods_2 (id, title, quantity, price, in_stock) values (4, 'Сноуборд', 7,
700, 'N');
insert into goods_2 (id, title, quantity, price, in_stock) values (5, 'Клюшка', 8,
300, 'Y');
insert into goods_2 (id, title, quantity, price, in_stock) values (6, 'Коньки', 3,
350, 'N');
insert into goods_2 (id, title, quantity, price, in_stock) values (7, 'Форма', 9, 450,
'Y');

select * from goods_2;

select title from goods
UNION ALL
select title from goods_2;

select title from goods
UNION
select title from goods_2;

select id, title, quantity, null as price from goods
UNION
select id, title, quantity, price from goods_2;


create table new_students as
	(select * 
    from 
    students);
    
select * from new_students;
    
-- drop table competencies;