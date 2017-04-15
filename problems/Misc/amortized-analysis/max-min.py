"""
Given a list of N integers and k, your task is to select k contiguous integers
from the list such that its unfairness is minimized and return the minimum unfairness.

If (x1, x2, x3, ..., xk) are K numbers selected from the list N, the unfairness
is defined as:
    max(x1, x2, ..., xk) - min(x1, x2, ..., xk)
Note: Integers in the list N may not be unique.
"""

"""
calculate min and max of every range in ns of size k
O(n)
"""
from functools import reduce

class SlidingWindowChain:

    """augmented list with insert and delete that maintains a sorted and max size invariant"""

    def __init__(self, window_size, first_window, maxChain = False):
        self.maxChain = maxChain
        def g(xs, x):
            if not len(xs):
                return [x]
            last = xs[-1][1]
            if (self.maxChain and x[1] > last) or (not self.maxChain and x[1] < last):
                xs.append(x)
            return xs
        self.data = reduce(g, reversed(first_window), [])
        self.last_index = None
        self.window_size = window_size

    def insert(self, x, i):
        if i - self.window_size == self.last_index:
            if len(self.data):
                self.data.pop()
        self.data = [y for y in self.data if y[1] > x] if self.maxChain \
                    else [y for y in self.data if y[1] < x]
        self.data.insert(0, (i, x))
        self.last_index = self.data[-1][0]
        return self

    def get(self):
        return self.data[-1][1] if len(self.data) else None

def f(ns, k):
    """
    >>> f([1, 2, 3, 4, 10, 20, 30, 40, 100, 200], 4)
    3
    >>> f(ns1, k1)
    290
    """
    first_window = list(enumerate(ns[:k]))
    full_length = len(ns)
    min_sw = SlidingWindowChain(k, first_window)
    max_sw = SlidingWindowChain(k, first_window, True)
    ns = ns[k:]
    def g(sw_mins, ni):
        (sw, mins) = sw_mins
        (i, n) = ni
        if i >= full_length - k:
            return (sw, mins)
        sw.insert(n, i + k)
        mins.append(sw.get())
        return (sw, mins)
    mins = reduce(g, enumerate(ns), (min_sw, [min_sw.get()]))[1]
    maxes = reduce(g, enumerate(ns), (max_sw, [max_sw.get()]))[1]
    return min([maxes[i] - mins[i] for i in range(0, len(mins))])

ns1 = [10, 100, 300, 200, 1000, 20, 30]
k1 = 3

if __name__ == "__main__":
    import doctest
    doctest.testmod()
