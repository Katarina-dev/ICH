import pymysql
import os
from dotenv import load_dotenv

load_dotenv()

class ConnectionDB:
    """Class for working with MySQL database."""
    def __init__(self, host=None,  user=None, password=None, db=None, cursorclass=None):
        """Initialize the connection to the database."""
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
        return self._execute_query(sql, data, commit=True)

    def mysql_request_select(self, sql, params=None):
        """Execute SELECT query."""
        return self._execute_query(sql, params)

    def close_connection(self):
        """Close the connection to the database."""
        if self.connection:
            self.connection.close()
            print("Connection closed")


db = ConnectionDB()


