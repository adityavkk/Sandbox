"""
You are given an NxN chess board and a list of positions with queens on them.
You are also given a list of positions you're considering placing your king to
make a move. Determine whether each position in your positions for king is safe
or not.

Once placed, you can move the king to capture all the queens that are
immediately adjacent to king placed

The problem size can get fairly large in size of chess board, number of queens
and positions.
"""

"""
Approach:
    Count total number of queens in each row i, col j, and diag j
    map g ks

    diag :: ChessBoard -> QueenPosition -> DiagonalNum
    diag:
        y = mx + b
        b is the diagonal number

    g :: ChessBoard -> QinRows -> QinCols -> QinDs -> KingPosition -> Bool
    g:
      count num of kings in adjacent positions in row, col, and diag
      if adjR < k in row i and
         adjC < k in col j and
         adjD < k in diag k return true
      else return false
"""
from functools import *

#  TODO:  <08-04-17, Aditya> # There 2 diagonals that queens take one with a positive slope and one with a negative slope
#                              This algorithm only accounts for the positive slope diagonal

# f :: Board -> Queens -> Kings -> [Bool]
def f(n, qs, ks):
    rs = rows(n, qs)
    cs = cols(n, qs)
    ds = diags(n, qs)
    return [g(qs, rs, cs, ds, k) for k in ks]

def g(qs, rs, cs, ds, k):
    diagonal = yInter(k)
    (column, row) = k
    def reducer(hm, q):
        (x, y) = q
        if x not in hm:
            hm[x] = set()
        hm[x].add(y)
        return hm
    b = reduce(reducer, qs, {})
    def count(b, c, r):
        return 1 if r in b and c in b[r] else 0
    ar = count(b, column, row - 1) + count(b, column, row + 1)
    ac = count(b, column - 1, row) + count(b, column + 1, row)
    ad = count(b, column - 1, row - 1) + count(b, column + 1, row + 1) + \
         count(b, column - 1, row + 1) + count(b, column + 1, row - 1)
    print(b)
    print(ar, rs[row], 'col', ac, cs[column], 'diag', ad, ds[diagonal])
    return ar < rs[row] or ac < cs[column] or ad < ds[diagonal]

def freq(func, rs, x):
    x1 = func(x)
    if x1 in rs:
        rs[x1] += 1
    else:
        rs[x1] = 1
    return rs

def rows(n, qs):
    reducer = partial(freq, lambda x: x[1])
    return fill(n, reduce(reducer, qs, {}))

def cols(n, qs):
    reducer = partial(freq, lambda x: x[0])
    return fill(n, reduce(reducer, qs, {}))

def diags(n, qs):
    reducer = partial(freq, yInter)
    return fill(n, reduce(reducer, qs, {}), True)

def fill(n, hm, d = False):
    def reducer(acc, v):
        if v not in acc:
            acc[v] = 0
        return acc
    if not d:
        return reduce(reducer, range(0, n), hm)
    else:
        return reduce(reducer, range(- (n - 1), n), hm)

def yInter(p):
    (x, y) = p
    return y - x

b = [[]]
