SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;
SELECT * FROM SELLERS;

/* 1. Вывести средний рейтинг клиентов по городам: для каждого города вывести:
   имя клиента, его рейтинг, город, и средний рейтинг клиентов по этому городу. */
SELECT 
    cname, city, rating, AVG(rating) OVER(PARTITION BY city) as avg_city_rating
FROM
    CUSTOMERS;
    
   SELECT 
    cname, city, rating, (select AVG(c.rating)  from CUSTOMERS as c where c.city = city) as avg_city_rating
FROM
    CUSTOMERS; 
    

SELECT 
    c.cname, c.city, c.rating, t.avg_city_rating
FROM
    CUSTOMERS as c 
JOIN
 (select  city, avg(rating) as avg_city_rating from CUSTOMERS  group by city) as t on c.city = t.city;

/* 2. Вывести информацию о каждом заказе:
	id заказа; сумму заказа; месяц, в котором был сделан заказ;
    и максимальную сумму заказа в том же месяце для каждой строки. */

SELECT ORDER_ID, AMT, MONTH(ODATE) , MAX(AMT) OVER(PARTITION BY MONTH(ODATE))  AS max_order
FROM ORDERS;

/* 3. Для более полного понимания практической значимости прошлого запроса,
      добавим подсчёт относительного вклада каждого заказа (в процентах) в общий объем продаж месяца. */

SELECT 
	ORDER_ID, AMT, MONTH(ODATE) , 
	SUM(AMT) OVER(PARTITION BY MONTH(ODATE)) AS sum_order_by_month, 
	AMT / SUM(AMT) OVER(PARTITION BY MONTH(ODATE)) * 100 AS percent 
FROM ORDERS;

/* 4. Вывести список продавцов с указанием общей суммы их продаж.
      Отсортировать продавцов по убыванию суммы продаж.

	Разделим задачу на 2 части:
    4.1. Выведем имена продавцов и суммы их заказов
    4.2. Найдём общую сумму заказа по каждому продавцу и отсортируем результат по убыванию суммы продаж  */

SELECT * FROM SELLERS;
SELECT * FROM ORDERS; 
    
 SELECT 
    s.SNAME, o.AMT
FROM
    SELLERS AS s 
    JOIN 
    ORDERS AS o ON s.SELL_ID = o.SELL_ID;   
    
    
 SELECT 
    s.SNAME, SUM(o.AMT)
FROM
    SELLERS AS s 
    JOIN 
    ORDERS AS o ON s.SELL_ID = o.SELL_ID
GROUP BY s.SNAME ORDER BY SUM(o.AMT) DESC;  

 SELECT DISTINCT
    s.SNAME, 
    SUM(o.AMT) OVER(PARTITION BY s.SNAME) AS Sum_amt_by_name
FROM
    SELLERS AS s 
    JOIN 
    ORDERS AS o ON s.SELL_ID = o.SELL_ID
ORDER BY 
    Sum_amt_by_name DESC;
   
   
   /*---------------------------*/

SELECT DISTINCT
    s.sname, 
    SUM(o.amt) OVER (PARTITION BY s.sname) AS total_sales
FROM 
    SELLERS s
JOIN 
    ORDERS o ON s.sell_id = o.sell_id
ORDER BY 
    total_sales DESC;
   
   /* 5. Вывести топ-2 продавцов с самой высокой средней суммой заказа */
   
   SELECT DISTINCT
s.SNAME, 
AVG(o.AMT) OVER(PARTITION BY s.SNAME) AS avg_AMT_by_name
FROM 
	SELLERS AS s
    JOIN
    ORDERS AS o ON s.SELL_ID = o.SELL_ID  
ORDER BY avg_AMT_by_name DESC;

-- 2--
SELECT 
s.SNAME, AVG(o.AMT)
FROM 
	SELLERS AS s
    JOIN
    ORDERS AS o ON s.SELL_ID = o.SELL_ID  
