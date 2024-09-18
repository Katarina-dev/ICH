USE 050824_learning_join_command;

SELECT * FROM employees;
SELECT * FROM departments;

SELECT
    e.name, d.department_name
FROM
    employees AS e
        CROSS JOIN
    departments AS d;