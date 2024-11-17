# 1. Напишите программу, которая принимает в качестве аргумента командной строки путь к файлу .py и запускает его.
# При запуске файла программа должна выводить сообщение "Файл <имя файла> успешно запущен".
# Если файл не существует или не может быть запущен, программа должна вывести соответствующее сообщение об ошибке.

import sys
import os


def run_file(filename):
    filename = filename.strip()

    args = sys.argv
    if len(args) < 2:
        raise TypeError('Specify the path to the file')

    filepath = sys.argv[1]
    if not os.path.isfile(filepath):
        raise TypeError(f'File {filepath} isn\'t exist')

    if not os.filepath.endwiths('.py'):
        raise ValueError(f'File {filepath} isn\'t Python-script and can\'t be executed')

    try:
        exec(open(filepath).read(), {})
        print(f'File {filepath} was executed successfully')
    except Exception as e:
        print(f'Error at opening file: {e}')
