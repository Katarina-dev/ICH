USE ekmi;

create table if not exists Students (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
first_name varchar(128) NOT NULL,
last_name varchar(128) NOT NULL,
age integer check (age >= 16 and age <= 60)
);

ALTER TABLE Students
ADD email varchar(128) UNIQUE;

insert into Students (first_name, last_name, age, email) values ('Vasiliy', 'Petrov', 17, 'petrov@gmail.com');
insert into Students (first_name, last_name, age, email) values ('Fedor', 'Ivanov', 34, 'ivanov@gmail.com');
insert into Students (first_name, last_name, age, email) values ('Elena', 'Mislenko', 17, 'mislenko@gmail.com');
insert into Students (first_name, last_name, age, email) values ('Darya', 'Lukova', 25, 'lukova@gmail.com');

select * from Students;

ALTER TABLE Students
ADD CONSTRAINT unique_constraint_name
UNIQUE (first_name, last_name);

insert into Students (first_name, last_name, age, email) values ('Darya', 'Lukova', 27, 'darya@gmail.com');

SHOW CREATE TABLE Students;

create table
new_students as select * from 050824_hr.new_students;

select first_name, last_name from Students
union all
select first_name, last_name from new_students;


-- drop table Students;