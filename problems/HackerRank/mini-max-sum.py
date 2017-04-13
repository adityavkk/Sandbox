"""
Given five positive integers, find the minimum and maximum values that can be
calculated by summing exactly four of the five integers. Then print the
respective minimum and maximum values as a single line of two space-separated
long integers.
"""

"""
f :: [Int] -> (Min, Max)
sumExcept = map each x to the sum of everything except itself
min = min of sumExcept
max = max of sumExcept

"""

def f(xs):
    tot = sum(xs)
    sumExcept = [tot - x for x in xs]
    return '{0} {1}'.format(min(sumExcept), max(sumExcept))
