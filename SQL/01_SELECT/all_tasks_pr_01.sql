/* 01. Выведите содержимое таблиц city и country. Сколько записей в каждой? */
SELECT * FROM world.city;
SELECT * FROM world.country ORDER BY Population;

SELECT COUNT(*) FROM world.city;
SELECT COUNT(*) FROM world.country;

/* 02. Введите команды DESCRIBE city; и DESCRIBE country; Мы не проходили команды, но они  простые и полезные. Опишите увиденное и попытайтесь объяснить его. */
DESCRIBE world.city;
DESCRIBE world.country;

/* 03. Выведите все страны Азии (Asia). Сколько их в таблице? */
SELECT * FROM world.country WHERE Continent = 'Asia';
SELECT COUNT(*) FROM world.country WHERE Continent = 'Asia';

/* 04. Выведите тот же результат, но с помощью команды WHERE Continent IN (‘Asia’) */
SELECT * FROM world.country WHERE Continent IN ('Asia');

/* 05. Выведите результат из двух столбцов: Name, LocalName. */
SELECT Name, LocalName FROM world.country;

/* 06. Выведите страны с населением более 1 млрд человек. */
SELECT * FROM world.country WHERE Population > 1000000000;  

/* 07. Выведите все города Индии. Подсказка: у города есть поле CountryCode со значением  ‘IND’ для индии. */
SELECT * FROM world.city WHERE CountryCode = 'IND';

/* 08. Выведите все города с названием на ‘A’ */
SELECT * FROM world.city WHERE Name LIKE 'A%';
