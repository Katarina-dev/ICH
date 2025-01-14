import db_connect
import requests

def main():
    print("Welcome to program for working with Database \"MOVIES\"!\n"
          "Please input the required option for further work:\n"
          "1. View a list of all movies\n"
          "2. Search for a movie\n"
          "3. Popular queries\n"
          "4. Exit"
          )

    while True:
        user_option = ("\nInput your option:").strip()
        if user_option.isdigit():
            print_all_movies(int(category_id))
        else:
            print("Error: Input correct category ID!")



          "2. Search movie by category\n"
          "3. Search movie by genre\n"
          "4. Search movie by year\n"
          "5. Search for a movie by actor\n"
          "6. Search for a movie using several criteria\n"

          )

    print_all_movies()

    while True:
        category_id = input("\nInput category ID (or 'exit' for finish work): ").strip()
        if category_id.lower() == 'exit':
            break
        if category_id.isdigit():
            print_filter(int(category_id))
        else:
            print("Error: Input correct category ID!")

    title = get_user_title()  # Получаем название фильма от пользователя
    results = get_query_title(title)  # Передаем в get_query_title
    print(results)

if __name__ == '__main__':
    main()