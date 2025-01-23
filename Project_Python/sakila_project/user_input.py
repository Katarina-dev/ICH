# This file contains functions that get user input for the main.py file
from typing import Optional


def get_user_title() -> Optional[str]:
    """Input a title name from user and return it.

    This function prompts the user for a movie title and performs validation checks.
    The title must be a string of no more than 100 characters and must not contain any digits.

    Returns:
        str: The valid title entered by the user.
    """
    while True:
        try:
            title = input(' - input film title:').strip()
            if title == '':
                return None
            if len(title) > 100:
                raise ValueError('Title must be less than 100 characters')
            if any(char.isdigit() for char in title):
                raise ValueError('The title must not contain numbers.')
            return title
        except ValueError as e:
            print(f'Invalid title. {e}')


def get_user_genre() -> Optional[str]:
    """Input a genre name from user and return it.

    This function prompts the user for a genre name and performs validation checks.
    The genre name must be a string of no more than 32 characters and must not contain any digits.

    Returns:
        str: The valid genre name entered by the user.
    """
    while True:
        try:
            genre = input(' - input genre:').strip()
            if genre == '':
                return None
            if len(genre) > 32:
                raise ValueError('Name of genre must be less than 32 characters')
            if any(char.isdigit() for char in genre):
                raise ValueError('The genre name must not contain numbers.')
            return genre
        except ValueError as e:
                print(f'Invalid name of genre. {e}')

def get_user_year() -> Optional[int]:
    """Input a release year from user and return it.

        This function prompts the user for a film's release year and performs validation checks.
        The year must be a number between 1901 and 2155. If the user does not input a year, None is returned.

        Returns:
            Optional[int]: The valid year entered by the user or None if the input is empty.
    """
    while True:
        user_year = input(' - input film release year:').strip()
        if user_year == '':
            return None
        try:
            year = int(user_year)
            if not (1901 <= year and year <= 2155):
                raise ValueError('Year must be between 1901 and 2155.')
            return year
        except ValueError as e:
            if user_year.isdigit():
                print(f'Invalid year. {e}')
            else:
                print(f'Invalid input. Please enter a numeric year.')

def get_user_actor() -> Optional[str]:
    """Input an actor's last name from user and return it.

    This function prompts the user for an actor's last name and performs validation checks.
    The actor's last name must be a string of no more than 50 characters and must not contain any digits.

    Returns:
        str: The valid actor's last name entered by the user.
    """
    while True:
        try:
            actor_last_name = input(' - input actor last name:').strip()
            if actor_last_name == '':
                return None
            if len(actor_last_name) > 50:
                raise ValueError('Actor last name must be less than 50 characters')
            if any(char.isdigit() for char in actor_last_name):
                raise ValueError('The actor last name must not contain numbers.')
            return actor_last_name
        except ValueError as e:
            print(f'Invalid actor last name. {e}')

