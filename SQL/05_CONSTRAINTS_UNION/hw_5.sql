/* 1.Подключиться к базе данных world (которая находится на удаленном сервере). 
2. Посмотреть на таблицы city, country из базы world. В каждой таблице есть поле название (Name) и население (Population). 
Поле Name в одной таблице означает название города, а в другой - название страны. Написать запрос с помощью UNION, 
который выводит список названий всех городов и стран с их населением. Итоговая выборка должна содержать два столбца: Name, Population.*/ 

select * from world.city;
select * from world.country;

select Name, Population from world.city
union 
select Name, Population from world.country;

/* 3.Посмотреть на таблицы в базе world и объяснить ограничения нескольких столбцов - ответить 1 предложением.
В таблице world.country есть ограничение на поле Continent. В нем можно указать только одно из указанных в условии значений, чтобы пользователь по ошибке не
смог указать континент неправильно: 
`Continent` enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') NOT NULL DEFAULT 'Asia',
Также, в таблице world.city есть ограничение на поле CountryCode, т.к. оно явяется внешним ключом, по которому связаны таблицы country и city. */

/* 4. Далее работаем на локальном сервере. Создать новую таблицу citizen, которая содержит следующие поля: 
уникальное автоинкрементное, номер соц страхования, имя, фамилию и емейл.
5. На вашем локальном сервере в любой базе создать таблицу без ограничений (любую, можно взять с урока). */

create table if not exists citizen (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
insurance_num integer,
first_name varchar(128),
last_name varchar(128),
email varchar(128)
);

/* 6. Добавить в таблицу 5 значений. Добавить 3 человека с одинаковыми именами и 2 человека без lastname*/

insert into citizen (insurance_num, first_name, last_name, email) values (123, 'Sasha', 'Zhukov', 'Zhukov@gmail.com');
insert into citizen (insurance_num, first_name, last_name, email) values (454, 'Sasha', 'Laptev', 'Laptev@gmail.com');
insert into citizen (insurance_num, first_name, last_name, email) values (190, 'Sasha', 'Konin', 'Konin@gmail.com');
insert into citizen (insurance_num, first_name, last_name, email) values (454, 'Petya', '', 'Petya@gmail.com');
insert into citizen (insurance_num, first_name, last_name, email) values (190, 'Gosha', '', 'Gosha@gmail.com');

/* 7. Использовать оператор alter table … modify , чтобы добавить ограничение not null на поле firstname и lastname. */
ALTER TABLE citizen
MODIFY first_name VARCHAR(30) NOT NULL;

ALTER TABLE citizen
MODIFY last_name VARCHAR(30) NOT NULL;

insert into citizen (insurance_num, first_name, last_name, email) values (200, null, null, 'sha@gmail.com');

/* 8. Добавить ограничение unique для пары firstname\lastname.*/

ALTER TABLE citizen
ADD CONSTRAINT unique_constraint_name
UNIQUE (first_name, last_name);

insert into citizen (insurance_num, first_name, last_name, email) values (23, 'Sasha', 'Konin', 'Knin@gmail.com');


/*9. Удалить таблицу из базы и пересоздать ее, модифицировав запрос add table так, чтобы он учитывал ограничения (см примеры из класса).*/

drop table citizen;

create table if not exists citizen (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
insurance_num integer,
first_name varchar(128) NOT NULL UNIQUE,
last_name varchar(128) NOT NULL UNIQUE,
email varchar(128)
);

 /*10. Добавить правильные и неправильные данные (нарушающие и не нарушающие ограничения).*/

insert into citizen (insurance_num, first_name, last_name, email) values (123, 'Sasha', 'Zhukov', 'Zhukov@gmail.com');
insert into citizen (insurance_num, first_name, last_name, email) values (454, 'Sasha', 'Laptev', 'Laptev@gmail.com');
insert into citizen (insurance_num, first_name, last_name, email) values (190, 'Sasha', 'Konin', 'Konin@gmail.com');
insert into citizen (insurance_num, first_name, last_name, email) values (454, 'Petya', null, 'Petya@gmail.com');
insert into citizen (insurance_num, first_name, last_name, email) values (543, null, 'Makin', 'maki@gmail.com');
insert into citizen (insurance_num, first_name, last_name, email) values (788, 'Kolya', 'Zhukov', 'zh@gmail.com');
insert into citizen (insurance_num, first_name, last_name, email) values (786, 'Sveta', 'Zhukova', 'Zhukova@gmail.com');

select * from citizen;
