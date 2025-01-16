import pymysql
from db_connect import db


def create_table_user_requests():
    user_queries = ('''CREATE TABLE IF NOT EXISTS `user_queries` (id int AUTO_INCREMENT PRIMARY KEY, 
                    title VARCHAR(100),
                    genre VARCHAR(32),
                    year YEAR, 
                    actor_last_name VARCHAR(50), 
                    request_count INT DEFAULT 1,
                    date_of_request DATETIME DEFAULT CURRENT_TIMESTAMP,
                    UNIQUE KEY user_request (title, genre, year, actor_last_name);''')
    db.mysql_request_create(user_queries)
    return f'Table user_queries was created successfully'

def get_filters_values(title=None, genre=None, year=None, actor=None):
    """Ищет фильмы по введённым пользователем критериям."""

    filters = []
    user_values = []


    if title:
        filters.append("f.title LIKE %s")
        user_values.append(f"%{title}%")  # Поиск по подстроке
    if genre:
        filters.append("c.name LIKE %s")
        user_values.append(f"%{genre}%")
    if year:
        filters.append("f.release_year = %s")
        user_values.append(f"{year}")
    if actor:
        filters.append("a.last_name LIKE %s")
        user_values.append(f"%{actor}%")

    # Если нет фильтров, просто получаем все фильмы
    if not filters:
        return None, []

    condition_query = " AND ".join(filters)
    return condition_query, user_values

def get_movies_by_criteria(user_values, condition_query):

    request_movies = '''SELECT f.film_id, f.title, f.release_year, f.description,  
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
        # return db.mysql_request_select(request_movies, user_values)
        return request_movies, user_values
    except Exception as e:
        print(f"Error executing query: {e}")
        return None
    # return db.mysql_request_select(request_movies, user_values)


def transform_user_request(title=None, genre=None, year=None, actor_last_name=None):
    """Добавляет новый запрос или увеличивает request_count, если такой уже есть."""

    # Убираем пустые значения
    user_search = {
        "title": title,
        "genre": genre,
        "year": year,
        "actor_last_name": actor_last_name
    }
    user_search = {field: value for field, value in user_search.items() if value is not None}  # Удаляем пустые значения
    if not user_search:
        print("No data provided.")

    key_query = ", ".join(user_search.keys())
    value_query = ", ".join(["%s"] * len(user_search))
    data_query = list(user_search.values())
    return key_query, value_query, data_query


def update_query_table(key_query, value_query, data_query):
    try:
        request_update = f"""
        INSERT INTO user_queries ({key_query}, request_count)
        VALUES ({value_query}, 1)
        ON DUPLICATE KEY UPDATE request_count = request_count + 1;
    """
        db.mysql_request_update(request_update, data_query)
        return "Request recorded or updated."
    except pymysql.Error as er:
        print(f'Database error: {er.errno} : {er.msg}')


def get_popular_user_requests():
    try:
        request_popular = f'SELECT * FROM `user_queries` ORDER BY request_count desc limit 10'
        return db.mysql_request_select(request_popular)
    except pymysql.Error as er:
        print(f'Database error: {er.errno} : {er.msg}')


condition, user_values = get_filters_values(title="Inception", genre="Action", year=2010, actor="Nolan")
movies = get_movies_by_criteria(user_values, condition )