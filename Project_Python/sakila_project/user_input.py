# This file contains functions that get user input for the main.py file
def get_user_title():
    """Input a title name from user and return it."""
    while True:
        try:
            title = input('Input film title:')
            if len(title) > 100:
                raise ValueError('Title must be less than 100 characters')
            return title
        except ValueError as e:
            print(f'Invalid title. {e}')
    return title

def get_user_genre():
    """Input a genre name from user and return it."""
    genre_name = input('Input genre name:')
    return genre_name

def get_user_year():
    """Input a release year from user and return it."""
    while True:
        user_year = input('Input film release year:')
        if user_year == '':
            return None
        try:
            year = int(user_year)
            if not (1901 <= year and year <= 2155):
                raise ValueError('Year must be between 1901 and 2155')
            return year
        except ValueError as e:
            if user_year.isdigit():
                print(f'Invalid year. {e}')
            else:
                print(f'Invalid input. Please enter a numeric year.')

def get_user_actor():
    """Input an actor last name from user and return it."""
    actor_last_name = input('Input actor last name:')
    return actor_last_name