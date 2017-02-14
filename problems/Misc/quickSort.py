def q(xs):
    if(xs == []):
        return []
    else:
        p = xs[0]
        return q([x for x in xs[1:] if x < p]) + [p] + q([x for x in xs[1:] if x >= p])

print(q([5,4,3,1,2]))

