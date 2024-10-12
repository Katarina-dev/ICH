/*
Настройки часового пояса и языка

1 ГЛОБАЛЬНЫЕ НАСТРОЙКИ

Глобальные настойки устанавливаются при запуске сервера.
Для их изменения нужны права админа.
Значения глобальных настроек можно, обратившись к переменным
@@global.time_zone и @@global.lc_time_names
 */

-- Часовой пояс сервера
SELECT @@global.time_zone;
-- UTC для удалённого сервера
-- SYSTEM для локального

-- Язык, используемый для отображения названий месяцев и дней недели
SELECT @@global.lc_time_names;

/*
2. НАСТРОЙКИ НА УРОВНЕ СЕССИИ

Для изменения локальных настроек не требуются права админа.
Изменить их достаточно легко, и это изменение будет действовать только в рамках текущей сессии.
*/
--
SELECT @@sessoion.time_zone;
SELECT @@sessoion.lc_time_names;

-- Изменение языка
SET lc_time_names = 'ru_RU';
SET lc_time_names = 'de_DE';
SET lc_time_names = 'en_US';

-- Изменение часового пояса (time_zone)
SET time_zone = '+00:00'; --  UTC (время по Гринвичу)
SET time_zone = '+03:00'; --  UTC+3


SELECT @@global.time_zone;
SELECT @@session.time_zone;

/* При изменении time_zone автоматически изменятся значения полей TIMESTAMP */


SELECT
    TIME(datetime_), TIME(timestamp_)
FROM
    050824_theory.data_time_formats;


