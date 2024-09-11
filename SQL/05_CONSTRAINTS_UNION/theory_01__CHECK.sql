DROP DATABASE IF EXISTS 050824_theory;
CREATE DATABASE IF NOT EXISTS 050824_theory;

USE 050824_theory;

CREATE TABLE IF NOT EXISTS goods (
    id INT PRIMARY KEY,
    title VARCHAR(30),
    quantity INT CHECK (quantity > 0),
    in_stock CHAR(1) CHECK (in_stock IN ('Y' , 'N'))
);


