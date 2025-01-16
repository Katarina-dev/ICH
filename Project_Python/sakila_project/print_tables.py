import pymysql
from tabulate import tabulate

from Project_Python.sakila_project.sql_requests import get_movies_by_criteria, user_values
from db_connect import db

class MovieByPages:
    def __init__(self, request, params=None, page_size=10, condition_filter=None):
        """Инициализация с базовыми параметрами для пагинации"""
        self.request = request  # SQL-запрос
        self.params = params or []  # Параметры запроса
        self.page_size = page_size  # Размер страницы
        self.page = 1  # Начальная страница

    def get_data_by_pages(self):
        """Возвращает данные с пагинацией (LIMIT и OFFSET)"""
        offset = (self.page - 1) * self.page_size  # Смещение для пагинации
        page_request = self.request + " LIMIT %s OFFSET %s" # Добавляем LIMIT и OFFSET

        # Добавляем параметры запроса и параметры пагинации
        request_params = self.params + [self.page_size, offset]

        try:
            return db.mysql_request_select(page_request, request_params)
        except pymysql.Error as er:
            print(f'Database error: {er.errno} : {er.msg}')
            return []

    def print_results(self):
        """Выводит данные с пагинацией через tabulate."""
        while True:
            result_table = self.get_data_by_pages()

            if not result_table:
                print("\nNo more results found.")
                break

            # Преобразуем результат в формат для вывода
            table_data = [list(row.values()) for row in result_table]
            headers = list(result_table[0].keys())

            # Выводим таблицу
            print(f"\nPage {self.page}:\n{'*' * 40}")
            print(tabulate(table_data, headers=headers, tablefmt="grid",
                           maxcolwidths=[10, 30, 40, 40, 40, 40, 40, 40, 40, 40]))
            print("*" * 40)

            # Запрос на переход к следующей странице
            if input("Press Enter to view next page or type 'q' to quit: ").lower() == 'q':
                break
            self.page += 1
