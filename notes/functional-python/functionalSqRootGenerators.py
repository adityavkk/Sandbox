"""
functional square root with generators using Newton-Raphson algorithm for locating
roots of a function.
"""

def next_(n, x):
    return (x + n/x) / 2

def repeat(f, a):
    yield a
    for v in repeat(f, f(a)):
        yield v

def within(e, iterable):

    def head_tail(e, a, iterable):
        b = next(iterable)
        if abs(a - b) <= e:
            return b
        return head_tail(e, b, iterable)

    return head_tail(e, next(iterable), iterable)

def sqrt(a0, e, n):
    return within(e, repeat(lambda x: next_(n, x), a0))
