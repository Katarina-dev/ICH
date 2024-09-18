-- Подключитесь к базе данных world (которая находится на удаленном сервере). 
use world;

-- Выведите список стран с языками, на которых в них говорят.
select * from country;
select * from countrylanguage;

select c.name, l.language
from country c
join countrylanguage l
on c.Code = l.CountryCode;

-- Выведите список городов с их населением и названием стран
select * from city;
select ci.Name, ci.Population, co.Name
from city ci
join country co
on ci.CountryCode = co.Code;

-- Выведите список городов в South Africa
select co.Name as Country, ci.Name as City
from country co
join city ci
on ci.CountryCode = co.Code
where co.Name = 'South Africa';

-- Выведите список стран с названиями столиц. Подсказка: в таблице country есть поле Capital, которое содержит номер город из таблицы City. 

select co.Name, ci.Name
from country co
join city ci
on co.Capital = ci.ID;

-- Измените запрос 4 таким образом, чтобы выводилось население в столице. 
select co.Name, ci.Name, ci.Population as Population_of_Capital
from country co
join city ci
on co.Capital = ci.ID;

-- Напишите запрос, который возвращает название столицы United States
select co.Name, ci.Name, ci.Population as Population_of_Capital
from country co
join city ci
on co.Capital = ci.ID
where co.Name = 'United States';

-- Используя базу hr_data.sql, вывести имя, фамилию и город сотрудника.
use hr;

select * from employees;
select * from departments;
select * from locations;

select e.last_name, e.first_name, l.city 
  from employees e
  join departments d 
  on e.department_id = d.department_id 
  join locations l
  on d.location_id = l.location_id;
  
-- Используя базу hr_data.sql, вывести города и соответствующие городам страны.
select ci.city, co.country_name
from countries co
join locations ci
on ci.country_id = co.country_id;
