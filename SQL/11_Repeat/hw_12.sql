-- 1. Вывести количество городов для каждой страны. Результат должен содержать CountryCode, CityCount (количество городов в стране). 
-- Поменяйте запрос с использованием джойнов так, чтобы выводилось название страны вместо CountryCode.

SELECT * FROM  country;
SELECT * FROM city;
SELECT * FROM countrylanguage;

SELECT co.Name, COUNT(*) OVER(PARTITION BY co.Name) AS CityCount FROM city ci
JOIN country co
ON ci.CountryCode = co.Code


-- 2. Используя оконные функции, вывести список стран с продолжительностью жизнью и средней продолжительностью жизни. 

SELECT Name, LifeExpectancy, AVG(LifeExpectancy) OVER (PARTITION BY Name) AS Average_LifeExpectancy FROM country


-- 3. Используя ранжирующие функции, вывести страны по убыванию продолжительности жизни.

SELECT Name, LifeExpectancy, DENSE_RANK() OVER(ORDER BY LifeExpectancy DESC) AS Rank_LifeExpectancy FROM country



-- 4. Используя ранжирующие функции, вывести третью страну с самой высокой продолжительностью жизни.

SELECT Name, Rank_LifeExpectancy FROM
	(SELECT Name, LifeExpectancy, DENSE_RANK() OVER(ORDER BY LifeExpectancy DESC) AS Rank_LifeExpectancy FROM country) as t
WHERE Rank_LifeExpectancy = 3