USE 050824_theory;

/* Для удаления большинства ограничений необходимо знать их имена */
SHOW CREATE TABLE Customer;
SHOW CREATE TABLE Orders;

-- 1. Удаление первичного ключа (PRIMARY KEY):

ALTER TABLE Orders
DROP PRIMARY KEY;

-- Сразу же восстанавливаем удалённый ключ!
ALTER TABLE Orders
ADD PRIMARY KEY (id);

-- 2. Удаление внешнего ключа (FOREIGN KEY):

ALTER TABLE Orders
DROP FOREIGN KEY fk_customer_id;


-- 3. Удаление уникального ограничения (UNIQUE):

ALTER TABLE Customer
DROP INDEX unique_constraint_name;


-- 4. Удаление ограничения проверки (CHECK):

ALTER TABLE Orders
DROP CHECK check_constraint_price;

SHOW CREATE TABLE Customer;
SHOW CREATE TABLE Orders;