USE 050824_new;


CREATE TABLE Customer_tt (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE Orders_tt (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(50),
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customer_tt(customer_id)
);

INSERT INTO Customer_tt (customer_name)
VALUES
	('Karina Turbekova'),
	('Olena Karavaieva'),
	('Александр Беляков'),
    ('Mila Bondarenko'),
    ('Татьяна Удовиченко');
        
INSERT INTO Orders_tt (customer_id, product_name)
VALUES
	(1, 'Bike'),
    (1, 'Alpine skis'),
	(2, 'Alpine skis'), 
	(3, 'Roller skates'),
    (3, 'Bike'),
    (3, 'Alpine skis'),
	(4, 'Alpine skis'), 
	(5, 'Bike'), 
	(5, 'Scooter'),
    (5, 'Alpine skis'); 
    
    SELECT * FROM Customer_tt;
    SELECT * FROM Orders_tt;


SELECT * FROM Customer_tt AS c JOIN Orders_tt AS o ON c.customer_id = o.customer_id;

