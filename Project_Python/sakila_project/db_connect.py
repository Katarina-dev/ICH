from multiprocessing.connection import Connection
from sqlite3 import IntegrityError, OperationalError
from urllib.parse import uses_query

import pymysql
import os
from dotenv import load_dotenv
from typing import Optional, Dict, Any, Union

load_dotenv()

class ConnectionDB:
    """Class for working with MySQL database."""
    def __init__(self):
        """Initialize the connection to the database using .env variables"""
        self.connection: Optional[Connection] = None #needed to ensure the finally block works correctly and to prevent errors when trying to close a connection if it was not successfully established.

        # required_env_vars = ['DB_HOST', 'DB_PORT', 'DB_USER', 'DB_PASSWORD', 'DB_NAME']
        # for var in required_env_vars:
        #     if not os.getenv(var):
        #         raise EnvironmentError(f"Missing required environment variable: {var}")

        # try:
        dbconfig: Dict[str, Any] = {
                        'host': os.getenv('DB_HOST'),
                        'port': int(os.getenv('DB_PORT')),
                        'user': os.getenv('DB_USER'),
                        'password': os.getenv('DB_PASSWORD'),
                        'db': os.getenv('DB_NAME'),
                        'cursorclass': pymysql.cursors.DictCursor
        }
        self.connection = pymysql.connect(**dbconfig)
        # except Exception as ex:
        #     raise ConnectionError(f"Connection refused: {ex}")

    def _execute_query(self, sql: str, params: Optional[Union[Dict[str, Any], list]] = None, commit: bool = False) -> Optional[list]:
        """Execute SQL query and return the result (if any)."""
        # try:
        with self.connection.cursor() as cursor:
            cursor.execute(sql, params)
            if commit:
                self.connection.commit()
            result = cursor.fetchall()  # Save results before exit from 'with' block
        return result
        # except Exception as ex:
        #     raise RuntimeError(f"Query execution failed: {ex}")

    def mysql_request_create(self, sql: str) -> Optional[list]:
        """Execute CREATE TABLE query."""
        return self._execute_query(sql, commit=True)

    def mysql_request_update(self, sql: str, data: Optional[Union[Dict[str, Any], list]] = None) -> Optional[list]:
        """Execute INSERT INTO query."""
        return self._execute_query(sql, data, commit=True)


    def mysql_request_select(self, sql:str, params:Optional[Union[Dict[str, Any], list]]=None) -> Optional[list]:
        """Execute SELECT query."""
        return self._execute_query(sql, params)

    def rollback(self) -> None:
        """Rollback the current transaction."""
        if self.connection:
            self.connection.rollback()

    # def table_exists(self, user_queries: str) -> bool:
    #     """Check if a table exists in the database."""
    #     try:
    #         query = "SHOW TABLES LIKE %s"
    #         result = self._execute_query(query, [user_queries])
    #         return bool(result)
    #     except Exception as ex:
    #         raise RuntimeError(f"Failed to check table existence: {ex}")

    def close_connection(self) -> None:
        """Close the connection to the database."""
        if self.connection:
            # try:
            self.connection.close()
            self.connection = None  #reset the connection to avoid closing it again
            # except Exception as ex:
            #     raise ConnectionError(f"Error closing connection: {ex}")


try:
    db = ConnectionDB()
except ConnectionError as conn_err:
    print("Connection error:", conn_err)
except EnvironmentError as env_err:
    print("Environment error:", env_err)




