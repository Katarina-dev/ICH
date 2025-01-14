
# Пример использования класса для разных запросов

def get_all_movies_query():
    """Пример запроса для получения всех фильмов"""
    return "SELECT film_id, title, release_year FROM film"

def get_movies_by_category_query(category):
    """Пример запроса для получения фильмов по категории"""
    return "SELECT film_id, title, release_year FROM film WHERE category = %s", [category]

if __name__ == "__main__":
    # Печать всех фильмов
    print("Fetching all movies:")
    query = get_all_movies_query()
    paginated_movies = PaginatedQuery(query) # Создаем экземпляры класса
    paginated_movies.print_results()

    # Печать фильмов по категории
    category = input("Enter a category to fetch movies: ")
    print(f"\nFetching movies from category: {category}")
    query, params = get_movies_by_category_query(category)
    paginated_movies_by_category = PaginatedQuery(query, params)
    paginated_movies_by_category.print_results()