USE hr;

-- 1. Используя https://github.com/it-career-hub/MySQL_databases/blob/main/hr_data.sql, вывести список всех сотрудников.
SELECT * FROM employees;

-- 2. Найти поле с зарплатой сотрудника. 
SELECT last_name, salary FROM employees;

-- 3. Используя операторы case/when/end, изменить запрос так, чтобы результатом был только один столбец, 
-- назовите его SALARY_GROUP и оно будет принимать значение 1 если зп сотрудника больше 10000 и значение 0, если меньше.
SELECT
CASE
WHEN salary > 10000 THEN '1'
-- WHEN salary <= 10000 THEN '0'
ELSE '0'
END AS SALARY_GROUP
FROM employees
ORDER BY SALARY_GROUP ASC;

-- 4. Ответить одним предложением: почему выводится только один столбец? 
-- Потому что после оператора SELECT указано значение CASE только для одного столбца, через запятую мы не перечисляли разные поля

-- 5. Изменить запрос, так, чтобы вывелось два столбца: имя сотрудника и новое поле SALARY_GROUP.
SELECT first_name, last_name,
CASE
WHEN salary > 10000 THEN '1'
-- WHEN salary <= 10000 THEN '0'
ELSE '0'
END AS SALARY_GROUP
FROM employees
ORDER BY SALARY_GROUP ASC;

-- 6. Вывести среднюю зарплату для департаментов с номерами 60, 90 и 100 используя составное условие.
SELECT AVG(salary) FROM employees WHERE department_id IN(60, 90, 100);

-- 7. Разделить уровни (level) сотрудников на junior < 10000, 10000<mid<15000, senior>15000 в зависимости от их зарплаты. Вывести список сотрудников (first_name, last_name, level).
SELECT *,
CASE 
WHEN salary < 10000 THEN 'JUNIOR'
WHEN salary > 15000 THEN 'SENIOR'
ELSE 'MIDDLE'
END AS level
FROM employees
ORDER BY level;

-- 8. Посмотреть содержимое таблицы jobs. Написать запрос c использованием оператора case/when/end, 
-- который возвращает 2 столбца: job_id, payer_rank, где столбец payer_rank формируется по правилу: 
-- если максимальная зарплата больше 10000, то “high_payer”, если меньше, то “low payer”. 
SELECT job_id,
CASE
WHEN salary > 10000 THEN 'high_payer'
ELSE 'low_payer'
END AS payer_rank
FROM employees
ORDER BY payer_rank;

-- 9. Переписать этот запрос с использованием оператора IF.
SELECT job_id, IF(salary <10000, 'low_payer', 'high_payer') AS payer_rank FROM employees ORDER BY payer_rank;

-- 10. Поменять предыдущий запрос так, чтобы выводилось 3 столбца, к двум существующим добавьте max_salary и отсортировать результат по убыванию. 
SELECT job_id, IF(salary <10000, 'low_payer', 'high_payer') AS payer_rank, MAX(salary) AS max_salary FROM employees ORDER BY payer_rank DESC;
