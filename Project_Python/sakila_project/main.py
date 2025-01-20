from Project_Python.sakila_project.sql_requests import create_table_user_requests
from Project_Python.sakila_project.sql_requests import update_query_table, transform_user_request
from sql_requests import get_filters_values, get_movies_by_criteria, get_popular_user_requests
from print_tables import MovieByPages
from user_input import get_user_title, get_user_genre, get_user_year, get_user_actor

def main():
    create_table_user_requests()
    print("Welcome to program for working with Database \"MOVIES\"!\n"
          "Please input the required option for further work:\n"
          "1. View a list of all movies\n"
          "2. Search for a movie\n"
          "3. Popular queries\n"
          "4. Exit"
          )

    def get_all_movies():
        """Функция вывода всех фильмов"""
        condition_filter, user_values = get_filters_values()  #Getting empty filters (all movies)
        query, settings = get_movies_by_criteria(user_values, condition_filter)  # Получаем запрос

        if not query:
            print("No movies found.")
            return

        # Создаем объект пагинации с корректным SQL-запросом
        pages = MovieByPages(query, settings, page_size=10)
        pages.print_results()


    def search_movies():
        """Функция поиска фильма по критериям (с использованием user_input)"""
        title = get_user_title() or None
        genre = get_user_genre() or None
        release_year = get_user_year() or None
        actor_last_name = get_user_actor() or None



        condition_filter, user_values = get_filters_values(title, genre, release_year, actor_last_name)  # Получаем пустые фильтры (все фильмы)
        query, settings = get_movies_by_criteria(condition_filter, user_values)  # Получаем запрос

        '''key_query Содержит названия колонок, которые заполняет пользователь
        value_query Содержит плейсхолдеры (%s) для вставки значений.
        data_query Список значений, введённых пользователем.'''

        key_query, value_query, data_query = transform_user_request(title, genre, release_year, actor_last_name)

        # Записываем данные в таблицу user_queries
        if key_query:
            update_query_table(title=title, genre=genre, release_year=release_year, actor_last_name=actor_last_name)
        else:
            print("No search criteria provided. Query will not be saved.")

        if condition_filter is None:
            print("No search criteria provided.")
            return

        # movies = get_movies_by_criteria(values_filter, condition_filter)# Получаем фильмы по фильтрам

        # Создаем объект пагинации для результатов
        pages = MovieByPages(query, settings, page_size=10)
        pages.page = 1
        pages.params = settings
        pages.print_results()

    def show_popular_queries():
        popular_queries = get_popular_user_requests()

        if not popular_queries:
            print("No popular queries found.")
            return

        # Create an instance of MovieByPages and call print_results
        pages = MovieByPages(popular_queries, page_size=10)
        pages.print_results()

    while True:
        user_option = input("\nInput your option:").strip()

        if not user_option.isdigit():
            print("Invalid input. Please enter a number (1-4).")
            continue

        user_option = int(user_option)

        if user_option == 1:
            get_all_movies()

        elif user_option == 2:
            search_movies()

        elif user_option == 3:
            show_popular_queries()

        elif user_option == 4:
            print("Goodbye!")
            break

        else:
            print("Invalid option. Please enter a number (1-4).")

        #     if condition_query is None:
        #         print("No filters provided. Showing default movies list.")
        #         pages.print_results()
        #         return
        #
        #     if not movies:
        #         print("\nNo movies found matching your criteria.")
        #         return
        #
        # def show_popular_queries():
        #     """Функция вывода популярных запросов"""
        #     popular_queries = get_popular_user_requests()
        #
        #     if not popular_queries:
        #         print("No popular queries found.")
        #         return
        #
        #     print("\nTop 10 popular searches:")
        #     print(tabulate(popular_queries, headers="keys", tablefmt="fancy_grid"))

if __name__ == "__main__":
    main()
