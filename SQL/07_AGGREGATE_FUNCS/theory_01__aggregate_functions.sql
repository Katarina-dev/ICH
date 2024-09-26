USE hr;

SELECT * FROM employees;

/* ------------------ COUNT ------------------------*/

SELECT COUNT(*) FROM employees;

SELECT commission_pct FROM employees; -- 78
SELECT commission_pct FROM employees WHERE commission_pct IS NOT NULL; -- 33
SELECT COUNT(commission_pct) FROM employees; -- 1 / 33

SELECT DISTINCT commission_pct FROM employees WHERE commission_pct IS NOT NULL; -- 7
SELECT DISTINCT COUNT(commission_pct) FROM employees WHERE commission_pct IS NOT NULL; -- 1 / 33
SELECT COUNT(DISTINCT commission_pct) FROM employees WHERE commission_pct IS NOT NULL; -- 7


/* ------------------ SUM ------------------------*/

SELECT SUM(salary) FROM employees; -- 553700.00

SELECT SUM(commission_pct) FROM employees; -- 7.55

SELECT SUM(first_name) FROM employees; -- 0


/* ------------------ MAX / MIN ------------------------*/

SELECT MAX(salary) FROM employees; -- 24000.00
SELECT MIN(salary) FROM employees; -- 2100.00

SELECT MAX(first_name) FROM employees; -- 'William'
SELECT MIN(first_name) FROM employees; -- 'Adam'

SELECT first_name FROM employees ORDER BY first_name ASC;
SELECT first_name FROM employees ORDER BY first_name DESC;


/* ------------------ AVG ------------------------*/

SELECT AVG(salary) FROM employees; -- 7098.717949

SELECT FORMAT(AVG(salary), 2) FROM employees; -- '7,098.72'


/* -------------- GROUP_CONCAT ------------------------*/

/* Вывести номер департамента и всех сотрудников, которые в нём работают так,
чтобы, все сотрудники были перечислены через запятую в одной ячейке в формате имя_фамилия */

SELECT
	department_id,
    GROUP_CONCAT(CONCAT(first_name, '_', last_name) SEPARATOR '\n') AS list_of_persons
FROM
    hr.employees
GROUP BY
    department_id;











