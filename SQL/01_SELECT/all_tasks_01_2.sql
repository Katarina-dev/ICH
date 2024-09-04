/* 01. Найти всех сотрудников, работающих в департаменте с id 90 */
SELECT * FROM hr.employees WHERE department_id = 90;

/* 02. Найти всех сотрудников, зарабатывающих больше 5000 */
SELECT * FROM hr.employees WHERE salary > 5000;

/* 03. Найти всех сотрудников, чья фамилия начинается на букву L */
SELECT * FROM hr.employees WHERE last_name LIKE 'L%';

/* 04. Найти все департаменты, у которых location_id 1700 */

SELECT * FROM hr.departments WHERE location_id = '1700';

/* 05. Найти все города с country_id US (hr.locations) */
SELECT * FROM hr.locations WHERE country_id = 'US';

/* 06. Вывести зарплату сотрудника с именем ‘Lex’ и фамилией ‘De Haan' */
SELECT * FROM hr.employees WHERE first_name = 'Lex' AND last_name = 'De Haan';

/* 07. Вывести всех сотрудников с job_id ‘FI_ACCOUNT’ и зарабатывающих меньше 8000 */
SELECT * FROM hr.employees WHERE job_id = 'FI_ACCOUNT' AND salary < 8000;

/* 08. Вывести сотрудников, у которых в фамилии в середине слова встречаются сочетания ‘kk’ или ‘ll’ */
SELECT * FROM hr.employees WHERE last_name LIKE '%kk%' OR (last_name LIKE '%ll%');

/* 09. Вывести сотрудников с commission_pct NULL */
SELECT * FROM hr.employees WHERE commission_pct IS NULL;

/* 10. Вывести всех сотрудников кроме тех, кто работает в департаментах 80 и 110 */
SELECT * FROM hr.employees WHERE department_id NOT IN ('80', '10');

/* 11. Вывести сотрудников зарабатывающих от 5000 до 7000 (включая концы) */
SELECT * FROM hr.employees WHERE salary BETWEEN 5000 AND 7000;
