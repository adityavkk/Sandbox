"""
You are given an adjacency matrix M representing an undirected graph
where M[i][j] = 1 if vertex i is connected to vertex j and 0 if they aren't
connected. Determine the number of connected components

M[i][i] = 1
M[i][j] = M[j][i] since it's an undirected graph
"""

"""
increment counter of connected components every time a new dfs is started
on a vertex that hasn't already been seen

f :: AdjMatrix -> Int
- vs = [0..length m - 1]
- seen = set {}
- reduce over vs starting from counter = 0:
    if v not in seen:
        connectedComps++
        seen = dfs(M, v, seen) -> adds all v' explored from v to seen

dfs :: Matrix -> Vertex -> SeenSet -> SeenSet
- add v to seen
- ns = w in M[v] if not already in seen
- map dfs ns
- return seen
"""
from functools import *

def f(x):
    m = parse(x)
    vs = range(0, len(m))
    seen = set()
    def g(s, c, v):
        if v not in s:
            c += 1
            s = dfs(m, v, s)
        return c
    h = partial(g, seen)

    return reduce(h, vs, 0)

def dfs(m, v, s):
    s.add(v)
    ns = [i for (i, w) in enumerate(m[v]) if i not in s and w == 1]
    return reduce(lambda seen, n: dfs(m, n, seen), ns, s)

def parse(x):
    xs = x.split('\n')[1:]
    return [list(map(int, y)) for y in xs]

m1 = '4\n1101\n1110\n0110\n1001'
m2 = '5\n10000\n01000\n00100\n00010\n00001'
