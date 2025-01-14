# import mysql.connector
# from local_settings import HOST, USER, PASSWORD, DATABASE
# import pymysql.cursor
#
#
#
# try:
#     connection = pymysql.connect(host='localhost',
#                              user='user',
#                              password='passwd',
#                              database='db',
#                              charset='utf8mb4',
#                              cursorclass=pymysql.cursors.DictCursor
#                             )
#     print("Connection successfully")
# except Exception as ex:
#     print("Connection refused")
#     print(ex)
# return connection
#
# with connection:
#     with connection.cursor() as cursor:
#         create_table_query = "CREATE TABLE IF NOT EXISTS 'users' (id int AUTO_INCREMENT PRIMARY KEY,"\
#                             "category varchar(32),"\
#                             "year int,"\
#                             "name varchar(100);"
#         cursor.execute(create_table_query)
#         print("Table create successfully")
#
#     with connection.cursor() as cursor:
#         query_keywords = "select * from film where title like '%ACADEMY DINOSAUR%';"
#         cursor.execute(query_keywords)
#         rows = cursor.fetchall()
#         for row in rows:
#             print(row)
#         print("#" * 30)
#     #     # Create a new record
#     #     sql = "INSERT INTO `users` (`email`, `password`) VALUES (%s, %s)"
#     #     cursor.execute(sql, ('webmaster@python.org', 'very-secret'))
#     #
#     #     # connection is not autocommit by default. So you must commit to save
#     #     # your changes.
#     # connection.commit()
#     #
#     # with connection.cursor() as cursor:
#     #     # Read a single record
#     #     sql = "SELECT `id`, `password` FROM `users` WHERE `email`=%s"
#     #     cursor.execute(sql, ('webmaster@python.org',))
#     #     result = cursor.fetchone()
#     #     print(result)
#
# # )
#
# finally:
#     cursor.close()
# print("Импорт прошел успешно!")
#
#
#
#
#
#
#
#
#
#
