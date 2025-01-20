import pymysql
from db_connect import db
from typing import Optional, Tuple, List, Union


def create_table_user_requests() -> str:
    """Creates a table 'user_queries' in the database if it does not exist.

        This function sends a SQL query to the database to create a table that stores
        user search queries. The table includes columns for the movie title, genre,
        release year, actor's last name, the count of requests, and the timestamp of the request.

        Returns:
            str: A success message confirming that the table was created.
        """
    user_queries = ('''CREATE TABLE IF NOT EXISTS `user_queries` (id int AUTO_INCREMENT PRIMARY KEY, 
                    title VARCHAR(100) DEFAULT '',
                    genre VARCHAR(32) DEFAULT '',
                    release_year YEAR DEFAULT 0, 
                    actor_last_name VARCHAR(50) DEFAULT '', 
                    request_count INT DEFAULT 1,
                    date_of_request DATETIME DEFAULT CURRENT_TIMESTAMP,
                    UNIQUE KEY idx_user_request (title, genre, release_year, actor_last_name));''') #A unique index is created for the combination of title, genre, release_year, actor_last_name columns. This ensures that there are no duplicate queries with the same parameters in the table and necessary for count user queries.
    db.mysql_request_create(user_queries)
    return f'Table user_queries was created successfully'

def get_filters_values(title:Optional[str] =None, genre:Optional[str]=None, release_year: Optional[int]=None, actor_last_name:Optional[str]=None)-> Tuple[Optional[str], List[str]]:#If the user does not pass any of these parameters, they are automatically set to None.
    """Searches for movies based on user input.

    This function constructs SQL query conditions and corresponding values based on the provided
    movie title, genre, release year, and actor's last name.

    Args:
        title (str, optional): The title of the movie. Defaults to None.
        genre (str, optional): The genre of the movie. Defaults to None.
        release_year (int, optional): The release year of the movie. Defaults to None.
        actor_last_name (str, optional): The last name of the actor. Defaults to None.

    Returns:
        tuple: A tuple is formed in which two values are passed: condition_query is a
        string with sql condition for substitution into the query and user_values
        are the parameter values that will be substituted into the %s parameter
    """
    filters = []
    user_values = []

    if title:
        filters.append("f.title LIKE %s")
        user_values.append(f"%{title}%")
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

def get_movies_by_criteria(condition_query: Optional[str], user_values: Optional[str]) -> tuple[str, str | None] | None:
    """Returns a query to search for movies based on user input.

    This function constructs an SQL query to search for movies based on the provided
    condition query and user values. It includes details such as film ID, title, genre,
    release year, description, actors, rental rate, rating, and rating description.

    Args:
        condition_query (Optional[str]): The SQL condition query string.
        user_values (List[str]): The list of user values to be used in the query.

    Returns:
        Tuple[Optional[str], List[str]]: A tuple containing the constructed SQL query string
        and the list of user values.
    """
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
        request_movies += f" WHERE {condition_query} "
    request_movies += " GROUP BY f.film_id"
    try:
        return request_movies, user_values
    except Exception as e:
        print(f"Error executing query: {e}")
        return None

def transform_user_request(title:Optional[str]=None, genre:Optional[str]=None, release_year: Optional[int]=None, actor_last_name:Optional[str]=None) -> Tuple[str, str, List[str | int]]:
    """Forms a user request, removing None values.

    Args:
        title (Optional[str]): Movie title.
        genre (Optional[str]): The genre of the movie.
        release_year (Optional[int]): The year the movie was released.
        actor_last_name (Optional[str]): Actor's last name.

    Returns:
        Tuple[str, str, List[str | int]]:
            - `key_query`: A string containing the field names for the query, separated by commas.
            - `value_query`: String with placeholders (`%s`), corresponding"""
    user_search = {
        "title": title,
        "genre": genre,
        "release_year": release_year,
        "actor_last_name": actor_last_name
    }

    filtered_search = {}
    for field, value in user_search.items():
        if value is not None:
            filtered_search[field] = value# Removes None-values

    if not filtered_search:
        print("No data provided.")
        return "", "", []

    key_query = ", ".join(filtered_search.keys())
    value_query = ", ".join(["%s"] * len(filtered_search))
    data_query = list(filtered_search.values())
    return key_query, value_query, data_query

def build_insert_query(key_query: str, value_query: str) -> str:
    """Forms an SQL query to insert or update a record in the `user_queries` table.

    Args:
        key_query (str): A string containing the names of the fields to insert.
        value_query (str): A string with placeholders (%s) corresponding to the values.

    Returns:
        str: Generated SQL query that can be executed to insert or update the record.

    Example:
        If key_query = "title, genre", value_query = "%s, %s", the resulting query will be:
        "INSERT INTO user_queries (title, genre, request_count) VALUES (%s, %s, %s)
        ON DUPLICATE KEY UPDATE request_count = request_count + 1;"
    """
    return f"""
        INSERT INTO user_queries ({key_query}, request_count)
        VALUES ({value_query}, %s)
        ON DUPLICATE KEY UPDATE request_count = request_count + 1;
    """

def update_query_table(title:Optional[str]=None, genre:Optional[str] = None, release_year: Optional[int] = None, actor_last_name:Optional[str] = None) -> Optional[str]:
    """Handles the process of updating or inserting user query data into the database.

        Args:
            title (Optional[str]): Movie title.
            genre (Optional[str]): Movie genre.
            release_year (Optional[int]): Year the movie was released.
            actor_last_name (Optional[str]): Actor's last name.

        Returns:
            Optional[str]: Result message indicating the outcome of the database operation,
            or None if the operation was successful.
        """
    try:
        # Используем transform_user_request для формирования запроса
        key_query, value_query, data_query = transform_user_request(title, genre, release_year, actor_last_name)
        # Add value 1 to data_query for request_count
        data_query.append(1)
        # Create an SQL query using the build_insert_query function
        request_update = build_insert_query(key_query, value_query)
        # Via the data_query parameter, values are passed to the SQL query for placeholders
        db.mysql_request_update(request_update, data_query)
    except pymysql.Error as er:
        # Handle database-specific errors
        return f'Database error: {er.errno} : {er.msg}'
    except Exception as e:
        # Catch any other unexpected errors
        return f"An unexpected error occurred: {e}"


def get_popular_user_requests() -> Optional[str]:
    """Generates and executes an SQL query to retrieve the most popular user queries based on the request count.

    This function constructs a SQL query to select all records from the `user_queries` table,
    ordered by the `request_count` field in descending order, and executes it to retrieve the data.

    Returns:
        Optional[str]: The SQL query string to retrieve the most popular user requests.

    Raises:
        pymysql.Error: If there is an error with the database query, it raises a MySQL error.
        Exception: If there is any other unexpected error.
    """
    try:
        request_popular = f'SELECT * FROM `user_queries` ORDER BY request_count desc'
        # Return a query string to pass to MovieByPages.print_results, which is called in the show_popular_queries() function of the main module
        return request_popular
    except pymysql.Error as er:
        return f'Database error at getting popular requests: {er.errno} : {er.msg}'
    except Exception as e:
        return f"An unexpected error occurred at getting popular requests: {e}"

