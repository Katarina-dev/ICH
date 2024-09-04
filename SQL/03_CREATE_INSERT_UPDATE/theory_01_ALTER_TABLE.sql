/* Добавление поля (атрибута) price (integer) со значением по умолчанию 0 */

USE 050824_dam_ClassWork;

SELECT * FROM goods;

/* Добавление нового поля (атрибута) price с дефолтным значением 0  */
ALTER TABLE goods
ADD price INTEGER DEFAULT 0;


/* Изменение имени поля (атрибута) price на new_price */
ALTER TABLE goods
CHANGE price new_price INTEGER; 


/* Изменение типа данных поля (атрибута) new_price */
ALTER TABLE goods
MODIFY new_price NUMERIC(8,2);


/* И, наконец, удаление поля (атрибута) new_price */
ALTER TABLE goods
DROP COLUMN new_price;


