/*
Форматы данных MySQL для дат и времени:

    DATE — хранит дату в формате YYYY-MM-DD (год-месяц-день).
    DATETIME — хранит дату и время в формате YYYY-MM-DD HH:MM:SS
            (год-месяц-день часы:минуты:секунды).
    TIMESTAMP — аналогичен DATETIME, но привязан к часовому поясу
            и автоматически обновляется при изменении данных.
            Формат: YYYY-MM-DD HH:MM:SS.
    TIME — хранит время в формате HH:MM:SS (часы:минуты:секунды).
    YEAR — хранит год в формате YYYY или YY (4 цифры или 2 цифры). */



USE 050824_theory;

CREATE TABLE IF NOT EXISTS data_time_formats (
    date_ DATE,  			-- 2024-10-08
    datetime_ DATETIME, 	-- 2024-10-08 13:27:43
    timestamp_ TIMESTAMP,   -- 2024-10-08 13:27:43
    time_ TIME,				-- 13:27:43
    year_ YEAR				-- 2024
);

DESCRIBE data_time_formats;

-- Здесь возникнет ошибка в полях date_, time_ и year_
INSERT INTO data_time_formats
VALUES (NOW(), NOW(), NOW(), NOW(), NOW());

-- Правильный способ добавления данных
INSERT INTO data_time_formats
VALUES (CURDATE(), NOW(), NOW(), CURTIME(), YEAR(NOW()));

-- Правильный способ добавления данных
INSERT INTO data_time_formats
VALUES (CURRENT_DATE(), NOW(), NOW(), CURRENT_TIME(), YEAR(NOW()));

SELECT * FROM data_time_formats;

-- DROP TABLE data_time_formats;