/*Вывести текущую дату и время*/

SELECT NOW();

/*Вывести текущий год и месяц*/

SELECT DATE_FORMAT(CURDATE(), '%Y-%m');

/*Вывести текущее время*/

SELECT CURRENT_TIME();

/*Вывести название текущего дня недели*/

SELECT DAYNAME(CURDATE());

/*Вывести номер текущего месяца*/

SELECT EXTRACT(MONTH FROM now());

/*Вывести номер дня в дате “2020-03-18”*/

SELECT DAY('2020-03-18'); 

/*Подключиться к базе данных shop (которая находится на удаленном сервере)
Определить какие из покупок были совершены апреле (4-й месяц)*/

SELECT *FROM ORDERS;
SELECT *FROM ORDERS WHERE MONTH(ODATE) = 4;

/*Определить количество покупок в 2022-м году*/

SELECT COUNT(ORDER_ID) FROM ORDERS WHERE YEAR(ODATE) = 2022;

/*Определить, сколько покупок было совершено в каждый день. Отсортировать строки в порядке возрастания количества покупок. 
 * Вывести два поля - дату и количество покупок*/

SELECT COUNT(ORDER_ID)  AS 'Count of orders', ODATE FROM ORDERS GROUP BY ODATE ORDER BY COUNT(ORDER_ID);

/*Определить среднюю стоимость покупок в апреле*/

SELECT AVG(AMT) FROM ORDERS WHERE MONTH(ODATE) = 4;