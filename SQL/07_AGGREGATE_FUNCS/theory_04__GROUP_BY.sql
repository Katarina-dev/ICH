/* Нужно узнать сумму зарплат сотрудников в каждом отделе */

SELECT SUM(salary) FROM hr.employees;


SELECT
    SUM(salary)
FROM
    hr.employees
GROUP BY department_id;


SELECT
	department_id,
    SUM(salary)
FROM
    hr.employees
GROUP BY department_id;