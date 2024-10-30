-- 1. Подключиться к базе данных hr

-- 2. Вывести список region_id, total_countries, где total_countries - количество стран в таблице.

SELECT * FROM countries

SELECT region_id, COUNT(*) OVER() as total_countries FROM countries 

/* 3. Изменить запрос 2 таким образом, чтобы для каждого region_id
      выводилось количество стран в этом регионе.
      Подсказка: добавить partition by region_id в over(). */

SELECT region_id, COUNT(*) OVER(PARTITION BY region_id) as total_countries FROM countries 

/* 4. Работа с таблицей departments. Написать запрос,
      который выводит location_id, department_name, dept_total,
      где dept_total - количество департаментов в location_id. */

SELECT * FROM departments

SELECT location_id, department_name, COUNT(*) OVER(PARTITION BY location_id) as dept_total FROM departments

-- 5. Изменить запрос 3 таким образом, чтобы выводились названия городов соответствующих location_id.

SELECT * FROM locations

SELECT l.city, d.department_name, COUNT(*) OVER(PARTITION BY l.city) as dept_total 
FROM departments d
JOIN locations l
ON d.location_id = l.location_id

/* 6. Работа с таблицей employees. Вывести manager_id, last_name, total_manager_salary,
      где total_manager_salary - общая зарплата подчиненных каждого менеджера (manager_id). */

SELECT DISTINCT manager_id,
	FIRST_VALUE (last_name) OVER(PARTITION BY manager_id) as last_name,
	SUM(salary) OVER (PARTITION BY manager_id) as total_manager_salary
FROM employees
WHERE manager_id IS NOT NULL 
