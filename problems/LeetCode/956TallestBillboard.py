from functools import reduce, lru_cache

cons = lambda x, xs: lambda m: x if m == 'car' else xs
car = lambda lst: None if not lst else lst('car')
cdr = lambda lst: None if not lst else lst('cdr')
mklist = lambda xs: reduce(lambda lst, x: cons(x, lst), reversed(xs), None)
display = lambda lst: str(car(lst)) + ' ' + display(cdr(lst)) + ' ' if lst else 'nil'
length = lambda lst, c = 0: length(cdr(lst), c + 1) if lst else c
def foldl(f, z, xs):
    if not car(xs): return z
    return foldl(f, f(z, car(xs)), cdr(xs))
def sum_lst(xs):
    x = car(xs)
    if not x: return 0
    return x + sum_lst(cdr(xs))
def lst_filter(f, xs):
    if not xs: return xs
    x = car(xs)
    if f(x): return cons(x, lst_filter(f, cdr(xs)))
def lessThan(x): lambda y: y < x
def greaterThan(x): lambda y: y >= x

def qSort(xs):
    if not xs: return xs
    x = car(xs)
    l = lst_filter(lessThan(x), cdr(xs))
    g = lst_filter(greaterThan(x), cdr(xs))
    return qSort(l) + [x] + qSort(g)

def toString(xs, ys, zs):
    def f(xs): return foldl(lambda s, x: s + ',' + str(x), '', xs)
    return f(qSort(xs)) + ';' + f(qSort(ys)) + ';' + f(qSort(zs))

# def f(rods):
    # memo = {}
    # def g(rods, xs, ys):
        # key = toString(rods, xs, ys)
        # if key in memo:
            # return memo[key]
        # if not rods:
            # sxs = sum_lst(xs)
            # sys = sum_lst(ys)
            # if (sxs == sys): return sxs
            # else: return 0
        # r = car(rods)
        # left = g(cdr(rods), cons(r, xs), ys)
        # right = g(cdr(rods), xs, cons(r, ys))
        # none = g(cdr(rods), xs, ys)
        # res = max(left, right, none)
        # memo[key] = res
        # return res
#     return g(mklist(rods), None, None)

def toStr(xs, ys, zs):
    makeStr = lambda xs: ','.join(str(e) for e in xs)
    return makeStr(sorted(xs)) + ';' + makeStr(sorted(ys)) + ';' + makeStr(sorted(zs))
def prefix_sum(xs):
    return reduce(lambda ys, x: ys + [ys[-1] + x], xs, [0])[1:]
def postfix_sum(xs):
    xs = xs[::-1]
    return prefix_sum(xs)[::-1]

def f(rods):
    l = len(rods)
    memo = {}
    toStr = lambda a, b: str(a) + ';' + str(b)
    def g(i, counter, max_sum):
        key = toStr(i, counter)
        if key in memo: return memo[key]
        r = 0
        if i == l:
            if counter == 0: r = max_sum
            memo[key] = r
            return r
        x = rods[i]
        p = g(i + 1, counter + x, max_sum + x)
        n = g(i + 1, counter - x, max_sum)
        z = g(i + 1, counter, max_sum)
        r = max(p, n, z)
        if i == l - 1:
            print(i, counter, max_sum, p, n, z)
        memo[key] = r
        return r
    return g(0, 0, 0)

from functools import lru_cache
def sol(rods):
    @lru_cache(None)
    def dp(i, s):
        if i == len(rods):
            return 0 if s == 0 else float('-inf')
        return max(dp(i + 1, s),
                    dp(i + 1, s - rods[i]),
                    dp(i + 1, s + rods[i]) + rods[i])

    return dp(0, 0)
