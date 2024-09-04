USE 050824_new;

/* Задание №1  Создайте таблицу goods (id, title, quantity */

CREATE TABLE IF NOT EXISTS goods_tan (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    quantity INTEGER
    );
 
 /* Задание №2  Добавьте несколько строк */
INSERT INTO goods_tan 
	(title, quantity)
VALUES
	("Car", 5);
	
SELECT * FROM goods_tan;

INSERT INTO goods_tan
	(title, quantity)
VALUES
	("Doll", 10);
    
INSERT INTO goods_tan
	(title, quantity)
VALUES
	("Lego", 15);
    
INSERT INTO goods_tan
	(title, quantity)
VALUES
	("Bear", 4);
    
INSERT INTO goods_tan
	(title, quantity)
VALUES
	("Toy stroller", 19),
    ("Pyramid", 3);

ALTER TABLE goods_tan
	ADD price INTEGER DEFAULT 0;
    
UPDATE goods_tan
	SET price = NULL
LIMIT 100;
     
ALTER TABLE goods_tan
	MODIFY price NUMERIC(8, 2);
    
UPDATE goods_tan
	SET price = 5
LIMIT 100;

ALTER TABLE goods_tan
MODIFY price INTEGER;

ALTER TABLE goods_tan
CHANGE price item_price INTEGER;

ALTER TABLE goods_tan
DROP COLUMN item_price;

INSERT INTO goods_tan
	(title, quantity)
VALUES
	("Scooter", 7);
    
UPDATE goods_tan
	SET quantity = quantity + 7
WHERE title = 'Scooter' LIMIT 100;

/*UPDATE 050824_new.goods_Filimonov SET price = 15 WHERE id = 3;*/