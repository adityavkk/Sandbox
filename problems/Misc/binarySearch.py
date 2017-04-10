"""
Binary search to find the elements in a sorted list that are less than a particular
value and greater than a particular value

input: [1, 2, 3, 4, 5, 6, 7, 8], 7.5
output: 6
"""

from math import floor

def bs(xs, y, i, j):
    if i >= j:
        return i
    c = floor(((j - i) + 1) / 2) + i
    x = xs[c]
    if x < y:
        return bs(xs, y, c + 1, j)
    else:
        return bs(xs, y, i, c - 1)

