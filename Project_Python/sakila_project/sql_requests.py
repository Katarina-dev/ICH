import pymysql
from db_connect import db


def create_table_user_requests():
    user_queries = ('''CREATE TABLE IF NOT EXISTS `user_queries` (id int AUTO_INCREMENT PRIMARY KEY, 
                    title VARCHAR(100) DEFAULT '',
                    genre VARCHAR(32) DEFAULT '',
                    release_year YEAR DEFAULT 0, 
                    actor_last_name VARCHAR(50) DEFAULT '', 
                    request_count INT DEFAULT 1,
                    date_of_request DATETIME DEFAULT CURRENT_TIMESTAMP,
                    UNIQUE KEY idx_user_request (title, genre, release_year, actor_last_name));''')
    db.mysql_request_create(user_queries)
    return f'Table user_queries was created successfully'

def get_filters_values(title=None, genre=None, release_year=None, actor_last_name=None):
    """Searches for movies based on user input."""

    filters = []
    user_values = []


    if title:
        filters.append("f.title LIKE %s")
        user_values.append(f"%{title}%")  # Поиск по подстроке
    if genre:
        filters.append("c.name LIKE %s")
        user_values.append(f"%{genre}%")
    if release_year:
        filters.append("f.release_year = %s")
        user_values.append(f"{release_year}")
    if actor_last_name:
        filters.append("a.last_name LIKE %s")
        user_values.append(f"%{actor_last_name}%")
    if not filters: # If there are no filters, we just get all the movies
        return None, []

    condition_query = " AND ".join(filters)
    return condition_query, user_values

def get_movies_by_criteria(user_values, condition_query):
    '''Returns a query to search for movies based on user input.'''

    request_movies = '''SELECT f.film_id, f.title, 
            GROUP_CONCAT(distinct c.name separator ', ') as genre,
            f.release_year, f.description,  
            GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') AS actors, 
            f.rental_rate, f.rating,
            CASE
            WHEN f.rating = 'G' THEN 'All age categories'
            WHEN f.rating = 'PG' THEN 'Parental supervision is recommended'
            WHEN f.rating = 'PG-13' THEN 'For children under 13 years old'
            WHEN f.rating = 'R' THEN 'Restricted, requires adult accompaniment'
            WHEN f.rating = 'NC-17' THEN 'Only for viewers from 18 years old'
            ELSE 'No rating'
        END AS rating_description
        FROM category c 
            join film_category fc 
            on c.category_id = fc.category_id 
            join film f 
            on fc.film_id = f.film_id
            join film_actor fa 
            on f.film_id = fa.film_id 
            join actor a 
            on fa.actor_id  = a.actor_id '''

    if condition_query:
        request_movies += f" WHERE {condition_query}"
        request_movies += " GROUP BY f.film_id ORDER BY f.rental_rate DESC"
    else:
        request_movies += " GROUP BY f.film_id ORDER BY f.rental_rate DESC"
    try:
        return request_movies, user_values
    except Exception as e:
        print(f"Error executing query: {e}")
        return None
    # return db.mysql_request_select(request_movies, user_values)


def transform_user_request(title=None, genre=None, release_year=None, actor_last_name=None):
    """Добавляет новый запрос или увеличивает request_count, если такой уже есть."""

    # Убираем пустые значения
    user_search = {
        "title": title,
        "genre": genre,
        "release_year": release_year,
        "actor_last_name": actor_last_name
    }
    user_search = {field: value for field, value in user_search.items() if value is not None}  # Удаляем пустые значения
    if not user_search:
        print("No data provided.")

    key_query = ", ".join(user_search.keys())
    value_query = ", ".join(["%s"] * len(user_search))
    data_query = list(user_search.values())
    return key_query, value_query, data_query


def update_query_table(title=None, genre=None, release_year=None, actor_last_name=None):
    try:
        # Используем transform_user_request для формирования запроса
        key_query, value_query, data_query = transform_user_request(title, genre, release_year, actor_last_name)

        if not key_query:  # Если нет данных, выходим
            print("No data provided for the query update.")
            return

        data_query.append(1)

        # Формируем SQL-запрос
        request_update = f"""
            INSERT INTO user_queries ({key_query}, request_count)
            VALUES ({value_query},%s)
            ON DUPLICATE KEY UPDATE request_count = request_count + 1;
            """



        # Выполняем SQL-запрос
        db.mysql_request_update(request_update, data_query)  # Добавляем значение

        return "Request recorded or updated."
    except pymysql.Error as er:
        print(f'Database error: {er.errno} : {er.msg}')
        return "Database error occurred."
    # try:
    #     request_update = f"""
    #     INSERT INTO user_queries ({title}, {genre}, {year}, {actor}, request_count)
    #     VALUES (%s, %s, %s, %s, 1)
    #     ON DUPLICATE KEY UPDATE request_count = request_count + 1;
    # """
    #     db.mysql_request_update(request_update)
    #     return "Request recorded or updated."
    # except pymysql.Error as er:
    #     print(f'Database error: {er.errno} : {er.msg}')


def get_popular_user_requests():
    try:
        request_popular = f'SELECT * FROM `user_queries` ORDER BY request_count desc'
        return request_popular
        # return db.mysql_request_select(request_popular)
    except pymysql.Error as er:
        print(f'Database error: {er.errno} : {er.msg}')


# condition, user_values = get_filters_values(title="Inception", genre="Action", year=2010, actor="Nolan")
# movies = get_movies_by_criteria(user_values, condition )