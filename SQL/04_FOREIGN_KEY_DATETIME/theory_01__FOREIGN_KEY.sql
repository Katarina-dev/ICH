USE OnlineStore;

-- Создание таблицы заказчиков (Customer)
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50)
);

-- Создание таблицы заказов (Orders)
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(50),
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

INSERT INTO Customer (customer_name)
VALUES
	('John Doe'),
	('Jane Smith'),
	('Michael Brown');

-- Вставка данных в таблицу заказов (Orders)
INSERT INTO Orders (customer_id, product_name)
VALUES
	(1, 'Bike'), -- Заказчик 1
	(1, 'Alpine skis'), -- Заказчик 1
	(2, 'Roller skates'), -- Заказчик 2
	(2, 'Alpine skis'), -- Заказчик 2
	(3, 'Bike'), -- Заказчик 3
	(3, 'Scooter'); -- Заказчик 3
