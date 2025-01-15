import pymysql
from db_connect import db

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
        user_values.append(year)
    if actor:
        filters.append("a.last_name LIKE %s")
        user_values.append(f"%{actor}%")

    # Если нет фильтров, просто получаем все фильмы
    if not filters:
        query = "SELECT * FROM film LIMIT 20"
        return db.mysql_request_select(query)
    condition = " AND ".join(filters)
    return user_values, condition

def get_movies_by_criteria(user_values, condition):
    request_search_movie = f'''select f.film_id, f.title, f.release_year, f.description,  
        GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') AS actors, f.rental_rate
        from category c 
        join film_category fc 
        on c.category_id = fc.category_id 
        join film f 
        on fc.film_id = f.film_id
        join film_actor fa 
        on f.film_id = fa.film_id 
        join actor a 
        on fa.actor_id  = a.actor_id
        WHERE {condition} 
        GROUP BY f.film_id
        ORDER BY f.rental_rate DESC
        '''

    query = f"SELECT * FROM film WHERE {condition} ORDER BY release_year DESC"

    return db.mysql_request_select(request_search_movie, user_values)



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
        request_popular = f'select * from `user_queries` order by request_count desc limit 10'
        return db.mysql_request_select(request_popular)
    except pymysql.Error as er:
        print(f'Database error: {er.errno} : {er.msg}')


condition, values = get_filters_values(title="Inception", genre="Action", year=2010, actor="Nolan")
movies = get_movies_by_criteria(condition, values)