def f(cs, es={}):
    if (len(cs) == 0):
        return es
    cs = atom(cs, es)
    (ncs, nes) = block(cs, es)
    return f(ncs, nes)

def atom(cs, es):
    (name, qty, cs) = parse_atom(cs)
    if(name):
        if(name in es):
            es[name] += qty
        else:
            es[name] = qty
    return cs

def parse_atom(cs):
    a = cs[0]
    b = cs[1]
    if(a.isupper()):
        if(b.islower()):
            return (a+b, int(cs[2]), cs[3:])
        elif(b.isnumeric()):
            return (a, int(b), cs[2:])
        return (a, 1, cs[1:])
    return (False, 2, cs)

def block(cs, es):
    if(len(cs) == 0):
        return (cs, es)
    a = cs[0]
    if(a == '('):
        (cs1, n, rest) = inside_block(cs[1:])
        return (rest, merge(es, scale(f(cs1, {}), n)))
    else:
        return (cs, es)

def merge(a, b):
    r = {}
    for k in a:
        if(k in b):
            r[k] = a[k] + b[k]
        else:
            r[k] = a[k]
    for k in b:
        if(k not in a):
            r[k] = b[k]
    return r

def inside_block(cs):
    c_index = mismatched(cs, 0, 0)
    return (cs[:c_index], int(cs[c_index + 1]), cs[c_index + 2:])

def scale(dic, n):
    r = {}
    for k in dic:
        r[k] = dic[k] * n
    return r

def mismatched(cs, count, i):
    a = cs[i]
    if(count < 0):
        return i - 1
    if(a == '('):
        return mismatched(cs, count+1, i+1)
    if(a == ')'):
        return mismatched(cs, count-1, i+1)
    else:
        return mismatched(cs, count, i+1)

print(f("H3(H2(O2)4)2"))
