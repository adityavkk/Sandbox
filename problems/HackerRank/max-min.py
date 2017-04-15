"""
Given a list of N intergers and a k, your task is to select any k integers from n
such that its unfairness is minimized and return the minimal unfairness.

The unfairness is given by:
    max(x1, x2, ..., xk) - min(x1, x2, ..., xk)
"""

"""
sort ns to cluster closest elements together and make it easier to calculate
sliding window max and min (max is the new element and min is the last element)

f :: [Int] -> WindowSize -> Int
- sort ns
- minUnfairness = unfair(ns[:k])
- lastUnfairness = unfair(ns[n - k:])
- for i in range(k, n - k):
    unfairness = ns[i] - ns[i - k]
    if unfairness < minUnfairness:
        minUnfairness = unfairness
    return unfairness
"""

from functools import reduce

def f(ns, k):
    """
    >>> f([10, 100, 300, 200, 1000, 20, 30], 3)
    20
    >>> f([10, 20, 30, 100, 101, 102], 3)
    2
    """
    ns = list(enumerate(sorted(ns)))
    n = len(ns)
    min_u = unfair(ns[:k])
    nns = ns[k:]
    def g(mu, n):
        (i, n) = n
        unfairness = n - ns[i - k + 1][1]
        #  print(i, n, unfairness)
        if unfairness < mu:
            return unfairness
        return mu
    return reduce(g, nns, min_u)

def unfair(ns):
    return max([n[1] for n in ns]) - min([n[1] for n in ns])

if __name__ == '__main__':
    import doctest
    doctest.testmod()
