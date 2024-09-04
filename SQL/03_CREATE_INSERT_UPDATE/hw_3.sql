USE 050824_new;

/* Не подглядывая в решение в классе, создать таблицу weather с тремя полями:
название города (city)
дата (forecast_date)
температура в эту даты (temperature)*/
CREATE TABLE IF NOT EXISTS weather_tan (
	city VARCHAR(100),
    forecast_date DATE,
    temperature INTEGER);
    
/* 2. Вывести содержимое таблицы */
    SELECT * FROM weather_tan;
    
/* 3. Добавить данные в таблицу, используя запрос INSERT
“29 августа 2023 года в Берлине было 30 градусов” */
INSERT INTO weather_tan
	(city, forecast_date, temperature)
VALUES
	('Berlin', '2023-08-29', 30);
    
/* 4. Добавить еще 3 записи в таблицу (произвольную погоду в разных городах в разные дни). */
INSERT INTO weather_tan
	(city, forecast_date, temperature)
VALUES
	('Belgrade', '2024-08-30', 38),
    ('Paris', '2024-08-31', 29),
    ('Antalya', '2024-09-01', 40);

/* 5. Написать запрос, который возвращает содержимое таблицы. */
SELECT * FROM weather_tan;

/* 6. Изменить данные в таблице о температуре в Берлине с 30 на 26 градусов. */
UPDATE weather_tan
	SET temperature = '26'
    WHERE city = 'Berlin' LIMIT 100;
    
/* 7. Поменяйте во всей таблице название города на Paris для записей, где температура выше 25 градусов. */
UPDATE weather_tan
	SET city = 'Paris'
    WHERE temperature > 25 LIMIT 100;
    
/* 8. Добавить к таблице weather дополнительный столбец min_temp типа integer. */
ALTER TABLE weather_tan
ADD min_temp INTEGER DEFAULT 0;

/* 9. Используя команду update, установить значение поля min_temp в 0 для всех записей в таблице.*/
UPDATE weather_tan
	SET min_temp = 0 LIMIT 100;