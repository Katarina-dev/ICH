/* 2. Заполнить таблицу тестовыми данными: 3-5 заказчиков и 
с десяток ордеров так, чтобы у всех 
заказчиков было разное количество заказов. */

USE 050824_new;

-- DROP TABLE IF EXISTS Customer_2;
-- DROP TABLE IF EXISTS Orders_2;

CREATE TABLE Customer_2 (
    customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    street VARCHAR(50),
    post_code INT,
    city VARCHAR(20),
    country VARCHAR(50),
	email VARCHAR(30),
    date_reg DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Orders_2 (
    order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    product_name VARCHAR(50),
    descript Varchar(100),
    link_fotos VARCHAR(100),
    price NUMERIC(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customer_2 (customer_id)
);


   INSERT INTO Customer_2
	(first_name,
    last_name,
    street,
    post_code,
    city,
    country,
	email)
VALUES
	("'Karina" ,"Turbekova",
    "Sonnenstr. 45",
    11510,
    "Berlin",
    "Germany",
    "axel.fisch@gmail.com"),
    
    ("Olena","Karavaieva",
    "Torstr. 75",
    11704,
    "Bernau",
    "Germany",
    "r.kupper@berlin.de"),
    
    ("Александр", "Беляков",
    "Villastr. 5",
    13572,
    "Cottbus",
    "Germany",
    "sarah547@yahoo.com"),
    
    ("Mila", "Bondarenko",
    "Tempelhofer Str. 102",
    12271,
    "Berlin",
    "Germany",
    "bukinivan@gmail.com")
    ;
    
     INSERT INTO Orders_2(
    customer_id,
    product_name,
    descript,
    link_fotos,
    price)
VALUES
	(1,
    "Schuhe",
    "Gummischuhe rot",
    "www.schuhe.de/gummistifeln/rot.png",
    47.54),
    
    (1,
    "Jacke",
    "Regenjacke schwarz",
    "www.jacke.de/regenjacke/schwarz.png",
    68.20),
    
    (1,
    "Schuhe",
    "Hausschuhe Herren",
    "www.schuhe.de/hausschuhe/herren.png",
    21.70),
    
    (2,
    "Jacke",
    "Regenjacke schwarz",
    "www.jacke.de/regenjacke/schwarz.png",
    68.20),
    
    (2,
    "Schuhe",
    "Hausschuhe Damen",
    "www.schuhe.de/hausschuhe/damen.png",
    25.00),
    
    (3,
    "Schuhe",
    "Hausschuhe Herren",
    "www.schuhe.de/hausschuhe/herren.png",
    21.70),
    
    (3,
    "Stiffeln",
    "Kindern Stiffeln",
    "www.schuhe.de/kinderschuhe/stiffeln.png",
    57.50),
    
    (3,
    "Sportschuhe",
    "Sportschuhe grau",
    "www.schuhe.de/sportschuhe/grau.png",
    75.00),
    
    (4,
    "Schuhe",
    "Hausschuhe Herren",
    "www.schuhe.de/hausschuhe/herren.png",
    21.70),
    
	(4,
    "Jacke",
    "Regenjacke schwarz",
    "www.jacke.de/regenjacke/schwarz.png",
    68.20),
    
    (4,
    "Jacke",
    "Sportjacke blau",
    "www.jacke.de/sportjacke/blau.png",
    84.00),
    
    (4,
    "Schuhe",
    "Sportschuhe grau",
    "www.schuhe.de/sportschuhe/grau.png",
    75.00)
;
    
ALTER TABLE Customer_2
ADD last_modified DATETIME DEFAULT now();

ALTER TABLE Orders_2
ADD discounter_price NUMERIC(10,2);

UPDATE Orders_2 
SET discounter_price = 0.9 * price LIMIT 100;

INSERT INTO Customer_2
	(first_name,
    last_name,
    street,
    post_code,
    city,
    country,
	email)
VALUES
("Павел", "Белый",
    "Villastr. 2",
    13572,
    "Cottbus",
    "Germany",
    "sarah5471@yahoo.com"),
    
    ("Milana", "Bondar",
    "Tempelhofer Str. 105",
    12251,
    "Berlin",
    "Germany",
    "bukinivanu@gmail.com")
    ;
     INSERT INTO Orders_2(
    customer_id,
    product_name,
    descript,
    link_fotos,
    price)
VALUES
	(5,
    "Schuhe",
    "Gummischuhe rot",
    "www.schuhe.de/gummistifeln/rot.png",
    47.54),
    
    (6,
    "Jacke",
    "Regenjacke schwarz",
    "www.jacke.de/regenjacke/schwarz.png",
    68.20);
    
UPDATE Orders_2 
SET discounter_price = 0.9 * price  WHERE order_id IN (13, 14) LIMIT 100; 

SELECT * FROM Orders_2 ORDER BY price DESC; 

SELECT * 


    SELECT * FROM Customer_2;
    SELECT * FROM Orders_2;
   
   SELECT name, count(order_id) FROM Orders_2 GROUP BY name
   
   
   UPDATE Orders_2 
SET discounter_price = 0.9 * price  WHERE order_id IN (13, 14) LIMIT 100;

SELECT * FROM Orders_2 ORDER BY price DESC;

SELECT * FROM Customer_2 
WHERE email LIKE '%gmail.com';

SELECT * ,
CASE
	WHEN price >= 60 THEN 'high'
	WHEN price >= 30 THEN 'middle'
	ELSE 'low'
    END AS status
    
    FROM Orders_2;
    
ALTER TABLE Customer_2 
ADD rating INTEGER;

UPDATE Customer_2 AS c
SET rating = (SELECT count(order_id) FROM Orders_2 AS o WHERE o.customer_id = c.customer_id) LIMIT 100;

SELECT last_name  FROM Customer_2 ORDER BY rating DESC;
