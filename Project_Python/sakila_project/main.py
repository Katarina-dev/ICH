import db


def main():
    print("Welcome to program for working with DB!")
    print_categories()

    while True:
        category_id = input("\nInput category ID (or 'exit' for finish work): ").strip()
        if category_id.lower() == 'exit':
            break
        if category_id.isdigit():
            print_filter(int(category_id))
        else:
            print("Error: Input correct category ID!")

if __name__ == '__main__':
    main()