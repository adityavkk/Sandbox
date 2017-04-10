"""
There are N children standing in a line. Each child is assigned a rating value.
- Each child must have at least one candy
- Children with a higher rating get more candies than their neighbord

What is the minimum candies you must give?

input: [1, 2]
output: 3

The kid with 1 gets 1 candy and the candidate with 2 gets 2 => 3
"""

"""
Greedy Heuristic:
    - Give all kids the least amount of candy you can give at each step
    - give the kid with least ranking 1
    - give the kid with second to least ranking 1 unless they're next to least
"""
from itertools import count
from functools import reduce

def f(ks):
    ks1 = sorted(list(zip(ks, count(0))), key = lambda k: k[0])
    def g(cs, k):
        (r, i) = k
        if i > 0 and i < len(ks) - 1:
            if ks[i - 1] < r or ks[i + 1] < r:
                cs[i] = max(cs[i - 1], cs[i + 1]) + 1
            else: cs[i] = 1
        elif i == 0:
            if ks[i + 1] < r:
                cs[i] = cs[i + 1] + 1
            else: cs[i] = 1
        elif i == len(ks) - 1:
            if ks[i - 1] < r:
                cs[i] = cs[i - 1] + 1
            else: cs[i] = 1
        return cs
    cs = reduce(g, ks1, [0] * len(ks))
    return sum(cs)

