/* 1) Написать запрос, возвращающий всех сотрудников, c job_id = IT_PROG. (Не подглядывая в классный конспект с решением, но подглядывая в схему базы данных https://github.com/it-career-hub/MySQL_databases/blob/main/hr_data.sql)*/
SELECT * FROM hr.employees WHERE job_id = 'IT_PROG';

/* 2) Изменить запрос так, чтобы вывести всех сотрудников с job_id равной AD_VP*/
SELECT * FROM hr.employees WHERE job_id = 'AD_VP';

/* 3) Изменить запрос так, чтобы вывести всех сотрудников с job_id равной AD_VP*/
SELECT * FROM hr.employees WHERE job_id = 'IT_PROG';
SELECT * FROM hr.employees WHERE job_id = 'AD_VP';

/* 4) a. Найдите сотрудников, с зп от 10 000 до 20 000 (включая концы)*/
SELECT * FROM hr.employees WHERE salary BETWEEN 10000 AND 20000;

/* b. Найдите сотрудников не из 60, 30 и 100 департамента*/
SELECT * FROM hr.employees WHERE  department_id NOT IN ('60','30','100');

/* c. Найдите сотрудников у которых есть две буквы ll подряд в середине имени*/
SELECT * FROM hr.employees WHERE first_name LIKE '%ll%';

/* d. Найдите сотрудников, у которых фамилия кончается на a*/
SELECT * FROM hr.employees WHERE last_name LIKE '%a';

/* 5) Найти всех сотрудников с зарплатой выше 10000*/
SELECT * FROM hr.employees WHERE salary > 10000;

/* 6) Найти всех сотрудников с зарплатой выше 10000 и чья фамилия начинается на букву L*/
SELECT * FROM hr.employees WHERE salary > 10000 AND last_name LIKE 'L%';

/* 7) Не выполняя запрос к базе данных, предсказать его результат: select	*  from employees where salary > 10000 or salary <= 10000;*/
/* Запрос выведет сотрудников с зарплатой больше 10000 (не включая 10000) или с зарплатой меньше 10000 (включая 10000) */

/* 8) Ответить в 1 предложении: чем он будет отличаться от результата этого запроса? select	*  from employees where salary > 10000 or salary < 10000; */
/* В этом запросе в обоих условиях выведенные значения не будут включать зарплату в 10000  */

/* 9) Не выполняя запрос к базе, предсказать результат. select	*  from employees where salary > 10000 and salary < 5000;  */
/*Запрос выведет всех сотрудников с зарплатой больше 10000 (не включая 10000) и меньше 10000 (не включая 10000)  */

