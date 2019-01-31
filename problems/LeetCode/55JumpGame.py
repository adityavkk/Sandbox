#  Given an array of non-negative integers, you are initially positioned at the first index of the array.
#
#  Each element in the array represents your maximum jump length at that position.
#
#  Determine if you are able to reach the last index.

from functools import lru_cache, reduce

def top_down(xs):
    @lru_cache(maxsize=None)
    def f(i):
        x = xs[i]
        if i > len(xs) - 1: return False
        if i == len(xs) - 1:
            return True
        travel = min(x, len(xs) - i - 1) 
        return any([f(i + y) for y in range(1, travel + 1)])
    return f(0)

def push(x, xs):
    xs.append(x)
    return xs

def bottom_up(xs):
    def f(z, x):
        (i, isFirst, ys) = z
        if isFirst: return (i + 1, False, push(True, ys))
        travel = min(i, x)
        hasTrue = any([ys[k] for k in range(i - 1, i - 1 - travel, -1)])
        return (i + 1, isFirst, push(hasTrue, ys))
    (_, _, rs) = reduce(f, reversed(xs), (0, True, []))
    return rs[-1]
