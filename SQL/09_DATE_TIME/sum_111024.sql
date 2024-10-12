/*Вывести текущую дату и время*/

SELECT NOW();

/*Вывести текущий год и месяц*/

SELECT DATE_FORMAT(NOW(), 'Year: %Y Month: %m');

SELECT YEAR(NOW()), MONTH(NOW()); 
SELECT YEAR(NOW()), MONTHNAME(NOW()); 
SELECT EXTRACT(YEAR FROM NOW()), EXTRACT(MONTH FROM NOW());

/*Вывести текущее время*/

SELECT CURTIME() AS CurrentTime;
SELECT DATE_FORMAT(CURTIME(), '%H:%i:%s');
SELECT EXTRACT(HOUR from NOW()), EXTRACT(MINUTE from NOW()), EXTRACT(SECOND from NOW());
SELECT CONCAT(EXTRACT(HOUR from NOW()),':', EXTRACT(MINUTE from NOW()),':', EXTRACT(SECOND from NOW())) AS 'Time';

/*Вывести название текущего дня недели*/

SELECT DAYNAME(NOW()) AS day_name; ---- in English
SET lc_time_names = 'ru_RU';
SET lc_time_names = 'de_DE';
SET lc_time_names = 'en_US';

SELECT 
    CASE DAYNAME(@cur_date_time)
        WHEN 'Sunday' THEN 'Воскресенье'
        WHEN 'Monday' THEN 'Понедельник'
        WHEN 'Tuesday' THEN 'Вторник'
        WHEN 'Wednesday' THEN 'Среда'
        WHEN 'Thursday' THEN 'Четверг'
        WHEN 'Friday' THEN 'Пятница'
        WHEN 'Saturday' THEN 'Суббота'
    END AS day_name_in_russian; -- -------------по-русски

/*Вывести номер текущего месяца*/
    
SELECT MONTH(CURDATE());
SELECT DATE_FORMAT(NOW(), 'Месяц: %m')

/*Вывести номер дня в дате “2020-03-18”*/

SELECT DATE_FORMAT('2020-03-18','%d');
SELECT EXTRACT(DAY from '2020-03-18');

/*Подключиться к базе данных shop (которая находится на удаленном сервере)
Определить какие из покупок были совершены апреле (4-й месяц)*/



