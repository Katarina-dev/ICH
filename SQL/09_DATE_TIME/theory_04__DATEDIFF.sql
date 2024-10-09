/* Функция DATEDIFF позволяет найти разницу в днях между date1 и date2.

Если date1 < date2, то результат будет отрицательным.
*/

SELECT DATEDIFF('2023-01-05', '2023-01-01') as diff_date;  -- 4

SELECT DATEDIFF('2023-01-01', '2023-01-05') as diff_date;  -- -4
