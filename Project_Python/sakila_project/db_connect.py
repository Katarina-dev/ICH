import pymysql
import os
from dotenv import load_dotenv
from typing import Optional, Dict, Any, Union

load_dotenv()

class ConnectionDB:
    """Class for working with MySQL database."""
    def __init__(self):
        """Initialize the connection to the database using .env variables"""
        self.connection = None #needed to ensure the finally block works correctly and to prevent errors when trying to close a connection if it was not successfully established.
        try:
            dbconfig: Dict[str, Any] = {
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

    def _execute_query(self, sql: str, params: Optional[Union[Dict[str, Any], list]] = None, commit: bool = False) -> Optional[list]:
        """Execute SQL query and return the result (if any)."""
        try:
            with self.connection.cursor() as cursor:
                cursor.execute(sql, params)
                if commit:
                    self.connection.commit()
                result = cursor.fetchall()  # Save results before exit from 'with' block
            return result
        except Exception as ex:
            print("Query execution failed")
            print(ex)
            return None

    def mysql_request_create(self, sql):
        """Execute CREATE TABLE query."""
        return self._execute_query(sql, commit=True)

    def mysql_request_update(self, sql, data):
        """Execute INSERT query."""
        try:
            return self._execute_query(sql, data, commit=True)
        except Exception as er:
            print(f'Database error: {er.errno} : {er.msg}')
            return "Database error occurred."

    def mysql_request_select(self, sql, params=None):
        """Execute SELECT query."""
        return self._execute_query(sql, params)

    def close_connection(self):
        """Close the connection to the database."""
        if self.connection:
            try:
                self.connection.close()
                self.connection = None  #reset the connection to avoid closing it again
                return f"Connection closed"
            except Exception as ex:
                return f'Connection refused. Error: {ex}'
        return f'No active connection to close'


db = ConnectionDB()
# db.connection = None  # 1. Проверяем случай, когда соединение отсутствует
# print(db.close_connection())  # Ожидаем: "No active connection to close"
#
# db.connection = type("FakeConnection", (), {"close": lambda: 1 / 0})()  # 2. Ошибка при закрытии
# print(db.close_connection())  # Ожидаем: "Error while closing connection: division by zero"

