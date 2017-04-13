from functools import reduce
from math import floor

def lineToIntList(s):
    return [int(x) for x in s.split(' ')]

def flat_map(f, xs):
    """ Single level flatmap
    flat_map :: (a -> [b]) -> [a] -> [b]
    """
    return flatten([f(x) for x in xs])

def flatten(xxs):
    """ A single lever flattener
    flatten :: [[a]] -> [a]
    """
    return reduce(lambda ys, xs: ys + xs, xxs, [])

def bin_search(x, xs):
    def f(t, xs, i, j):
        c = floor((j - i + 1) / 2) + i
        x = xs[c]
        if x == t:
            return c
        if i >= j:
            return False
        if x > t:
            return f(t, xs, i, c - 1)
        return f(t, xs, c + 1, j)
    return f(x, xs, 0, len(xs) - 1)
