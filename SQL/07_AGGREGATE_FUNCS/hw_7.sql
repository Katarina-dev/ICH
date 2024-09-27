-- 1.Подключитесь к базе данных hr (которая находится на удаленном сервере). USE hr;
-- 2. Выведите количество сотрудников в базе

select count(*) from employees;

-- 3. Выведите количество департаментов (отделов) в базе

select count(*) from departments;

-- 4. Подключитесь к базе данных World (которая находится на удаленном сервере).
-- 5. Выведите среднее население в городах Индии (таблица City, код Индии - IND).

select * from city;
select avg(Population) from city where CountryCode= 'IND';

-- 6. Выведите минимальное население в индийском городе и максимальное.
select min(Population), max(Population) from city where CountryCode = 'IND';

-- 7. Выведите самую большую площадь территории. 
select max(SurfaceArea) from country;

-- 8. Выведите среднюю продолжительность жизни по странам. 
select * from country;
select avg(LifeExpectancy) from country;

-- 9. Найдите самый населенный город (подсказка: использовать подзапросы)
select format(max(Population), 0) from city;

select Name from city where Population = (select max(Population) from city);

