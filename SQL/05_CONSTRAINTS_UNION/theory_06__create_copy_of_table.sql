USE 050824_hr;

CREATE TABLE new_students_777 AS
    (SELECT
        employee_id, first_name, last_name, email
    FROM
        employees);


