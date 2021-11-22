def f(n):
    def isPositiveInt(x):
        print(x)
        return x > 0 and isinstance(x, int)
    def go(j, count = 0):
        if (j == n):
            return count
        if (isPositiveInt(n - (j + 1) / 2)):
            return go(j + 1, count + 1)
        return go(j + 1, count)
    return go(n, 0)

