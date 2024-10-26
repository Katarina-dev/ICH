SELECT * FROM employees;
SELECT * FROM departments;

SELECT department_id, COUNT(*) as employee_cnt
from employees 
group by department_id 
HAVING employee_cnt > 10;

SELECT department_id, employee_cnt 
FROM
	(SELECT department_id, COUNT(*) as employee_cnt
	from employees 
	group by department_id) AS t
WHERE employee_cnt > 10;

-- 2. Измените предыдущий запрос, чтобы выводилось название отдела.
-- c HAVING

SELECT department_name, COUNT(*) as employee_cnt
from employees e
JOIN departments d 
ON d.department_id = e.department_id 
group by department_name 
HAVING employee_cnt > 10;


-- без HAVING

SELECT department_name, employee_cnt 
FROM
	(SELECT department_id, COUNT(*) as employee_cnt
	from employees 
	group by department_id) AS t
		JOIN 
	departments d ON d.department_id = t.department_id 
WHERE employee_cnt > 10;

select
	t.department_name, employee_count
from
	(select
		de.department_name, count(*) employee_count
	from
		hr.employees as em
			join
		hr.departments as de
		on em.department_id = de.department_id
	group by de.department_name) as t
where employee_count > 10;

-- 3. По каждому отделу выведите имена сотрудников, чья ЗП выше, чем в среднем по отделу.
-- c HAVING

SELECT e1.department_id, e1.last_name, e1.first_name, e1.salary from employees e1
group by e1.last_name, e1.department_id 
HAVING e1.salary > (SELECT AVG(e2.salary) from employees e2 WHERE e1.department_id = e2.department_id);


-- без HAVING

SELECT e1.department_id, e1.last_name, e1.first_name, e1.salary from employees e1
WHERE e1.salary > (SELECT AVG(e2.salary) from employees e2 WHERE e1.department_id = e2.department_id);



-- ============================== WORLD =====================================

SELECT * FROM world.city;
SELECT * FROM world.country;
SELECT * FROM world.countrylanguage;

-- Подключите базу world

-- 4. Найдите среднее население городов в каждой стране.

SELECT CountryCode, AVG(Population) FROM city 
group by CountryCode; 


-- 5. Оставьте только те страны, где средняя численность городского населения больше 100 000 (с HAVIG и без HAVIG)
-- c HAVING
SELECT CountryCode, avg(Population) as avg_population
FROM city c group by CountryCode 
HAVING  avg_population > 100000


-- без HAVING
SELECT t.CountryCode, t.avg_population
from 
	(SELECT CountryCode, avg(Population) as avg_population
	FROM city c group by CountryCode) as t 
WHERE t.avg_population > 100000;

-- 6. Определить страны (только код страны), в которых говорят на более чем трех языках (с HAVIG и без HAVIG)

-- c HAVING
SELECT CountryCode, COUNT(*) as lang_cnt from countrylanguage c
group by CountryCode 
HAVING lang_cnt > 3

-- без HAVING
SELECT * FROM 
	(SELECT CountryCode, COUNT(*) as lang_cnt from countrylanguage c
	group by CountryCode) as t 
WHERE  t.lang_cnt > 3;


-- 7. В предыдущем запросе заменить код страны на её название (с HAVIG и без HAVIG)
SELECT c2.Name, COUNT(*) as lang_cnt from countrylanguage c
JOIN country c2 
ON c2.Code = c.CountryCode 
GROUP by c2.Name 
HAVING lang_cnt > 3;

SELECT * FROM (SELECT c2.Name, COUNT(*) as lang_cnt from countrylanguage c
JOIN country c2 
ON c2.Code = c.CountryCode 
GROUP by c2.Name) as t
WHERE  lang_cnt > 3;


-- 8. Определить среднюю продолжительность жизни по континентам
SELECT Continent, AVG(LifeExpectancy) as avg_life FROM country c 
group by Continent;



-- 9. Вывести только те континенты, где средняя продолжительность жизни превышает 70 лет (с HAVIG и без HAVIG)

-- c HAVING

SELECT Continent, AVG(LifeExpectancy) as avg_life FROM country c 
group by Continent;

-- без HAVING

-- 10. Найдите страны (названия) с суммарным населением городов больше 10 миллионов.ALTER (с HAVIG и без HAVIG)

-- c HAVING

SELECT co.Name, SUM(ci.Population) as sum_popul from city ci
JOIN country co
ON ci.CountryCode = co.Code 
GROUP BY co.Name 
HAVING sum_popul > 10000000;

-- без HAVING

-- 11. Определить страны, у которых ВВП (GNP) меньше среднего по их континенту

-- 12. Найти страны, где более половины населения живет в столице

SELECT * FROM city;
SELECT * FROM country;

-- c HAVING

-- без HAVING

-- 13. Определить континенты с суммарным населением больше миллиарда
-- c HAVING

-- без HAVING.

-- 14. Найти языки, на которых говорит более 10% населения хотя бы одной страны
-- c HAVING

-- без HAVING

-- 15. Определить страны, у которых площадь больше средней по их континенту
-- c HAVING

-- без HAVING

-- 16. Найти города с населением больше среднего по стране

-- c HAVING

-- без HAVING
