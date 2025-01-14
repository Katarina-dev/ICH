from db_connection import  mysql_request_update

def update_query_table():
    req = input('Input genre: ') # убрать инпуты из функции
    req2 = int(input('Input year: '))
    req3 = input('Input name: ')
    data = req, req2, req3
    request_update = "INSERT INTO `queries_genre_year` (category, year, name) VALUES (%s, %s, %s)"
    mysql_request_update(request_update, data)
    print("Table was updated successfully")
    print(data)

update_query_table()