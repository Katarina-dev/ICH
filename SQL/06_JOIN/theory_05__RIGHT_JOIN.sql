/* RIGHT JOIN (RIGHT OUTER JOIN) возвращает все строки из правой таблицы (departments),
даже если нет соответствий в левой таблице (employees).
Если соответствий нет, возвращаются NULL */

USE 050824_learning_join_command;

SELECT * FROM employees;
SELECT * FROM departments;

SELECT
    e.name, d.department_name
FROM
    employees AS e
        RIGHT JOIN
    departments AS d ON e.department_id = d.id;