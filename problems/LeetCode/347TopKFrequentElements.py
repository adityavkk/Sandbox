#  Given a non-empty array  of integers, return the k most frequent elements

#  xs = [1,1,1,2,2,3] k = 2
#  result = [1, 2]

# Approach:
# build a frequency map of the elements in xs - O(n)
# ys = k/vs in frequency map
# find kth smallest index in ys using median of medians - O(m) where m is the # of unique elements in xs
# return all the elements to the left of and including k

# quickSelect: xs -> k -> xk, where xk is the kth smallest element and xs is partitioned in place
# 0. if len xs < 5: sort and return kth smallest
# 1. divide xs into chunks of length 5
# 2. find the median of each of the chunks by brute force (sorting). ms = medians of each chunk
# 3. p = quickSelect on ms to find true median of the medians
# 4. partition xs using p as the pivot
# 5. if p > k: recurse on left to find k
# 5. if p < k: recurse on right to find k - p

from collections import Counter
from functools import reduce
from math import floor

def f(xs, k):
    ys = Counter(xs).items()
    print(list(ys))
    #i = quick_select(ys, k, 0, len(xs) - 1)
    #return ys[: i + 1]

def quick_select(xs, k, s, e):
    print(xs, k, s, e)
    if e < 0: 
    if e - s == 0:
        return xs[0]
    chunks = make_chunks(xs, s, e)
    ms = list(map(brute_force_median, chunks))
    m_of_m = quick_select(ms, floor(len(ms) / 2), 0, len(ms) - 1)
    p = partition(xs, m_of_m, s, e) # in place partition
    if p == k: return m_of_m # or xs[p]
    if p > k: return quick_select(xs, k - 1, s, p - 1)
    else: return quick_select(xs, k - p, p, e)

def brute_force_median(xs):
    xs.sort()
    return xs[floor(len(xs) / 2)]

def make_chunks(xs, s, e):
    def f(ys, x):
        if not ys: return [[x]]
        y = ys[-1]
        if len(y) < 5: y.append(x)
        else: ys.append([x])
        return ys
    return reduce(f, xs[s:e + 1], [])

def swap(xs, i, j):
    x = xs[i]
    xs[i] = xs[j]
    xs[j] = x
    return xs

def find_next_smaller(xs, x, s, e):
    for j in range(s + 1, e + 1):
        y = xs[j]
        if y < x: return j
    return None

def partition(xs, x, s, e):
    p = xs.index(x)
    # throw error if p < s or p > e
    swap(xs, s, p)
    x = xs[0]
    for i in range(s, e + 1):
        y = xs[i]
        if i == 0: continue
        if y < x: swap(xs, i, i - 1)
        else: 
            j = find_next_smaller(xs, x, i, e)
            if not j: return i - 1
            swap(xs, i, j)
            swap(xs, i, i - 1)
    return xs.index(x)


