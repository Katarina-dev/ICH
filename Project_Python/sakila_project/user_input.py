# This file contains functions that get user input for the main.py file
from typing import Optional


def get_user_title() -> str:
    """Input a title name from user and return it."""
    while True:
        try:
            title = input('Input film title:').strip()
            if len(title) > 100:
                raise ValueError('Title must be less than 100 characters')
            if any(char.isdigit() for char in title):
                raise ValueError('The title must not contain numbers.')
            return title
        except ValueError as e:
            print(f'Invalid title. {e}')
    return title

def get_user_genre() -> str:
    """Input a genre name from user and return it."""
    while True:
        try:
            genre = input('Input genre:').strip()
            if len(genre) > 32:
                raise ValueError('Name of genre must be less than 32 characters')
            if any(char.isdigit() for char in genre):
                raise ValueError('The genre name must not contain numbers.')
            return genre
        except ValueError as e:
                print(f'Invalid name of genre. {e}')

def get_user_year() -> Optional[int]:
    """Input a release year from user and return it."""
    while True:
        user_year = input('Input film release year:').strip()
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

def get_user_actor() -> str:
    """Input an actor last name from user and return it."""
    while True:
        try:
            actor_last_name = input('Input actor last name:').strip()
            if len(actor_last_name) > 50:
                raise ValueError('actor last name must be less than 50 characters')
            if any(char.isdigit() for char in actor_last_name):
                raise ValueError('The actor last name must not contain numbers.')
            return actor_last_name
        except ValueError as e:
            print(f'Invalid actor last name. {e}')
    return actor_last_name
