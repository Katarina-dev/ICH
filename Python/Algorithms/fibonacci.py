#рекурсивно
def fibonacci_recursion(a, b, c, n):
    if b > n:
        return 0
    else:
        c = a + b
        a = b    
        b = c
        print(a)
        return a, fibonacci_recursion(a, b, c, n)


fibonacci_recursion(0, 1, 0, 8)