import pymysql
from db_connect import db
from user_input import get_user_title

def create_table_genre_year():
        request_create_genre_year = ("CREATE TABLE IF NOT EXISTS `queries_genre_year` (id int AUTO_INCREMENT PRIMARY KEY, "
                          "category VARCHAR(32), "
                          "year YEAR, "
                          "name VARCHAR(100), "
                          "request_count INT DEFAULT 1, "
                          "date_of_request DATETIME DEFAULT CURRENT_TIMESTAMP);")
        db.mysql_request_create(request_create_genre_year)
        return f'Table queries_genre_year was created successfully'

def create_table_keywords():
        request_create_keywords = ("CREATE TABLE IF NOT EXISTS `queries_keywords` (id int AUTO_INCREMENT PRIMARY KEY, "
                          "keyword VARCHAR(100), "
                          "request_count INT DEFAULT 1, "
                          "date_of_request DATETIME DEFAULT CURRENT_TIMESTAMP);")
        db.mysql_request_create(request_create_keywords)
        return f'Table queries_keywords was created successfully'

create_table_genre_year()
create_table_keywords()

def get_all_movies():
    try:
        request_all_movies = f'''select f.film_id, f.title, f.release_year, f.description,  GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') AS actors
        from category c 
        join film_category fc 
        on c.category_id = fc.category_id 
        join film f 
        on fc.film_id = f.film_id
        join film_actor fa 
        on f.film_id = fa.film_id 
        join actor a 
        on fa.actor_id  = a.actor_id 
        GROUP BY f.film_id
        '''
        return db.mysql_request_select(request_all_movies)
    except pymysql.Error as er:
        print(f'Database error: {er.errno} : {er.msg}')

def search_by_title(title):
    request_title = f'''select f.film_id, f.title, f.release_year, f.description,  GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') AS actors
        from category c 
        join film_category fc 
        on c.category_id = fc.category_id 
        join film f 
        on fc.film_id = f.film_id
        join film_actor fa 
        on f.film_id = fa.film_id 
        join actor a 
        on fa.actor_id  = a.actor_id
        where c.category_id = %s 
        GROUP BY f.film_id
        '''
    result_title = db.mysql_request_select(request_title, params=[f"%{title}%"])
    return result_title

def get_all_categories():
    try:
        request_all_categories = f"select category_id, name from category;"
        return db.mysql_request_select(request_all_categories)
    except db.mysql_request_select.Error as er:
        print(f'Database error: {er.errno} : {er.msg}')

def search_by_genres():
    try:
        request_genre = f'''select f.title, f.release_year, f.description,  GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') AS actors
        from category c 
        join film_category fc 
        on c.category_id = fc.category_id 
        join film f 
        on fc.film_id = f.film_id
        join film_actor fa 
        on f.film_id = fa.film_id 
        join actor a 
        on fa.actor_id  = a.actor_id 
        where c.category_id = %s
        GROUP BY f.film_id
        '''
        return db.mysql_request_select(request_genre)
    except pymysql.Error as er:
        print(f'Database error: {er.errno} : {er.msg}')

def search_by_year(year):
    try:
        request_year = f'''select f.title, f.release_year, f.description,  GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') AS actors
        from category c 
        join film_category fc 
        on c.category_id = fc.category_id 
        join film f 
        on fc.film_id = f.film_id
        join film_actor fa 
        on f.film_id = fa.film_id 
        join actor a 
        on fa.actor_id  = a.actor_id 
        where f.release_year = %s
        GROUP BY f.film_id
        '''
        result_request_year = db.mysql_request_select(request_year, params=[f"%{year}%"])
        return db.mysql_request_select(result_request_year)
    except pymysql.Error as er:
        print(f'Database error: {er.errno} : {er.msg}')

def search_by_actor():
    try:
        request_genre = f'''select f.title, f.release_year, f.description,  GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') AS actors
        from category c 
        join film_category fc 
        on c.category_id = fc.category_id 
        join film f 
        on fc.film_id = f.film_id
        join film_actor fa 
        on f.film_id = fa.film_id 
        join actor a 
        on fa.actor_id  = a.actor_id 
        where c.category_id = %s
        GROUP BY f.film_id
        '''
        return db.mysql_request_select(request_genre)
    except pymysql.Error as er:
        print(f'Database error: {er.errno} : {er.msg}')

# def get_movies_by_page(page, page_size=10):
#     """Получает фильмы с постраничным выводом (LIMIT, OFFSET). Начинаем с 1й строки"""
#     offset = (page - 1) * page_size  # Смещение, чтобы пропустить предыдущие страницы
#     try:
#         query = "SELECT film_id, title, description, release_year FROM film LIMIT %s OFFSET %s" # оператор offset позволяет выводитьрезультаты со смещением на указанное кол-во строк
#         return db.mysql_request_select(query, (page_size, offset))
#     except pymysql.Error as er:
#         print(f'Database error: {er.errno} : {er.msg}')
#         return [] # в случае ошибки выведется пустой список

# def get_user_genre_year():
#     genre = input('Input genre: ')  # убрать инпуты из функции
#     year = int(input('Input year: '))
#     name = input('Input name: ')
#     return genre, year, name
#
#
# def update_query_table(genre, year, name):
#     # data = genre, year, name
#     request_update = "INSERT INTO `queries_genre_year` (category, year, name) VALUES (%s, %s, %s)"
#     db.mysql_request_update(request_update, (genre, year, name))
#     return f'Table was updated successfully'
#
# genre, year, name = get_user_genre_year()
# update_query_table(genre, year, name)
#
#
# def get_user_title():
#     title = input('Input film title:')
#     return title
#
#
# def get_query_title(title):
#     request_query_title = "select * from film where title like %s;"
#     result_query_title = db.mysql_request_select(request_query_title, params=[f"%{title}%"])
#     return result_query_title
#
# def print_table(result_query_title):
#     if result_query_title:
#         for row in result_query_title:
#             print(row)
#             print("#" * 30)
#     else:
#         print('No movies found for your request')
#
# title = get_user_title()
# res_title = get_query_title(title)
# print_table(res_title)