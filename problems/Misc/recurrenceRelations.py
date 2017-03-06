def factorial(x):
    if(x == 0):
        return 1
    else:
        return ([x - 1], lambda xs: xs[0] * x)

def fibonacci(x):
    if (x < 2):
        return x
    else:
        return ([x - 1, x - 2], sum)

def coinchange(a, i):
    if a == 0:
        return 1
    if a < 0 or i == 0:
        return 0
    else:
        return ([(a, i - 1), (a - coinlist[i - 1], i)], sum)
coinlist = [1, 3, 5, 10]

memo = {}

def evalR(f, x):
    fx = f(x)
    if x in memo:
        return memo[x]
    if type(fx) is tuple:
        (ys, g) = fx
        v = g([evalR(f, y) for y in ys])
    else:
        v = fx
    memo[x] = v
    return v

#  def evalR(f, x):
    #  fx = f(*x)
    #  if (f, x) in memo:
        #  return memo[(f, x)]
    #  else:
        #  if(isinstance(fx, int)):
            #  v = fx
        #  else:
            #  (xs, g) = fx
            #  v = g([evalR(f,y) for y in xs])
        #  memo[(f, x)] = v
        #  return v

mem = {}
def fib(n):
    if n in mem:
        return mem[n]
    if n < 2:
        v = n
    else:
        v = fib(n - 1) + fib(n - 2)
    mem[n] = v
    return v

print(fib(100))
#  print(evalR(fibonacci, 10000))
#  print(evalR(coinchange, (500, 4)))
