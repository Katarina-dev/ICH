/* Внимание !!!
При запуске код даст ошибку добавления ограничения (price > 0)
так как в таблице уже есть значения, где price = 0
*/
-- ====================== Создание базы для проверки НАЧАЛО =========================

DROP DATABASE IF EXISTS 050824_theory;
CREATE DATABASE IF NOT EXISTS 050824_theory;

USE 050824_theory;

CREATE TABLE Customer (
	id INT,
	name VARCHAR(30)
);

CREATE TABLE Orders (
	id INT,
	customer_id INT,
	price DECIMAL(8, 5)
);

SHOW CREATE TABLE Customer;
SHOW CREATE TABLE Orders;

INSERT INTO Customer (id, name)
VALUES
(1, 'John Doe'),
(2, 'Jane Smith');

INSERT INTO Orders (id, customer_id, price)
VALUES
(1, 1, 0),
(2, 2, 150.00);

-- ====================== Создание базы для проверки КОНЕЦ =========================

-- *************************** ТЕОРИЯ НАЧАЛО ***************************

-- 1. Добавление первичного ключа (PRIMARY KEY):

ALTER TABLE Customer
ADD PRIMARY KEY (id);

ALTER TABLE Orders
ADD PRIMARY KEY (id);


-- 2. Добавление внешнего ключа (FOREIGN KEY):

ALTER TABLE Orders
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (customer_id) REFERENCES Customer(id);    -- fk_customer_id - это имя ограничения


-- 3. Добавление уникального ограничения (UNIQUE):

ALTER TABLE Customer
ADD CONSTRAINT unique_constraint_name
UNIQUE (name);           -- unique_constraint_name - это имя ограничения


-- 4. Добавление ограничения проверки (CHECK) (начиная с MySQL 8.0.16):

ALTER TABLE Orders
ADD CONSTRAINT check_constraint_price
CHECK (price > 0);        -- check_constraint_price - это имя ограничения

-- *************************** ТЕОРИЯ КОНЕЦ ***************************

-- ====================== ПРОВЕРКА ДАННЫХ =========================

SHOW CREATE TABLE Customer;
SHOW CREATE TABLE Orders;



INSERT INTO Orders (id, customer_id, price)
VALUES
(3, 1, 0.00);