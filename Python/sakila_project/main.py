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
#__________________________________________________________________________
#
# от 21.01.2025
#
## def search_movies():
#     """Функция поиска фильма по критериям (с использованием user_input)"""
#     title = user_input.get_user_title() or None
#     genre = user_input.get_user_genre() or None
#     release_year = user_input.get_user_year() or None
#     actor_last_name = user_input.get_user_actor() or None
#
#     # Creates a filter condition (condition_filter) based on user input (for exp: WHERE title = %s) and user_values — list of values that will be substituted for placeholders %s
#     condition_filter, user_values = sql_requests.get_filters_values(title, genre, release_year, actor_last_name)  # Getting filters and values
#
#     # Forms a complete SQL query (query) and settings necessary to execute the query.
#     query, settings = sql_requests.get_movies_by_criteria(condition_filter, user_values)
#
#     '''key_query - Contains the names of the columns that the user fills in
#     value_query - Contains placeholders (%s) for inserting values.
#     data_query - List of values entered by the user.'''
#
#     key_query, value_query, data_query = sql_requests.transform_user_request(title, genre, release_year, actor_last_name)
#
#     # write data to the user_queries table
#     if key_query:
#         sql_requests.update_query_table(title=title, genre=genre, release_year=release_year, actor_last_name=actor_last_name)
#     else:
#         print("No search criteria provided. Query will not be saved.")
#
#     if condition_filter is None:
#         print("No search criteria provided.")
#         return
#
#     # movies = get_movies_by_criteria(values_filter, condition_filter)# Получаем фильмы по фильтрам
#
#     # Создаем объект пагинации для результатов
#     pages = MovieByPages(query, settings, page_size=10)
#     pages.page = 1
#     pages.params = settings
#     pages.print_results()
#
#
#__________________________________________________________________
# test.py 2.01.2025

# Пример использования класса для разных запросов

# def get_all_movies_query():
#     """Пример запроса для получения всех фильмов"""
#     return "SELECT film_id, title, release_year FROM film"
#
# def get_movies_by_category_query(category):
#     """Пример запроса для получения фильмов по категории"""
#     return "SELECT film_id, title, release_year FROM film WHERE category = %s", [category]
#
# if __name__ == "__main__":
#     # Печать всех фильмов
#     print("Fetching all movies:")
#     query = get_all_movies_query()
#     paginated_movies = PaginatedQuery(query) # Создаем экземпляры класса
#     paginated_movies.print_results()
#
#     # Печать фильмов по категории
#     category = input("Enter a category to fetch movies: ")
#     print(f"\nFetching movies from category: {category}")
#     query, params = get_movies_by_category_query(category)
#     paginated_movies_by_category = PaginatedQuery(query, params)
#     paginated_movies_by_category.print_results()
#
#
