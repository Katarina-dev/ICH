# num1, num2, num3 = map(int, input('Input three numbers: ').split())
# sum = num1 + num2 + num3
# print(sum)

# ALGORITHM Find sum of three numbers
#
# START
# WRITE: 'Input three numbers:'
# READ: num1 num2 num3
# WRITE: sum = num1 + num2 + num3
# END

a = [1, 2, 3]
b = [4, 5, 6]

sum = [i + j for i, j in zip(a, b)]
print(sum)
