"""
Given a singly linked list, select k random nodes from the list uniformly at random

Or a stream of values that is too large to fit in memory at once, select
k random nodes from the list uniformly at random
"""

"""
Resevoir Sampling:
- Keep first k items in memory
- Sample the stream/list for the next item starting at (k + 1)
- With probability 1/i keep the ith item in the stream/list (discard the old one)
- with probability 1 - 1/i, keep the old item (ignore the new one)

1. Keep first k items in an array
2. Keep sampling from list/stream:
    - Generate random number from 0 to i where i is the index of current item
    - if generated random number, j, is in range 0 to k - 1, replace resevoir[j] with it
"""

from random import randint
from itertools import islice

def f(xs, k, rs = None, i = None):
    if rs is None:
        rs = list(islice(xs, k))
    if i is None:
        i = k + 1
    try:
        x = next(xs)
    except StopIteration:
        return rs
    rand = randint(0, i)
    if rand >= 0 and rand <= k - 1:
        rs[rand] = x
    return f(xs, k, rs, i + 1)
