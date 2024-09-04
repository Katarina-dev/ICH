SELECT 5*5;

/* 01. Найти всех сотрудников, c job_id = IT_PROG */
SELECT * FROM hr.employees WHERE job_id = 'IT_PROG';

/* 02. Найти сотрудников, с зп больше 10 000 */
SELECT * FROM hr.employees WHERE salary > '10 000';

/* 03. Найти сотрудников, с зп от 10 000 до 20 000 (включая концы) */
SELECT * FROM hr.employees WHERE salary BETWEEN 10000 AND 20000;

/* 04. Найти сотрудников не из 60, 30 и 100 департамента */
SELECT * FROM hr.employees WHERE department_id NOT IN ('60', '30', '100');

/* 05. Найти сотрудников у которых есть две буквы ll подряд в середине имени */
SELECT * FROM hr.employees WHERE first_name LIKE '%ll%';

/* 06. Найти сотрудников, у которых фамилия кончается на a) */
SELECT * FROM hr.employees WHERE last_name LIKE '%a';