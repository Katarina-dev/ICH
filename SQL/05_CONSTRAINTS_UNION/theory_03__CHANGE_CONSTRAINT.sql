USE 050824_theory;

SHOW CREATE TABLE Customer;
SHOW CREATE TABLE Orders;

/* Обычно для изменения ограничения старое ограничение удаляется, а новое добавляется.
Для удаления старого ограничения обычно требуется знать его имя */

-- 1. Изменение NULL и NOT NULL

ALTER TABLE Orders MODIFY price VARCHAR(30) NOT NULL;


-- 2. Все остальные ограничения сначала удаляются, а затем добавляются новые

-- (перед добавлением нового ключа, старый ключ необходимо удалить)

ALTER TABLE Orders
DROP PRIMARY KEY;
ALTER TABLE Orders
ADD PRIMARY KEY (id);

/* ВНИМАНИЕ!!! если PRIMARY KEY используется для FOREIGN KEY в другой таблице,
то удалить его невозможно без удаления FOREIGN KEY */

-- ALTER TABLE Customers
-- DROP PRIMARY KEY;

SHOW CREATE TABLE Customer;
SHOW CREATE TABLE Orders;