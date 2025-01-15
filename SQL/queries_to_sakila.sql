/* 1. Используя базу sakila, которая содержит информацию о фильмах, актерах, категориях и 
так далее, выведите фильмы, в названии которых содержится слово “LION”, посчитайте количество таких фильмов. */

SELECT * FROM film WHERE title LIKE '%LION%';
SELECT COUNT(*) FROM film WHERE title LIKE '%LION%';

/* 2.  Выведите названия всех фильмов в категории “Horror”. (Подсказка: join таблиц film и film_category и фильтр по category_id). */

SELECT f.title FROM film f
JOIN film_category fc 
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
WHERE c.name = "Horror";

/* 3.  Выведите названия фильмов с названием категории. */

SELECT f.title, c.name FROM film f
JOIN film_category fc 
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id;

/* 4.  Выведите 10 самых длинных фильмов. */

SELECT * FROM film order by length desc LIMIT 10;

/* 5.  Выведите количество фильмов по категориям. */

SELECT f.title, c.name, COUNT(fc.film_id) AS 'Count films' FROM film f
JOIN film_category fc 
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.name;


/* 6.  Выведите категории, в которых больше 20 фильмов. */

SELECT f.title, c.name, COUNT(fc.film_id) AS 'Count films' FROM film f
JOIN film_category fc 
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.name
HAVING 'Count films' > '20';

/* 7.  Выведите
 - названия фильмов,
 - названия категорий и
 - среднюю продолжительность фильма в каждой категории.
 Использовать оконные функции.  */
 
SELECT f.title, c.name, AVG(f.length) OVER (PARTITION BY fc.category_id)  AS 'Average duration (min)' FROM film f
JOIN film_category fc 
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id;
--  
--  SELECT first_name, last_name, department_id, salary,
--        SUM(salary) OVER (PARTITION BY department_id) AS department_salary_sum
-- FROM hr.employees;

/* 8.  Измените предыдущий запрос так, чтобы помимо названия фильма и категории, выводился также ранг по длине фильма. */