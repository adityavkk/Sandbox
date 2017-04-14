"""
Given two list of strings, in which each string contains id, name and department
of employees, and another list of string in which each string specified which
employee is friend with another employee. Output the employee id and all its
friend. So if 1 is friend with 2 and 2 is friend with 9,10. Output should be 1
is friend with 2,9,10.

es = ['1 joe cheese', '2 jim jam', '3 jeff water', '5 jess coffee', '6 jill milk']
fs = ['joe jim', 'jim jess', 'jeff jess']
output : { 1: [1, 2, 5, 3],
           6: [6] }
"""

"""
joe - jim - jess - jeff
jill

finding connected components in G(V = id, E = friendRelationships)

f :: [Employee] -> [Relationship] -> HM Id [Id]
al = makeAl(es, fs)
ids = map (pluck id) es
ccs = defaultdict(list)
seen = set {}
for i in ids:
    if i not in seen:
        ccs[i].append(dfs(i))
for i, fs in ccs.items():
    for f in fs:
        ccs[f] = [i] + [f1 for f1 in fs if f1 is not f]
return dict(ccs)


dfs :: Id -> [Ids]
add id to seen
ns = al[i]
return prepend id to (flat_map dfs ns)

makeAl :: [Emp.] -> [Rel.] -> HM Id [Id]
relIds = map (toId) fs :: [(1, 2)...]
al = defaultdict(list)
for r in relIds:
    (f, t) = r
    append t al[f]
    append f al[t]
return al
"""

from collections import defaultdict
from functools import *

def f(es, rs):
    lup = nIds(es)
    al = makeAl(es, rs, lup)
    ids = [pluckId(e) for e in es]
    ccs = defaultdict(list)
    seen = set()

    def dfs(i):
        seen.add(i)
        ns = list(filter(lambda n: n not in seen, al[i]))
        return [i] + flat_map(dfs, ns)

    for i in ids:
        if i not in seen:
            d = dfs(i)
            ccs[i] = d
    return dict(ccs)

def makeAl(ids, rels, lookup):
    rs = [relIds(r, lookup) for r in rels]
    al = defaultdict(list)
    for r in rs:
        (f, t) = r
        al[f].append(t)
        al[t].append(f)
    return al

def pluckId(e):
    return int(e.split(' ')[0])

def relIds(r, lookup):
    return tuple([lookup[r] for r in r.split(' ')])

def flat_map(f, xs):
    return flatten(map(f, xs))

def flatten(xxs):
    return reduce(lambda fxs, xs: fxs + xs, xxs, [])

def nIds(es):
    ids = [pluckId(e) for e in es]
    names = [pluckName(e) for e in es]
    return dict(zip(names, ids))

def pluckName(e):
    return e.split(' ')[1]

es = ['1 joe cheese', '2 jim jam', '3 jeff water', '5 jess coffee', '6 jill milk', '7 milly water']
fs = ['joe jim', 'jim jess', 'jeff jess', 'milly jill']

print(f(es, fs))
