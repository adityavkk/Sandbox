from functools import lru_cache

stones = [5, 4, 2, 7, 1]

@lru_cache(None)
def rest(i, j):
    if (i > j): return 0
    return sum(stones[i:j+1])

@lru_cache(None)
def alex(start, end):
    if (start > end):
        return 0
    l = stones[start]
    r = stones[end]
    rest_l = rest(start + 1, end)
    rest_r = rest(start, end - 1)
    try_left = l - lee(start + 1, end) + rest_l
    try_right = r - lee(start, end - 1) + rest_r
    print(start, end, try_left, try_right, rest_l, rest_r)
    return max(try_left, try_right)

lee = alex