GROUP BY s.SNAME ORDER BY AVG(o.AMT) DESC;

/* 1. Используя базу hr, произведите ранжирование департаментов по средней зарплате.

	Делим задачу на 2 части:
    1.1. Получаем id департаментов и среднюю ЗП по каждому из них.
    1.2. Ранжируем результат по убыванию. */
SELECT * from employees e 

SELECT  DISTINCT
	department_id, AVG(salary) OVER(PARTITION BY department_id) as avg_salary_by_dep,  DENSE_RANK() OVER(ORDER BY department_id DESC) as rank_salary_by_dep
FROM employees 

SELECT  DISTINCT
	department_id, AVG(salary) OVER(PARTITION BY department_id) as avg_salary_by_dep,  DENSE_RANK() OVER(ORDER BY department_id DESC) as rank_salary_by_dep
FROM employees 


select DISTINCT
	department_id, 
	AVG(salary) over(PARTITION BY department_id) as avg_salary_by_dep
from employees
order by avg_salary_by_dep DESC;

select DISTINCT
	department_id, 
	AVG(salary) as avg_salary_by_dep
from employees
GROUP BY department_id
order by avg_salary_by_dep DESC;


/* 2. Выведите топ-3 фамилий сотрудников с наивысшей зарплатой в каждом департаменте.
	Делим задачу на 3 части:
    2.1 Получаем сквозное ранжирование зарплат по всей фирме.
    2.2 Делаем тоже самое, но уже по каждому департаменту.
    2.3 Оставляем в каждом департаменте только первых трёх сотрудников. */

SELECT 
salary, last_name, department_id,
RANK () OVER(ORDER BY salary DESC) AS rn
FROM employees 

SELECT 
salary, last_name, department_id,
ROW_NUMBER () OVER(PARTITION BY department_id ORDER BY salary DESC) AS rn
FROM employees 

    SELECT salary, last_name,department_id,
    RANK() OVER(ORDER BY salary DESC) As rn
    FROM hr.employees;
    
	SELECT salary, last_name,department_id,
    ROW_NUMBER() OVER(PARTITION BY department_id  ORDER BY salary DESC) As rn
    FROM hr.employees;
   
   SELECT salary, last_name,department_id,
    OVER(ORDER BY department_id BETWEEN 1 PRECEDING AND 3 FOLLOWING) As rn
    FROM hr.employees;
   
   
   
	
    SELECT * 
    FROM 
	   ( SELECT salary, last_name,department_id,
        ROW_NUMBER() OVER(PARTITION BY department_id  ORDER BY salary DESC) As rn
        FROM hr.employees) AS t
    WHERE rn <=3;
   
   
   -- 3. Выведите второго по зарплате сотрудника в каждом департаменте.
   
     SELECT * 
    FROM 
	   ( SELECT salary, last_name,department_id,
        ROW_NUMBER() OVER(PARTITION BY department_id  ORDER BY salary DESC) As rn
        FROM hr.employees) AS t
    WHERE rn = 2;
   
   /* 4. Получить информацию о зарплате сотрудников,
	а также рассчитать кумулятивную и относительную кумулятивную сумму зарплаты
    для каждого сотрудника в пределах своего департамента.
    (предварительно отсортировать по id сотрудника) */
   
SELECT * 
FROM    
    ( SELECT first_name, last_name, department_id, salary,
    DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS rn 
    FROM employees) AS t
WHERE rn = 2;
   
SELECT first_name, last_name, salary, department_id,
       SUM(salary) OVER (PARTITION BY department_id ORDER BY salary ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum, 
       salary / SUM(salary) OVER (PARTITION BY department_id ORDER BY salary ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) * 100 AS t
       
FROM hr.employees;

-- 1. Вывести список model_name всех самолетов (airliners) и количество всех самолетов в таблице.
-- без OVER()
-- c OVER()

SELECT model_name, 
COUNT(id) OVER() as count_airliners FROM airliners;
