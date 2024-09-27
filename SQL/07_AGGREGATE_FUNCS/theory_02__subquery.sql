/* Вывести 4 поля: имя, фамилия, ЗП и средняя ЗП всех сотрудников */

SELECT AVG(salary) FROM hr.employees;

SELECT
    first_name, last_name, salary, AVG(salary)
FROM
    hr.employees;

SELECT
    first_name, last_name, salary,
	(SELECT AVG(salary) FROM hr.employees) AS avg_salary
FROM
    hr.employees;

SELECT
    first_name, last_name, salary,
	FORMAT((SELECT AVG(salary) FROM hr.employees), 2) AS avg_salary
FROM
    hr.employees;


/* Изменить предыдущий запрос так, чтобы выводились только сотрудники, чья ЗП выше среднего уровня */
SELECT
    first_name, last_name, salary,
	FORMAT((SELECT AVG(salary) FROM hr.employees), 2) AS avg_salary
FROM
    hr.employees
WHERE
    salary > (SELECT AVG(salary) FROM hr.employees);


/* ------------------------ как убрать избыточность из этого запроса? ----------------- */

-- с помощью создания переменной

SET @avg_salary = (SELECT AVG(salary) FROM hr.employees);

SELECT
    first_name, last_name, salary,
	FORMAT(@avg_salary, 2)
FROM
    hr.employees
WHERE
    salary > @avg_salary;

/* эти переменные хранятся в оперативной памяти ТОЛЬКО на время
текущей сессии, а значит не видны другим пользователям */


-- с помощью Общего Табличного Выражения CTE (Common Table Expression)

WITH avg_salary_cte AS (
    SELECT AVG(salary) AS avg_salary
    FROM hr.employees
)
SELECT
    first_name, last_name, salary,
    FORMAT(avg_salary_cte.avg_salary, 2) AS avg_salary
FROM
    hr.employees, avg_salary_cte
WHERE
    salary > avg_salary_cte.avg_salary;
