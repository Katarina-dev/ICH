from db_connection import  mysql_request_select

def get_query_title():
    title = ('dinosaur')
    # title = ('Input film title:')
    request_query_title = "select * from film where title like %s;"
    result = mysql_request_select(request_query_title, params=(f"%{title}%",))
    if result:
        for row in result:
            print(row)
            print("#" * 30)
    else:
        print('No movies found for your request')

get_query_title()