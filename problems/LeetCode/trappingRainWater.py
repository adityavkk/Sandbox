# 42: Trapping Rain Water
# Given Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.
# Example: Input: [0,1,0,2,1,0,1,3,2,1,2,1]
# Output: 6

# Approach:
# For each point i, the water above it is the water trapped by the smaller of the max pillar to the left of i and the max pillar to the right of r

from functools import reduce

def push(x, xs):
    xs.append(x)
    return xs
def rev(xs):
    return xs[::-1]

def prefix_max(xs):
    return reduce(lambda maxes, x: push(maxes[-1], maxes) if maxes[-1] > x else push(x, maxes), xs, [-1])[1:]
def postfix_max(xs):
    return rev(reduce(lambda maxes, x: push(maxes[-1], maxes) if maxes[-1] > x else push(x, maxes), rev(xs), [-1]))[:-1]

def f(xs):
    pre_mxs = prefix_max(xs)
    post_mxs = postfix_max(xs)
    return sum([min(pre_mxs[i], post_mxs[i]) - x for (i, x) in enumerate(xs)])

elevations = [0,1,0,2,1,0,1,3,2,1,2,1]
res = f(elevations)
print(res)
