import pymysql
import unittest

def mysql_request_create(sql):
    try:
        connection = pymysql.connect(host='localhost',
                                     port=3306,
                                     user='root',
                                     password='123',
                                     db='sakila',
                                     cursorclass=pymysql.cursors.DictCursor)
        print("Connection successfully")

        with connection.cursor() as cursor:
            # Read all records
            cursor.execute(sql)
            connection.commit()
            result = cursor.fetchall()

    except Exception as ex:
        print("Connection refused")
        print(ex)
        return None

    finally:
        # cursor.close()
        # connection.close()
        if connection and connection.open:
            # print('Connection still open!')
            connection.close()
            print('Connection closed')

def mysql_request_update(request_update, data):
    connection = None
    try:
        connection = pymysql.connect(host='localhost',
                                     port=3306,
                                     user='root',
                                     password='123',
                                     db='sakila',
                                     cursorclass=pymysql.cursors.DictCursor)
        print("Connection successfully")


        with connection.cursor() as cursor:
                # Read all records
            cursor.execute(request_update, data)
            connection.commit()
            result = cursor.fetchall()

    except Exception as ex:
        print("Connection refused")
        print(ex)
        return None

    finally:
        # cursor.close()
        # connection.close()
        if connection and connection.open:
            # print('Connection still open!')
            connection.close()
            print('Connection closed')


def create_table_user_requests():
    """Создает таблицу user_queries, если она не существует."""
    user_queries = """
        CREATE TABLE IF NOT EXISTS `user_queries` (
            id INT AUTO_INCREMENT PRIMARY KEY,
            title VARCHAR(100),
            genre VARCHAR(32),
            year YEAR,
            actor_last_name VARCHAR(50),
            request_count INT DEFAULT 1,
            date_of_request DATETIME DEFAULT CURRENT_TIMESTAMP,
            UNIQUE KEY unique_query (title, genre, year, actor_last_name) -- Уникальный ключ
        );
    """
    mysql_request_create(user_queries)
    return 'Table user_queries was created successfully'


def insert_or_update_user_request(title, genre, year, actor_last_name):
    """Вставляет новую запись или обновляет request_count, если запись уже существует."""
    query = """
        INSERT INTO `user_queries` (title, genre, year, actor_last_name, request_count)
        VALUES (%s, %s, %s, %s, 1)
        ON DUPLICATE KEY UPDATE request_count = request_count + 1;
    """
    mysql_request_update(query, (title, genre, year, actor_last_name))
    return 'Request was recorded successfully'

create_table_user_requests()
# Пример использования:
title = input("Enter movie title: ")
genre = input("Enter movie genre: ")
year = input("Enter release year: ")
actor_last_name = input("Enter actor's last name: ")

result_message = insert_or_update_user_request(title, genre, year, actor_last_name)
print(result_message)