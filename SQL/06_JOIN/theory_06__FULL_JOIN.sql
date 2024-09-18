/* FULL JOIN (FULL OUTER JOIN) возвращает все строки из обеих таблиц,
заполняя NULL для тех строк, у которых нет соответствий.

ВНИМАНИЕ!!!
MySQL не поддерживает этот тип соединения напрямую,
но его можно симулировать с помощью UNION. */

USE 050824_learning_join_command;

SELECT * FROM employees;
SELECT * FROM departments;

SELECT
    e.name, d.department_name
FROM
    employees AS e
        LEFT JOIN
    departments AS d ON e.department_id = d.id
UNION
SELECT
    e.name, d.department_name
FROM
    employees AS e
        RIGHT JOIN
    departments AS d ON e.department_id = d.id;