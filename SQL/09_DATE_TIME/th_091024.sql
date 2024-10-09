SELECT * FROM employees e WHERE YEAR(hire_date) = 2005;

/*Определите кого из сотрудников приняли на работу в пятницу. (Выведите таблицу имён и фамилий)*/

SELECT * FROM employees e WHERE DAYOFWEEK(hire_date) = 6;

/*Испытательный срок после трудоустройства длится три месяца, начиная с календарного месяца после трудоустройства, напишите скрипт, который рассчитывает дату окончания испытательного срока.
Рассчитайте эту дату для каждого сотрудника компании и выведите результат в формате:
Имя
Фамилия
Дата поступления
Дата окончания испытательного срока*/

SELECT LAST_DAY('2024-10-08');
SELECT * FROM employees;
SELECT first_name, last_name, hire_date, LAST_DAY(DATE_ADD(hire_date, INTERVAL  3 MONTH)) FROM employees;

/*Определите месяц, в который чаще всего принимают на работe*/
 SELECT COUNT(*), MONTHNAME(hire_date) AS Month FROM employees WHERE hire_date IS NOT NULL group by Month  ORDER BY Month LIMIT 1;

 SELECT COUNT(*), MONTHNAME(hire_date) AS Month FROM employees WHERE hire_date IS NOT NULL group by Month  ORDER BY MONTH(hire_date);

/*Определите месяц, в который чаще всего принимают на работу*/

SELECT COUNT(*), MONTHNAME(ODATE) from ORDERS group by MONTHNAME(ODATE) ORDER BY MONTH(ODATE) ASC ; 

/*Выведите список заказов в марте*/

SELECT * FROM ORDERS WHERE MONTH(ODATE) = 3;