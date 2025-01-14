from db_connection import  mysql_request_create

def create_table_genre_year():
        request_create_genre_year = ("CREATE TABLE IF NOT EXISTS `queries_genre_year` (id int AUTO_INCREMENT PRIMARY KEY, "
                          "category VARCHAR(32), "
                          "year YEAR, "
                          "name VARCHAR(100), "
                          "request_count INT DEFAULT 1, "
                          "date_of_request DATETIME DEFAULT CURRENT_TIMESTAMP);")
        mysql_request_create(request_create_genre_year)
        print("Table was created successfully")

def create_table_keywords():
        request_create_keywords = ("CREATE TABLE IF NOT EXISTS `queries_keywords` (id int AUTO_INCREMENT PRIMARY KEY, "
                          "keyword VARCHAR(100), "
                          "request_count INT DEFAULT 1, "
                          "date_of_request DATETIME DEFAULT CURRENT_TIMESTAMP);")
        mysql_request_create(request_create_keywords)
        print("Table was created successfully")

create_table_genre_year()
create_table_keywords()
