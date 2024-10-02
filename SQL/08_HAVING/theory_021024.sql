select * from employees

/*1. Вывести сотрудников, чья ЗП больше, чем средняя ЗП по фирме
2. Вывести департаменты, где средняя ЗП по департаменту больше, чем средняя ЗП по фирме */

SET @avg_salary_company = (SELECT AVG(salary) from employees );

SELECT  first_name, last_name, salary, @avg_salary_company
from employees 
WHERE salary > @avg_salary_company;

SELECT  first_name, last_name, salary, @avg_salary_company
from employees 
group by department_id 
HAVING @avg_salary_company > 5000;


/* Создайте SQL запрос, который позволяет вывести информацию о населении стран в двух столбцах: 
 * 
 'CountryCode' и 'Население', где 'Население' представляет собой суммарное количество жителей всех городов в каждой стране.*/
SELECT * from country;
SELECT * from city;

SELECT CountryCode, SUM(Population) as 'SUM population'
from city
group by CountryCode;


-- Отобразите результат аналогично заданию 1, однако вместо 'CountryCode' включите названия стран. 
-- Для этого примените операцию JOIN между таблицами 'city' и 'country', используя условие соединения 'city.CountryCode = country.Code'.

SELECT ci.CountryCode, SUM(ci.Population) as 'SUM population', co.Name
from city ci
join country co
on ci.CountryCode = co.Code
group by CountryCode
order by co.Name;

-- Предоставьте список стран, указав количество используемых языков в каждой из них, выводя отчёт в формате (CountryCode, COUNT(Language)). 
SELECT * FROM countrylanguage;

SELECT co.Code, co.Name, COUNT(cl.Language) as 'Count language', GROUP_CONCAT(cl.Language SEPARATOR ', ') 
from country co
join countrylanguage cl 
on co.Code = cl.CountryCode 
GROUP BY cl.CountryCode;

-- Измените третий запрос таким образом, чтобы вместо 'CountryCode' выводилось название страны.

SELECT co.Name, COUNT(cl.Language) as 'Count language', GROUP_CONCAT(cl.Language SEPARATOR ', ') as 'языки'
from country co
join countrylanguage cl 
on co.Code = cl.CountryCode 
GROUP BY cl.CountryCode;


-- Выведите количество сотрудников, работающих в отделах Marketing и IT, используя операцию JOIN между таблицами "employees" и "departments" по полю "department_id"

select de.department_name, COUNT(em.employee_id)
from
departments de
left join employees em
on de.department_id = em.department_id 
-- where de.department_name IN ('Marketing', 'IT')
group by de.department_name
HAVING de.department_name IN ('Marketing', 'IT');

-- Посчитайте сумму зарплат всех сотрудников.

SELECT SUM(salary) from employees; 

-- 3. Посчитайте сумму зарплат сотрудников, работающих в IT.

SELECT de.department_name, SUM(em.salary)
from employees em 
join departments de
on em.department_id = de.department_id 
WHERE de.department_name = 'IT';


SELECT de.department_name, SUM(em.salary)
from employees em 
join departments de
on em.department_id = de.department_id 
GROUP BY de.department_name
HAVING de.department_name = 'IT';

/*------------------------------------------------------------------------------------*/


SELECT * from Students;
SELECT * from Teachers;
SELECT * from Courses;
SELECT * FROM Students2Courses;
SELECT * FROM Teachers2Competencies;
SELECT * FROM Competencies;


-- 1. Выведите имена студентов и id курса, которые они проходят.

SELECT s.first_name, sc.course_id  FROM Students s 
join Students2Courses sc
on s.id = sc.student_id;

-- 2. Измените запрос в задании 1 так, чтобы выводились имена студентов и названия курсов, которые они проходят

SELECT s.first_name, sc.course_id, c.title FROM Students s 
join Students2Courses sc
on s.id = sc.student_id
join Courses c 
on c.id = sc.course_id;

-- 3. Вывести имена всех преподавателей с их компетенциями. Подсказка: сначала выведите имена преподавателей с id компетенции. 
-- А потом поменяйте запрос так (добавив еще один джойн), чтобы выводились имена преподавателей и названия компетенций.

