from functools import reduce

cons = lambda x, xs: lambda m: x if m == 'car' else xs
car = lambda lst: lst('car')
cdr = lambda lst: lst('cdr')
mklist = lambda *xs: reduce(lambda lst, x: cons(x, lst), reversed(xs), None)
display = lambda lst: str(car(lst)) + ' ' + display(cdr(lst)) + ' ' if lst else 'nil'
length = lambda lst, c = 0: length(cdr(lst), c + 1) if lst else c
