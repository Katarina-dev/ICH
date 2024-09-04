/*01. Разделите города на 3 категории по населению: меньше 100000 - under populated, более 100000, 
но менее 1000000 - averagely populated,
и более миллиона - millionaire. Напишите запрос, который выводит названия города и категорию по населенности.*/
SELECT Name,
	CASE 
    WHEN Population < 100000 THEN 'under populated'
    WHEN Population > 1000000 THEN 'millionaire'
    ELSE 'averagely populated'
    END AS Category
    FROM world.city;
    
/*02. Выведите название страны с кодом IND как “Индия”*/

SELECT *, IF(Name = 'India', 'Индия', Name) AS Name FROM world.country WHERE Code = 'IND';

/*03. Выведите список городов Индии так, чтобы название страны рядом с названием города, было по-русски*/

SELECT * FROM world.city WHERE CountryCode = 'IND';

SELECT Name, IF(CountryCode = 'IND', 'Индия', CountryCode) AS Country  FROM world.city WHERE CountryCode = 'IND' OR CountryCode = 'AFG';

/*04. Ознакомьтесь с продолжительностью жизни в разных странах*/

SELECT Name, LifeExpectancy FROM world.country ORDER BY LifeExpectancy DESC;

/*05. Разделите страны на 3 категории - short-liver, average-liver, long-liver. Границы по продолжительности
 в категориях установите самостоятельно. Выведите список из названия стран и категорий продолжительности жизни.*/
SELECT Name, LifeExpectancy,
	CASE
    WHEN LifeExpectancy < 40 THEN 'short-liver'
    WHEN LifeExpectancy < 80 THEN 'average-liver'
    WHEN LifeExpectancy >= 80 THEN 'long-liver'
    END AS type2
    FROM world.country WHERE LifeExpectancy IS NOT NULL
    ORDER BY LifeExpectancy DESC;


/*06. Найдите страну с самой высокой продолжительностью*/

SELECT Name, LifeExpectancy FROM world.country ORDER BY LifeExpectancy DESC LIMIT 1;


/*07. Найдите страну с самой низкой продолжительностью жизни*/

SELECT Name, LifeExpectancy FROM world.country WHERE LifeExpectancy IS NOT NULL ORDER BY LifeExpectancy ASC LIMIT 1;

/*08. Попробуйте отсортировать результаты запроса 5 так, чтобы сначала шли short-liver страны.*/

SELECT Name, LifeExpectancy,
	CASE
    WHEN LifeExpectancy < 40 THEN 'short-liver'
    WHEN LifeExpectancy < 80 THEN 'average-liver'
    WHEN LifeExpectancy >= 80 THEN 'long-liver'
    END AS type2
    FROM world.country WHERE LifeExpectancy IS NOT NULL
    ORDER BY LifeExpectancy ASC;