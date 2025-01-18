# db_connect
#
# import pymysql
# import os
# from dotenv import load_dotenv
#
# load_dotenv()
#
# class ConnectionDB:
#     """Class for working with MySQL database."""
#     def __init__(self, host=None,  port=None, user=None, password=None, db=None, cursorclass=None):
#         """Initialize the connection to the database."""
#         self.connection = None
#         try:
#             dbconfig = {
#                             'host': host,
#                             'port': port,
#                             'user': user,
#                             'password': password,
#                             'db': db,
#                             'cursorclass': cursorclass
#             }
#
#
#             # dbconfig = {
#             #                 'host': os.getenv('DB_HOST'),
#             #                 'port': int(os.getenv('DB_PORT')),
#             #                 'user': os.getenv('DB_USER'),
#             #                 'password': os.getenv('DB_PASSWORD'),
#             #                 'db': os.getenv('DB_NAME'),
#             #                 'cursorclass': pymysql.cursors.DictCursor
#             # }
#
#             self.connection = pymysql.connect(**dbconfig)
#             print("Connection successfully established")
#         except Exception as ex:
#             print("Connection refused")
#             print(ex)
#
#     def _execute_query(self, sql, params=None, commit=False):
#         """Execute SQL query and return the result (if any)."""
#         try:
#             with self.connection.cursor() as cursor:
#                 cursor.execute(sql, params)
#                 if commit:
#                     self.connection.commit()
#                 result = cursor.fetchall()  # Save results before exit from 'with' block
#             return result
#         except Exception as ex:
#             print("Query execution failed")
#             print(ex)
#             return None
#
#     def mysql_request_create(self, sql):
#         """Execute CREATE TABLE query."""
#         return self._execute_query(sql, commit=True)
#
#     def mysql_request_update(self, sql, data):
#         """Execute INSERT query."""
#         return self._execute_query(sql, data, commit=True)
#
#     def mysql_request_select(self, sql, params=None):
#         """Execute SELECT query."""
#         return self._execute_query(sql, params)
#
#     def close_connection(self):
#         """Close the connection to the database."""
#         if self.connection:
#             self.connection.close()
#             print("Connection closed")
#
#
# db_write = ConnectionDB(host=os.getenv('DB_HOST_W'), port=int(os.getenv('DB_PORT_W')), user=os.getenv('DB_USER_W'), password=os.getenv('DB_PASSWORD_W'), db=os.getenv('DB_NAME_W'), cursorclass=pymysql.cursors.DictCursor)
# db_read = ConnectionDB(host=os.getenv('DB_HOST_R'), port=int(os.getenv('DB_PORT_R')), user=os.getenv('DB_USER_R'), password=os.getenv('DB_PASSWORD_R'), db=os.getenv('DB_NAME_R'), cursorclass=pymysql.cursors.DictCursor)
#
#
# .env # что будет прописано в этом файле
# DB_HOST_R=localhost
# DB_PORT_R=3306
# DB_USER_R=root
# DB_PASSWORD_R=123
# DB_NAME_R=sakila
#
# DB_HOST_W=localhost
# DB_PORT_W=3306
# DB_USER_W=root
# DB_PASSWORD_W=123
# DB_NAME_W=sakila_write
#
