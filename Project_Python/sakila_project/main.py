import sql_requests
import user_input
from print_tables import MovieByPages
from db_connect import db


def get_all_movies() -> None:
    """
        Function to display all movies.

        This function retrieves all movies from the database by getting empty filters,
        constructing the SQL query and settings, and then creating a pagination object
        to display the results.
    """
    condition_filter, user_values = sql_requests.get_filters_values()  #Getting empty filters (all movies)
    query, settings = sql_requests.get_movies_by_criteria(condition_filter, user_values)  # Getting the query and settings based on the filters

    # Creating a pagination object with the correct SQL query and settings
    pages = MovieByPages(query, settings, page_size=10)
    pages.print_results()

def prepare_filters() -> tuple:
    """
        Prepare filters for searching movies based on user input.

        This function collects user input for movie title, genre, release year, and actor's last name.
        It then generates SQL query filters and values, as well as keys, placeholders, and values for saving the query history.

        Returns:
            tuple: A tuple containing the condition filter, user values, key query, title, genre, release year, and actor's last name.
        """
    title = user_input.get_user_title() or None
    genre = user_input.get_user_genre() or None
    release_year = user_input.get_user_year() or None
    actor_last_name = user_input.get_user_actor() or None

    # Checking if there is at least one criterion
    if not any([title, genre, release_year, actor_last_name]):
        return None, None, None

    # Generating filters and values for an SQL query
    condition_filter, user_values = sql_requests.get_filters_values(title, genre, release_year, actor_last_name)

    # Generating keys, placeholders and values for saving in the query history
    key_query, value_query, data_query = sql_requests.transform_user_request(title, genre, release_year, actor_last_name)

    return condition_filter, user_values, key_query, title, genre, release_year, actor_last_name

def search_movies():
    """
        Function to search for movies based on user input.

        This function prepares filters for searching movies based on user input,
        generates an SQL query, and then creates a pagination object to display the results.
        If at least one criterion is specified, the query is saved to the history
    """
    try:
        # Prepare filters based on user input
        filter_result = prepare_filters()

        # If no filters are specified, exit
        if not filter_result[0]:
            print("No search criteria provided. Query will not be saved.")
            return

        # Unpack the result prepare_filters
        condition_filter, user_values, key_query, title, genre, release_year, actor_last_name = filter_result

        # Save the request to history if at least one criterion is specified
        if key_query:
            sql_requests.update_query_table(
                title=title,
                genre=genre,
                release_year=release_year,
                actor_last_name=actor_last_name
            )

        # Generate an SQL query based on filters
        query, settings = sql_requests.get_movies_by_criteria(condition_filter, user_values)

        # Create a pagination object with the correct SQL query and settings
        pages = MovieByPages(query, settings, page_size=10)
        pages.page = 1
        pages.params = settings
        pages.print_results()
    except RuntimeError as ex:
        print(f"An error occurred: {ex}")

def show_popular_queries():
    """
        Function to display popular queries.

        This function retrieves popular queries from the database and creates a pagination object to display the results.
    """
    popular_queries = sql_requests.get_popular_user_requests()

    if not popular_queries:
        print("No popular queries found.")
        return

    # Create an instance of MovieByPages and call print_results
    pages = MovieByPages(popular_queries, page_size=10)

    # Print the results using the pagination object
    pages.print_results()

def main():
    """
        Main function to interact with the user and perform database operations.

        This function creates the `user_requests` table if it does not exist, displays a welcome message,
        and provides options for the user to view all movies, search for a movie, view popular queries, or exit.
    """
    # Create the user_requests table if it does not exist
    sql_requests.create_table_user_requests()

    # Print the welcome message and options for the user
    print("Welcome to program for working with Database \"SAKILA\"!\n")

    while True:
        user_option = input("\nPlease input the required option for further work:\n"
          "1. View a list of all movies\n"
          "2. Search for a movie\n"
          "3. Popular queries\n"
          "4. Exit\n"
          "\nInput your option:").strip()

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
