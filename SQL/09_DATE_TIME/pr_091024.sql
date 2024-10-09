/*1. Вывести сегодняшнюю дату в формате: день недели, число, месяц, год.*/

SELECT DATE_FORMAT(CURDATE(), '%w %d %m %Y') ;

/*2. Вывести на какой день недели приходится 1 января 2024 года. */

SELECT WEEKDAY('2024-01-01') ;

/*3. Вывести, на какой день недели приходится число, через 10 дней после.*/

SELECT WEEKDAY(DATE_ADD('2024-01-01', INTERVAL 10 DAY));

/*4. Вывести дату, которая будет через 10 дней после последнего дня текущего месяца.*/

SELECT DATE_ADD(LAST_DAY(NOW()), INTERVAL 10 DAY);

/*5. Вывести день недели даты из предыдущей задачи.*/

SELECT DAYNAME(DATE_ADD(LAST_DAY(NOW()), INTERVAL 10 DAY)); 

/*6. Вывести название месяца, который будет через 5 месяцев после текущего. */

SELECT MONTHNAME(DATE_ADD(NOW(), INTERVAL 5 MONTH)); 

/*Вывести количество заказов по числам месяца. 

Вывести количество заказов по дням недели. */

SELECT COUNT(*), MONTH(ODATE) from ORDERS group by MONTH(ODATE) ;

SELECT *, CONCAT(MONTH(ODATE), '_', DAY(ODATE)) as month_day from ORDERS group by month_day;

SELECT COUNT(*), DAYNAME(ODATE) FROM ORDERS group by WEEKDAY(ODATE) order by WEEKDAY(ODATE);

/*9. Вывести количество дней, которые работают сотрудники с момента найма. 
Подсказка: ознакомиться с функцией DATEDIFF. 

10. Вывести количество лет, которые проработал каждый сотрудник. */

SELECT * FROM employees e 

SELECT first_name, last_name, DATEDIFF(now(), hire_date) as days_job from employees where hire_date is not null ORDER BY days_job desc ; 

SELECT first_name, last_name, TIMESTAMPDIFF(YEAR, hire_date, now()) as years_job from employees where hire_date is not null ORDER BY years_job desc ; 


