from functools import reduce

def f(xs):
    mx = max(xs)
    def g(t, x):
        [ gm, msf ] = t
        return [ max(gm, msf), max(x, msf + x) ]
    return reduce(g, xs[1:], [ mx, xs[0] ])

def g(xs):
    gm = max(xs)
    msf = xs[0]
    for x in xs[1:]:
        if(msf > gm):
            gm = msf
        msf1 = msf + x
        if(msf1 > 0):
            msf = msf1
        else:
            msf = x
    return gm

print(f([2, -8, 3, -2, 4, -10]))
print(g([2, -8, 3, -2, 4, -10]))
