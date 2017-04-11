"""
Reverse an integer without using any string or char methods
"""

"""
123 -> 321
- x mod 10 -> last digit
- x = floor(x / 10) -> chop off last digit
- if floor(x / 10) = 0 -> No more digits
"""

from math import floor
from functools import reduce

def f(n, ns = []):
    n1 = floor(n / 10)
    n2 = n % 10
    ns.append(n2)
    if n1 == 0:
        return intify(ns)
    return f(n1, ns)

def intify(xs):
    def f(n, t):
        (i, x) = t
        return n + x * (10 ** i)
    xs.reverse()
    return reduce(f, enumerate(xs), 0)
