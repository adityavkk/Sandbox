"""
Given a word w, rearrange the letters of w to construct another word s in such
a way that s is lexicographically greater than w. In case of multiple possible
answers, find the lexicographically smallest one among them.

ab => ba
bb => no answer
hefg => hegf
dhck => dhkc
dkhc => hcdk
"""

"""
Brute Force:
    generate all perms of sorted(s) in lexicographical order
    Binary search to find s, return s' next to s

    lexiPerms :: SortedString -> [String]
    - if len(s) == 1: return [s]
    - if len(s) == 0: return [[]]
    - flatmap (\ c -> map (c:) (lexiPerms (everythingButC in S))) s

    binarySearch :: String -> [String] -> Start -> End -> FoundIndex
    - if start == end : start
    - if start > end : None
    - c = floor(length / 2)
    - x = xs[c]
    - if x == t: return c
    - if x < t:
        binSearch t xs start (c - 1)
    - else : binSearch t xs (c + 1) end

Efficient:
    s = sorted(ss)
    map each char in s to the relative position in s
    find the next largest number with the same digits
    remap digits to chars from lookup table

    5 7 4 1 6 4 3
    5 7 4 1 6 4 3

    f :: [Int] -> [IntsOrderedIntoNextLargestInt]
    - postFixMax
    - find first x in xs from the right that's smaller
    - swap it with the smallest element on the right that's bigger than x
    - make the list on the right of the swap smaller by swapping x with
        largest element to the right of index i

"""
from math import floor, inf
from functools import reduce

def nextLargestInt(n):
    ns = list(map(int, str(n)))
    ms = postFixMax(ns)
    for (i, n) in reversed(list(enumerate(ns))):
        if n < ms[i]:
            return intListToInt(swapAndMakesmaller(i, ns))
    return intListToInt(ns)

def nextLargestString(n):
    ns = list(n)
    ms = postFixMax(ns)
    for (i, n) in reversed(list(enumerate(ns))):
        if n < ms[i]:
            return ''.join(swapAndMakesmaller(i, ns))
    return 'no answer'

def intListToInt(xs):
    return int(''.join(map(str, xs)))

def swapAndMakesmaller(i, xs):
    xs1 = [x for x in xs[i + 1:] if x > xs[i]]
    (j, mx) = min(enumerate(xs1), key = lambda x: x[1])
    xs[j + 1 + i] = xs[i]
    xs[i] = mx
    return xs[:i + 1] + sorted(xs[i + 1:])

def postFixMax(xs):
    xs = reversed(xs)
    def f1(ms, x):
        (ys, mx) = ms
        if mx > x:
            ys.append(mx)
            return (ys, mx)
        else:
            ys.append(x)
            return (ys, x)
    return list(reversed(reduce(f1, xs, ([], ''))[0]))



###################################################################

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

def lexiPerms(ss):
    if len(ss) < 2:
        return [ss]
    def g(x):
        (i, c) = x
        def but(idx, xs):
            return xs[:idx] + xs[idx + 1:]
        return [c + s for s in lexiPerms(but(i, ss))]
    return flat_map(g, enumerate(ss))

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

def f(s):
    ss = ''.join(sorted(s))
    perms = lexiPerms(ss)
    idxOfS = bin_search(s, perms)
    if idxOfS == len(perms) - 1:
        return 'no answer'
    return perms[idxOfS + 1]
