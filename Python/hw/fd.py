num = int(input('Enter a natural decimal number:'))
a = 0
b = ''

while num != 0:
    a = num % 2
    num = num // 2
    b = str(a) + b
print(b, end="")