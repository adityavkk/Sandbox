"""
Given an array of integers, return the highest product possible by multiplying
3 numbers from the array

input: [0, -1, 3, 100, 70, 50]
output: 70 * 50 * 100 = 350000
"""

"""
Pick the 3 largest positive numbers from xs
Pick the 2 largest numbers by abs value

return max(product of positives, product of 2 largest abs and largest positive)
"""
from functools import reduce

def f(xs):
    maxPos = reduce(lambda ss, x: ss if ss[0] > x else sorted([x] + ss[1:]),
                    xs[3:], sorted(xs[0:3]))
    def reducer(ys, x):
        if len(ys) == 0:
            if x < 0:
                return [x]
        if len(ys) == 1:
            if x < 0:
                return [x] + ys
        if x < 0 and x < ys[0]:
            return [x] + ys[1:]
        return ys
    maxNegs = reduce(reducer, xs, [])
    product = lambda xs: reduce(lambda a, b: a * b, xs, 1)
    return max(product(maxPos), product(maxNegs + [maxPos[-1]]))
