n, m = map(int, input().split())

while n <= m:
    while n % 2:
        print(n, end= ' ')
        n = n + 1
    n = n + 1


