"""
Given a set, S, of n distinct integers print the size of a maximal subset, S',
of S where the sum of any 2 numbers in S' is not evenly divisible by k

n = 4, k = 3
ns = 1 7 2 4 => nsModk = 1 1 2 1

k = 4
1 7 2 4 6 9 10 => nsModk = 1 3 2 0 2 1 2 => 0: 1, 1: 2, 2: 3, 3:1
output: 3, namely the subset [1, 7, 4]
"""

"""
f :: [Int] -> Int
The each element in and out method:
    if xs is size 1 or less: return size
    x = xs[0]
    return max(f xs[1:], f [x' for x' in xs[1:] s.t. x' + x % k != 0] + 1)

    T (n) = 2T (n - 1) + O(n)

0 1 2 3 4 5 6

g :: [Int] -> Int
xs => xsModK
freq = freq count of xsModK
count = 0
for i in range(0, k / 2):
    if i == k / 2 (k is even) or i == 0: count++
    else: count += max(frq[i], freq[k - i])


"""
from functools import lru_cache, reduce
from collections import defaultdict
from math import floor

@lru_cache(maxsize = None)
def f(xs, k):
    xs = tuple(xs)
    if len(xs) < 2:
        return len(xs)
    x = xs[0]
    xs = xs[1:]
    return max(f(xs, k), f(( x1 for x1 in xs if (x1 + x) % k != 0 ), k) + 1)

def g(xs, k):
    xsModK = [x % k for x in xs]
    def f1(h, x):
        h[x] += 1
        return h
    freq = reduce(f1, xsModK, defaultdict(int))
    count = 0
    half = floor(k / 2)
    even = k % 2 == 0
    for i in range(0, half + 1):
        if (i == half and even) or i == 0:
            if freq[i] > 0:
                count += 1
        else:
            count += max(freq[i], freq[k - i])
    return count

