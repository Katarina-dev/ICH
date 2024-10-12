SET @some_date_str = '2024-10-10 14:30:00 +01:00';

SELECT STR_TO_DATE(@some_date_str, '%Y-%m-%d %H:%i:%s');


SELECT CONVERT_TZ(
	STR_TO_DATE(@some_date_str, '%Y-%m-%d %H:%i:%s'),
		'+01:00',
		'+03:00') AS utc_time_;


-- функция SUBSTRING(строка, начальная_позиция, [длина])
SELECT SUBSTRING(@some_date_str, 21, 6);   -- '+01:00'
SELECT SUBSTRING(@some_date_str, -6);      -- '+01:00'


-- Мы можем извлечь тайм-зону из даты и передать в функцию CONVERT_TZ как аргумент:
SELECT CONVERT_TZ(
    STR_TO_DATE(@some_date_str, '%Y-%m-%d %H:%i:%s'),
    SUBSTRING(@some_date_str, -6),
    '+03:00'
) AS utc_time_;


-- корректируем входящее время относительно "нашей" текущей временной зоны:
SELECT CONVERT_TZ(
    STR_TO_DATE(@some_date_str, '%Y-%m-%d %H:%i:%s'),
    SUBSTRING(@some_date_str, -6),
    (SELECT @@session.time_zone)
) AS utc_time_;

