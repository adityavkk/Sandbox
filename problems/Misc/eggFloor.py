def memoize2(f):
    memo = {}
    def g(a, b):
        key = str(a) + ';' + str(b)
        if key not in memo:
            memo[key] = f(a, b)
        return memo[key]
    return g

@memoize2
def f (n, k):
    if n == 0:
        return 0
    if k == 1:
        return n
    return min((1 + max(f(i - 1, k - 1), f(n - i, k))) for i in range(1, n + 1))
