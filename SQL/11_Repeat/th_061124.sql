SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM jobs;
SELECT * FROM locations;
SELECT * FROM regions;

-- 1. Найти количество сотрудников у каждого менеджера. Вывести manager_id и employees_cnt
-- c OVER()
-- без OVER()

SELECT manager_id, COUNT(*) as employees_cnt from employees 
group by manager_id 
order by manager_id 

SELECT DISTINCT manager_id, COUNT(*) OVER(PARTITION BY manager_id) as employee_cnt
FROM employees

/* 2. Работаем с базой World. Выведите седьмой по густонаселенности город.
	Подсказка: использовать функцию rank() и оконные функции. */
-- c OVER()
-- без OVER()

SELECT * FROM city



SELECT *
FROM (
SELECT Name, Population, DENSE_RANK() OVER(ORDER BY Population DESC) as RN from city) as t
WHERE t.RN = '7';


SELECT * FROM 
(SELECT Name, Population from city order by Population DESC LIMIT 7) as t
ORDER BY Population
LIMIT 1


-- 3. Выведите название города, население и максимальное население для каждого города
-- c OVER()
-- без OVER()

SELECT 
	Name, 
	Population, 
	CountryCode, 
	MAX(Population) OVER(PARTITION BY CountryCode) as max_population
FROM city order by CountryCode 

SELECT Name, Population,
(SELECT max(Population) from city) as max_population
from city 
