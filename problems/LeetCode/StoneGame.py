from functools import lru_cache

def memo_2_3(f):
    memo = {}
    def helper(const, x, y):
        if '{0};{1}'.format(x, y) not in memo:
            memo[x] = f(const, x, y)
        return memo[x]
    return helper


@memo_2_3
def lee(stones, start, end):
    if (start > end):
        return 0
    left_stone = stones[start]
    right_stone = stones[end]
    take_left = - left_stone + alex(stones, start + 1, end)
    take_right = - right_stone + alex(stones, start, end - 1)
    return max(take_left, take_right)

@memo_2_3
def alex(stones, start, end):
    if (start > end):
        return 0
    left_stone = stones[start]
    right_stone = stones[end]
    take_left = left_stone + lee(stones, start + 1, end)
    take_right = right_stone + lee(stones, start, end - 1)
    return max(take_left, take_right)

def does_alex_win(stones):
    total = sum(stones)
    max_alex_score = alex(stones, 0, len(stones) - 1)
    return max_alex_score > 0
