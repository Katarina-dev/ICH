import pymysql
import os
from dotenv import load_dotenv

load_dotenv()

class ConnectionDB:
    def __init__(self, host=None,  user=None, password=None, db=None, cursorclass=None):
        self.connection = None
        try:
            dbconfig = {
                            'host': os.getenv('DB_HOST'),
                            'port': int(os.getenv('DB_PORT')),
                            'user': os.getenv('DB_USER'),
                            'password': os.getenv('DB_PASSWORD'),
                            'db': os.getenv('DB_NAME'),
                            'cursorclass': pymysql.cursors.DictCursor
            }

            self.connection = pymysql.connect(**dbconfig)
            print("Connection successfully established")
        except Exception as ex:
            print("Connection refused")
            print(ex)

    def _execute_query(self, sql, params=None, commit=False):
        """Выполняет SQL-запрос и возвращает результат (если есть)."""
        try:
            with self.connection.cursor() as cursor:
                cursor.execute(sql, params)
                if commit:
                    self.connection.commit()
                result = cursor.fetchall()  # Сохраняем результат перед выходом из `with`
            return result
        except Exception as ex:
            print("Query execution failed")
            print(ex)
            return None

    def mysql_request_create(self, sql):
        """Выполняет CREATE-запрос (или другой запрос, требующий commit)."""
        return self._execute_query(sql, commit=True)

    # def mysql_request_update(self, sql, data):
    #     """Выполняет UPDATE-запрос с передачей данных."""
    #     return self._execute_query(sql, data, commit=True)

    def mysql_request_update(self, sql, data):
        """Выполняет UPDATE-запрос с передачей данных."""
        return self._execute_query(sql, data, commit=True)

    def mysql_request_select(self, sql, params=None):
        """Выполняет SELECT-запрос и возвращает результат."""
        return self._execute_query(sql, params)

    def close_connection(self):
        """Закрывает соединение"""
        if self.connection:
            self.connection.close()
            print("Connection closed")


db = ConnectionDB()


