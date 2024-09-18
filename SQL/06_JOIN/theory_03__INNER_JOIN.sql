/* INNER JOIN (или просто JOIN) соединяет только те строки,
которые имеют соответствие в обеих таблицах. */

USE 050824_learning_join_command;

SELECT * FROM employees;
SELECT * FROM departments;

SELECT
    e.name, d.department_name
FROM
    employees AS e
        INNER JOIN
    departments AS d ON e.department_id = d.id;