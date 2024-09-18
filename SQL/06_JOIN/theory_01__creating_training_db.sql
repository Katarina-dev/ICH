CREATE DATABASE IF NOT EXISTS learning_join_command;

USE learning_join_command;

CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL
);

INSERT INTO departments (department_name)
VALUES
    ('HR'),
    ('IT'),
    ('Sales');

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO employees (name, department_id)
VALUES
    ('Alice', 1),
    ('Bob', 2),
    ('Charlie', NULL),
    ('David', 1);

