import pymysql
from tabulate import tabulate

from Project_Python.sakila_project.sql_requests import movies
from db_connect import db
from sql_requests import get_filters_values, get_movies_by_criteria, get_popular_user_requests
from print_tables import MovieByPages
from user_input import get_user_title, get_user_genre, get_user_year, get_user_actor

def main():
    print("Welcome to program for working with Database \"MOVIES\"!\n"
          "Please input the required option for further work:\n"
          "1. View a list of all movies\n"
          "2. Search for a movie\n"
          "3. Popular queries\n"
          "4. Exit"
          )

    def search_movies():
        """Функция поиска фильма по критериям (с использованием user_input)"""
        title = get_user_title().strip() or None
        genre = get_user_genre().strip() or None
        year = get_user_year().strip() or None
        actor = get_user_actor().strip() or None

        condition_filter, values_filter = get_filters_values(title, genre, year, actor)

        if condition_filter is None:
            print("No search criteria provided.")
            return

        movies = get_movies_by_criteria(values_filter, condition_filter)# Получаем фильмы по фильтрам

        # Создаем объект пагинации для результатов
        pages = MovieByPages(request="", params=[], page_size=10)
        pages.page = 1
        pages.request = movies
        pages.params = values_filter
        pages.print_results()

    while True:
        user_option = ("\nInput your option:").strip()

        if not user_option.isdigit():
            print("Invalid input. Please enter a number (1-4).")
            continue

        user_option = int(user_option)

        if user_option == 1:
            search_movies()

        elif user_option == 2:
            search_movies()

        elif user_option == 3:
            show_popular_queries()

        elif user_option == 4:
            print("Goodbye!")
            break

        else:
            print("Invalid option. Please enter a number (1-4).")

            if condition is None:
                print("No filters provided. Showing default movies list.")
                pages.print_results()
                return

            if not movies:
                print("\nNo movies found matching your criteria.")
                return

        def show_popular_queries():
            """Функция вывода популярных запросов"""
            popular_queries = get_popular_user_requests()

            if not popular_queries:
                print("No popular queries found.")
                return

            print("\nTop 10 popular searches:")
            print(tabulate(popular_queries, headers="keys", tablefmt="fancy_grid"))

        if __name__ == "__main__":
            main()