SELECT t.name, co.title from Teachers t 
join Teachers2Competencies tc 
on t.id = tc.teacher_id 
JOIN Competencies co
on co.id = tc.competencies_id ;


-- 4. Найти преподавателя, у которого нет компетенций

SELECT 
    t.name
FROM
    Teachers AS t
        LEFT JOIN
    Teachers2Competencies AS tc ON t.id = tc.teacher_id
WHERE
    tc.competencies_id IS NULL;
    
   -- 5. Найти имена студентов, которые не проходят ни один курс
   
   SELECT 
    s.first_name
FROM
    Students s
        LEFT JOIN
    Students2Courses sc ON s.id = sc.student_id 
WHERE
    sc.course_id  IS NULL;
    
   -- 6. Найти курсы, которые не посещает ни один студент
   
     
    SELECT 
    crs.title, s2c.course_id
FROM
    Courses AS crs
        LEFT JOIN
    Students2Courses AS s2c ON crs.id = s2c.course_id
WHERE
    s2c.course_id IS NULL;
    
   -- 7. Найти компетенции, которых нет ни у одного преподавателя
   
   SELECT c.title from Competencies c 
   left join Teachers2Competencies tc
   on c.id = tc.competencies_id 
   WHERE tc.teacher_id is NULL;
   
  -- 8. Вывести название курса и имя старосты
  
  SELECT c.title, s.first_name from Courses c 
  join Students s 
  on c.headman_id = s.id; 
  
 -- 9. Отобразить имена студента и старост, на которых они обучается.
 
SELECT 
	s.first_name as student_name, sh.first_name as headman_on_course, c.title
    FROM Students as s 
    JOIN 
    Students2Courses as s_cs ON s.id=s_cs.student_id
    JOIN 
	Courses AS c ON c.id = s_cs.course_id
	JOIN 
    Students as sh ON sh.id=c.headman_id;
  
 
 /*-------------------------------------------------------------------------------*/
 
 
 SELECT * from employees

 /*Посчитать количество менеджеров в каждом отделе у которых количество подчиненных больше 2.
Подсказки: 
a.) если запрос возвращает один столбец, то он может рассматриваться как список;
b.) используйте having, для фильтрации отделов, где подчинённых у менеджера > 2. */
   
--     select m.department_id, m.employee_id, COUNT(e.employee_id) as 'Count of employees' 
--     from employees as e
--     inner join employees as m
--     on e.manager_id = m.employee_id
--     group by m.employee_id
--     HAVING COUNT(e.employee_id) > 2
--    -- group by m.department_id;
-- --     ORDER BY m.department_id;
--    
   /*----------------------------------------------------------------------*/
   
   select department_id, COUNT(distinct manager_id) as manager_count from  employees AS e
where e.manager_id in
(select manager_id from employees group by manager_id having COUNT(employee_id) > 2)
group by department_id;


select manager_id, COUNT(employee_id) from employees group by manager_id;
select manager_id, COUNT(employee_id) from employees group by manager_id having COUNT(employee_id) > 2;

/*----------------------------------*/

   
   SELECT 
    department_id, COUNT(manager_id)
FROM
    hr.employees
WHERE manager_id in (SELECT 
    manager_id
FROM
    employees
GROUP BY manager_id
HAVING COUNT(employee_id) > 2)
GROUP BY department_id;
   
   
   /*---------------------------------------------------------------------------------------------------------*/
   
  -- 1. Вывести все поездки (trips) с указанием названия airliner
   
  SELECT * FROM trips;
  SELECT * FROM airliners;
   
 SELECT t.*, a.model_name FROM trips t
 join airliners a 
 on t.airliner_id = a.id;
 
-- 2. Вывести все билеты, с указанием имени клиента

SELECT * FROM tickets;
SELECT * FROM clients;

SELECT t.*, c.name from clients c 
join tickets t 
on c.id = t.client_id;

-- 3. Вывести количество поездок по каждому airliner с указанием названия типа самолета

SELECT 
