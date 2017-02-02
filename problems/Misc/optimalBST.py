def sumR(xs, i, j):
    tot = 0
    for k in range(i, j + 1):
        tot += xs[k]
    return tot

def f(ks, ws):
    memo = [[None for i in range(len(ks))] for i in range(len(ks))]
    def e(i, j):
        if(i >= len(ks)):
            return 0
        if(memo[i][j] != None):
            return memo[i][j]
        v = 0
        if(i == j):
            v = ws[i]
        elif(j < i):
            v = 0
        else:
            v = min([r(x, i, j) for x in range(i, j + 1)])
        memo[i][j] = v
        return v
    def r(x, i, j):
        return e(i, x - 1) + e(x + 1, j) + sumR(ws, i, j)
    return e(0, len(ks) - 1)

print(f([1, 2, 3, 4], [1, 10, 8, 9]))
