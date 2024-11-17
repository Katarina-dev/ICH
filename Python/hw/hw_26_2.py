# 2. Напишите программу, которая принимает в качестве аргумента командной строки путь к директории и выводит список всех файлов и поддиректорий внутри этой директории.
# Для этой задачи используйте модуль os и его функцию walk. Программа должна выводить полный путь к каждому файлу и директории.

import os
import sys
#
def get_path(directory):

    if not os.path.isdir(directory):
          raise TypeError('Path to directory is incorrect')

    print(f'Current directory {directory}')

    for root, dirs, files in os.walk(directory):
        print(f"Current directory: {root}")

        if dirs:
            print("Sub-category:")
            for d in dirs:
                print(f"  {os.path.join(root, d)}")
        else:
            print("  Sub-categories are missing.")

        # Выводим файлы
        if files:
            print("Files:")
            for f in files:
                print(f"  {os.path.join(root, f)}")
        else:
            print("  Files are missing.")
        print("-" * 40)

def main():
    if len(sys.argv) < 2:
        print("Specify path to the directory")
        return

    directory = sys.argv[1]
    get_path(directory)

if __name__ == "__main__":
    main()
