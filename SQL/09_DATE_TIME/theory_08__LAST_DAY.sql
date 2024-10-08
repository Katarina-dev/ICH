/*
Функция LAST_DAY() в MySQL используется для получения последнего дня месяца для указанной даты.
Эта функция возвращает последний день месяца, в котором находится указанная дата,
в формате даты (без времени).

LAST_DAY(date)

где date- дата в формате DATE, DATETIME или TIMESTAMP
*/

SELECT LAST_DAY('2024-10-08');  -- 2024-10-31
