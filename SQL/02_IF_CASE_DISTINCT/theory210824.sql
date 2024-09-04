/*Из таблицы EMPLOYEES
Найти все имеющиеся job_id
Найти job_id у которых нет commission_pct или зп меньше 3000*/

SELECT DISTINCT job_id, commission_pct, salary FROM hr.employees WHERE commission_pct = NULL OR salary < 3000;

/* Задание №1:  Отсортировать сотрудников по фамилии в алфавитном порядке */

SELECT * FROM hr.employees ORDER BY last_name ASC;

/* Задание №2:  Отсортировать сотрудников по зарплате - от самой большой зарплаты до самой маленькой */

SELECT * FROM hr.employees ORDER BY salary DESC;

/* Задание №3:  Вывести сотрудников, работающих в департаментах с id 60, 90 и 110, 
отсортированными в алфавитном порядке по фамилии  */

SELECT * FROM  hr.employees WHERE department_id IN (60, 90, 110) ORDER BY last_name ASC;

/* Задание №4:  Вывести сотрудников с job_id ST_CLERK, отсортированными 
по зарплате - от самой большой зарплаты до самой маленькой */

SELECT * FROM hr.employees WHERE job_id = 'ST_CLERK' ORDER BY salary DESC;

/* Задание №5:  Вывести сотрудников, чьи имена начинаются на букву D 
и отсортировать их в алфавитном порядке по фамилии */

SELECT * FROM hr.employees WHERE first_name LIKE 'D%' ORDER BY last_name ASC;

/* Задание №6:  Посмотрите на таблицу jobs. Напишите запрос, который возвращает job_id и max_salary. 
Отсортируйте выборку по убыванию - максимальные зарплаты выводятся первыми.  */

SELECT job_id, max_salary FROM hr.jobs ORDER BY max_salary DESC;

/* Задание №7:  Добавьте в выборке дополнительный столбец rank1, 
который имеет два значения: high и low и вычисляется по правилам high>10000, low <=10000. 
Отсортируйте выборку по возрастанию этого нового поля rank.
 Решите задачу в двух вариантах:
  - c использованием условного оператора case/when/end и
  - c использованием условного оператора IF. */
  
 SELECT job_id, max_salary, IF(max_salary > 10000, 'High', 'Low') AS Rank1 FROM hr.jobs ORDER BY Rank1 ASC;
 
 SELECT job_id, max_salary,
	CASE
    WHEN max_salary > 10000 THEN 'High'
    WHEN max_salary <= 10000 THEN 'Low'
    END AS Rank1
FROM hr.jobs
ORDER BY Rank1 ASC;
	
  
  
  
/* Задание №8   Разделите самолеты на три класса по возрасту. 
Если самолет произведен раньше 2000 года, то отнесите его к классу 'Old'. 
Если самолет произведен между 2000 и 2010 годами включительно, то отнесите его к классу 'Mid'. 
Более новые самолеты отнесите к классу 'New'. Исключите из выборки 
дальнемагистральные самолеты с максимальной дальностью полета больше 10000 км. 
Отсортируйте выборку по классу возраста в порядке возрастания.
В выборке должны присутствовать два атрибута — side_number, age. */
 
  SELECT * FROM airport.airliners;
  
 SELECT side_number,
	CASE 
    WHEN production_year < 2000 THEN '01_Old'
    WHEN production_year BETWEEN 2000 AND 2010 THEN '02_Mid'
   ELSE '03_New'
   END AS age
   FROM airport.airliners WHERE airliners.range <> 10000
   ORDER BY age ASC;
