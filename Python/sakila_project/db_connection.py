import pymysql.cursors



def mysql_request_create(sql):
    try:
        connection = pymysql.connect(host='localhost',
                                     port=3306,
                                     user='root',
                                     password='123',
                                     db='sakila',
                                     cursorclass=pymysql.cursors.DictCursor)
        print("Connection successfully")

        with connection.cursor() as cursor:
            # Read all records
            cursor.execute(sql)
            connection.commit()
            result = cursor.fetchall()

    except Exception as ex:
        print("Connection refused")
        print(ex)
        return None

    finally:
        # cursor.close()
        # connection.close()
        if connection and connection.open:
            # print('Connection still open!')
            connection.close()
            print('Connection closed')


def mysql_request_update(request_update, data):
    connection = None
    try:
        connection = pymysql.connect(host='localhost',
                                     port=3306,
                                     user='root',
                                     password='123',
                                     db='sakila',
                                     cursorclass=pymysql.cursors.DictCursor)
        print("Connection successfully")


        with connection.cursor() as cursor:
                # Read all records
            cursor.execute(request_update, data)
            connection.commit()
            result = cursor.fetchall()

    except Exception as ex:
        print("Connection refused")
        print(ex)
        return None

    finally:
        # cursor.close()
        # connection.close()
        if connection and connection.open:
            # print('Connection still open!')
            connection.close()
            print('Connection closed')

def mysql_request_select(request_query_title, params = None):
    connection = None #нужна для обеспечения правильной работы блока finally и предотвращения ошибок при попытке закрытия соединения, если оно не было успешно установлено.
    try:
        connection = pymysql.connect(host='localhost',
                                     port=3306,
                                     user='root',
                                     password='123',
                                     db='sakila',
                                     cursorclass=pymysql.cursors.DictCursor)
        print("Connection successfully")

        with connection.cursor() as cursor:
            cursor.execute(request_query_title, params)
            result = cursor.fetchall()
            return result

    except Exception as ex:
        print("Connection refused")
        print(ex)
        return None

    finally:
        # cursor.close()
        # connection.close()
        if connection and connection.open:
            # print('Connection still open!')
            connection.close()
            print('Connection closed')
    # return result



# sql = "SELECT * FROM gt.special_machinery sm WHERE sm.name LIKE '%тест%';"
# print(mysql_request(sql=sql))