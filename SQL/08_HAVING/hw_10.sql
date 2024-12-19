
-- Подключиться к базе данных world
use world;

-- Вывести население в каждой стране. Результат содержит два поля: CountryCode, sum(Population). #Запрос по таблице city.
select CountryCode, sum(Population) as Population from city
group by CountryCode;

-- Изменить запрос выше так, чтобы выводились только страны с населением более 3 млн человек. 
select CountryCode, sum(Population) as Population from city
group by CountryCode having Population > 3000000;

-- Сколько всего записей в результате?
-- Ответ: в результате запроса выводится 59 записей из 232

-- Поменять запрос выше так, чтобы в результате вместо кода страны выводилось ее название. 
-- Подсказка: нужен join таблиц city и country по полю CountryCode.
select * from city;
select * from country;

select co.Name, sum(ci.Population) as Population from city as ci
inner join country as co on ci.CountryCode = co.Code
group by co.Name having Population > 3000000;

-- Вывести количество городов в каждой стране (CountryCode, amount of cities). 
-- Подсказка: запрос по таблице city и группировка по CountryCode.
select CountryCode, count(name) as amount_of_cities from city
group by CountryCode;

-- Поменять запрос так, чтобы вместо кодов стран, было названия стран. 
select co.Name, count(ci.name) as amount_of_cities from city as ci
inner join country as co on ci.CountryCode = co.Code
group by co.Name;

-- Поменять запрос так, чтобы выводилось среднее количество городов в стран 
select avg(amount_of_cities) as avg_of_cities
from (
select co.Name, count(ci.name) as amount_of_cities from city as ci
inner join country as co on ci.CountryCode = co.Code
group by co.Name) as t;


SELECT * FROM users