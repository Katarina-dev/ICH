/* 
Синтаксис формирования таблицы

CREATE TABLE <table_name> (
	<column1_name> <data_type>,
	<column2_name> <data_type>,
	<column3_name> <data_type>,
	...
    <columnN_name> <data_type>
);
 */



USE 050824_dam_ClassWork;

CREATE TABLE toys6 (
    toy_name VARCHAR(100),
    weight INTEGER
);

CREATE TABLE IF NOT EXISTS goods (
    title VARCHAR(30),
    quantity INTEGER,
    in_stock CHAR(1),
    arrival_date DATE
);

CREATE TABLE goods (
    title VARCHAR(30),
    quantity INTEGER,
    in_stock CHAR(1),
    arrival_date DATE
);