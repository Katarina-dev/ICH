
/*1. Создать базу данных онлайн-магазина из двух таблиц: заказчики (Customer) и заказы (Orders).
Customers:
Идентификатор заказчика, имя, фамилию,
улицу, почтовый код, город, страна, email,
дата регистрации.

Orders:
Идентификатор заказчика, который создал
этот заказ, дата создания заказа,
наименование товара (номер айтема),
описание товара, ссылка на фотографию,
стоимость заказа. 
2. Заполнить таблицу тестовыми данными: 3-5 заказчиков и с десяток ордеров так, чтобы у всех заказчиков было разное количество заказов. 

3. Сохранить запросы создания таблиц и ввода тестовых данных, чтобы позже добавить их на ревью в гитхаб.*/

USE 050824_new;

-- Создание таблицы заказчиков (Customer)
CREATE TABLE Customer_7 (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_first_name VARCHAR(50),
	customer_last_name VARCHAR(50),
    street VARCHAR(50),
    postcode VARCHAR(10),
    city VARCHAR(30),
    country VARCHAR(30),
    email VARCHAR(30),
    registration_time DATETIME DEFAULT CURRENT_TIMESTAMP

);

-- Создание таблицы заказов (Orders)
CREATE TABLE Orders_7 (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    product_name VARCHAR(50),
    product_description VARCHAR(100),
    product_photo_link VARCHAR(100),
    order_price NUMERIC(4,2),
    FOREIGN KEY(customer_id) REFERENCES Customer_7(customer_id)
);

INSERT INTO Customer_7 (customer_first_name, customer_last_name, street, city, country, email)
VALUES
	('Bill', 'Carol', 'Baker', 'London', 'UK', 'jfjfk@gmail.com'),
	('Jane', 'Smith','Sunny', 'Paris', 'FR', 'j3445@mail.com'),
	('David', 'Oakley','Walley', 'Tbilisi', 'GR', 'j4few@mail.com'),
    ('John', 'Price','Ulip', 'Berlin', 'GE', 'jgnr783@yahoo.com');

-- Вставка данных в таблицу заказов (Orders)
INSERT INTO Orders_7 (customer_id, product_name, order_price)
VALUES
	(1, 'Bike', 40.9), -- Заказчик 1
	(2, 'Roller skates',50.5), -- Заказчик 2
	(2, 'Alpine skis', 35), -- Заказчик 2
	(3, 'Bike',40.9), -- Заказчик 3
    (3, 'Roller skates', 50.5), -- Заказчик 3
	(3, 'Scooter', 24.6), -- Заказчик 3
    (3, 'Alpine skis', 35), -- Заказчик 3
    (4, 'Scooter', 24.6), -- Заказчик 4
    (4, 'Bike', 40.9), -- Заказчик 4
    (4, 'Alpine skis', 35); -- Заказчик 4
    
SELECT * FROM Orders_7;
SELECT * FROM Customer_7;

/*4. К таблице Customer добавить поле last_modified, которое содержит дату последнего изменения данных заказчика. Установить его значение в now. 

5. Добавить к таблице Order поле discounter_price, которое содержит скидочную стоимость заказа. Выставить значение этого поля для всех заказов на 10% меньше, чем оригинальная стоимость заказа.

6. Добавить в таблицы тестовые данные: как минимум 3 заказчика по 2-3 заказа у каждого.*/

ALTER TABLE Customer_7
ADD last_modified DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Orders_7
ADD discounter_price NUMERIC(4,2);

UPDATE  Orders_7
SET 
   discounter_price = order_price * 0.9
LIMIT 100;

INSERT INTO Customer_7 (customer_first_name, customer_last_name, street, city, country, email)
VALUES
	('Sam', 'White', 'Tupir', 'London', 'UK', 'j434qffk@gmail.com'), -- Заказчик 5
	('Kate', 'Parker', 'White', 'NY', 'US', 'jpajdfk@mail.com'), -- Заказчик 6
    ('William', 'Dom', 'Baker', 'London', 'UK', 'jwr545jfk@yahoo.com'); -- Заказчик 7

-- Вставка данных в таблицу заказов (Orders)
INSERT INTO Orders_7 (customer_id, product_name, order_price)
VALUES
	(5, 'Bike', 40.9), -- Заказчик 5
	(5, 'Roller skates', 50.5), -- Заказчик 5
	(6, 'Alpine skis', 35), -- Заказчик 6
	(6, 'Bike',40.9), -- Заказчик 6
	(6, 'Roller Skates', 50.5), -- Заказчик 6
    (7, 'Alpine Skis', 35), -- Заказчик 7
    (7, 'Roller Skates', 50.5); -- Заказчик 7

/* 1. Вывести все заказы, отсортированные по убыванию по стоимости
2. Вывести всех заказчиков, у которых почта зарегистриварована на gmail.com
3. Вывести заказы, добавив дополнительный вычисляемый столбец status, который вычисляется по стоимости заказа 
и имеет три значения: low, middle, high. 
4. Вывести заказчиков по убыванию рейтинга.
5. Вывести всех заказчиков из города на ваш выбор.
6. Написать запрос, который вернет самый часто продаваемый товар. 
7. Вывести список заказов с максимальной скидкой.
8. Ответьте в 1 предложении: как вы определите скидку? 
9. Ответьте в 1 предложении: может ли это быть разница между нормальной ценой и скидочной ценой? 
10. Написать запрос, который выведет все заказы с дополнительным столбцом процент_скидки, 
который содержит разницу в процентах между нормальной и скидочной ценой?*/

-- 1
SELECT 
    *
FROM
    Orders_7
ORDER BY order_price DESC;

-- 2
SELECT 
    *
FROM
    Customer_7
WHERE
    email LIKE '%gmail.com';
    
-- 3
    SELECT 
    *
FROM
    Orders_7
ORDER BY order_price DESC;

SELECT 
*,
	CASE
        WHEN order_price > 40 THEN 'High'
        WHEN order_price < 35 THEN 'Low'
        ELSE 'Middle'
    END AS Status
FROM
	Orders_7;
    
    -- 4
    
    SELECT 
   (SELECT 
    c.customer_last_name
FROM
    Customer_7 AS c
WHERE
    c.customer_id = o.customer_id) AS last_name, COUNT(order_id) AS rating
FROM
    Orders_7 as o
GROUP BY customer_id
ORDER BY rating desc;

-- 5

SELECT 
    *
FROM
    Customer_7
WHERE
    city = 'London';
    
-- 6 
SELECT 
    product_name, COUNT(order_id) as product_rating
FROM
    Orders_7
GROUP BY product_name
ORDER BY product_rating desc
LIMIT 1;

-- 7 
SELECT 
    product_name, () as product_rating
FROM
    Orders_7
GROUP BY product_name
ORDER BY product_rating desc
     


