import sql_requests
import user_input
from print_tables import MovieByPages

def main():
    """Main function to run the program for working with the 'MOVIES' database."""
    # Create the user_requests table if it does not exist
    sql_requests.create_table_user_requests()

    # Print the welcome message and options for the user
    print("Welcome to program for working with Database \"MOVIES\"!\n"
          "Please input the required option for further work:\n"
          "1. View a list of all movies\n"
          "2. Search for a movie\n"
          "3. Popular queries\n"
          "4. Exit"
          )

    def get_all_movies():
        """Function to display all movies."""
        condition_filter, user_values = sql_requests.get_filters_values()  #Getting empty filters (all movies)
        query, settings = sql_requests.get_movies_by_criteria(condition_filter, user_values)  # Getting the query and settings based on the filters

        if not query:
            print("No movies found.")
            return

        # Creating a pagination object with the correct SQL query and settings
        pages = MovieByPages(query, settings, page_size=10)
        pages.print_results()




    def search_movies():
        """Функция поиска фильма по критериям (с использованием user_input)"""
        title = user_input.get_user_title() or None
        genre = user_input.get_user_genre() or None
        release_year = user_input.get_user_year() or None
        actor_last_name = user_input.get_user_actor() or None

        # Creates a filter condition (condition_filter) based on user input (for exp: WHERE title = %s) and user_values — list of values that will be substituted for placeholders %s
        condition_filter, user_values = sql_requests.get_filters_values(title, genre, release_year, actor_last_name)  # Получаем пустые фильтры (все фильмы)

        # Forms a complete SQL query (query) and settings necessary to execute the query.
        query, settings = sql_requests.get_movies_by_criteria(condition_filter, user_values)

        '''key_query - Contains the names of the columns that the user fills in
        value_query - Contains placeholders (%s) for inserting values.
        data_query - List of values entered by the user.'''

        key_query, value_query, data_query = sql_requests.transform_user_request(title, genre, release_year, actor_last_name)

        # Write data to the user_queries table
        if key_query:
            sql_requests.update_query_table(title=title, genre=genre, release_year=release_year, actor_last_name=actor_last_name)
        else:
            print("No search criteria provided. Query will not be saved.")

        if condition_filter is None:
            print("No search criteria provided.")
            return

        # Создаем объект пагинации для результатов
        pages = MovieByPages(query, settings, page_size=10)
        pages.page = 1
        pages.params = settings
        pages.print_results()

    def show_popular_queries():
        popular_queries = sql_requests.get_popular_user_requests()

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


if __name__ == "__main__":
    main()
