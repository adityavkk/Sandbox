def f(xs):
    n = len(xs)
    m = len(xs[0])
    eOs = [(0, j) for j in range(m)] + [(n - 1, j) for j in range(m)] + [(i, 0) for i in range(n)] + [(i, m - 1) for i in range(n)]
    def y(x):
        (i, j) = x
        if(xs[i][j] == 'O'):
            def not_edge(x):
                (a, b) = x
                return not (a < 0 | a >= n | b < 0 | b >= m)
            ns = filter(not_edge, [(i, j + 1), (i, j - 1), (i - 1, j), (i + 1, j)])
            xs[i][j] = 'Y'
            map(y, list(ns))
    def change(xs, a, b):
        def mx(row):
            def g(x):
                if(x == a):
                    return b
                else:
                    return x
            return [g(x) for x in row]
        return map(mx, list(xs))
    xs = list(map(y, eOs))
    xs = list(change(list(change(xs, 'O', 'X')), 'Y', 'O'))
    return xs


xs = [['X', 'X', 'X', 'X'], ['X', 'O', 'O', 'X'], ['X', 'X', 'O', 'X'], ['X', 'O', 'X', 'X']]
print(f(xs))
