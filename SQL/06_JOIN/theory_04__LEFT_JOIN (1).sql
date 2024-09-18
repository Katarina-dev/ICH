/* LEFT JOIN (LEFT OUTER JOIN) возвращает все строки из левой таблицы (employees),
даже если нет соответствий в правой таблице (departments).
Если соответствий нет, возвращаются NULL */

USE 050824_learning_join_command;

SELECT * FROM employees;
SELECT * FROM departments;

SELECT
    e.name, d.department_name
FROM
    employees AS e
        LEFT JOIN
    departments AS d ON e.department_id = d.id;