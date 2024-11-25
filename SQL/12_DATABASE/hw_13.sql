DROP DATABASE IF EXISTS Taxi_ekmi;


CREATE DATABASE IF NOT EXISTS Taxi_ekmi;


CREATE TABLE IF NOT EXISTS Orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_driver INT NOT NULL,
    id_customer INT NOT NULL,
    id_rate INT NOT NULL,
    id_auto INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    coefficient INT,
    total_cost DECIMAL,
    FOREIGN KEY (id_driver) REFERENCES Drivers(id),
    FOREIGN KEY (id_customer) REFERENCES Customer(id),
    FOREIGN KEY (id_rate) REFERENCES Rate(id),
    FOREIGN KEY (id_auto) REFERENCES Auto(id)
);


CREATE TABLE IF NOT EXISTS Drivers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    phone_num INT,
    address VARCHAR(100),
    license_number INT
);

CREATE TABLE IF NOT EXISTS Customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_num INT,
    address VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Rate (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    price INT
);

CREATE TABLE IF NOT EXISTS Auto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_insurance INT UNIQUE NOT NULL,
    service_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    reg_num VARCHAR(50),
    model VARCHAR(50),
    color VARCHAR(50),
    FOREIGN KEY (id_insurance) REFERENCES Insurance(id)
);

CREATE TABLE IF NOT EXISTS Insurance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    type VARCHAR(50),
    cost INT,
    number INT
);


SHOW Auto;



