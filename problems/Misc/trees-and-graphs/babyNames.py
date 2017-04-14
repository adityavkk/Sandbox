"""
Names: "John(15), Jon(12), Chris(13), Kris(4), Christopher(19)"
Synonyms: [("John", "Jon"), ("John", "Johnny"), ("Chris", "Kris"), ("Chris", "Christopher")]
Output: "John(27), Kris(36)"
"""

"""
John -> Jon
John -> Johnny
Chris -> Christopher
Chris -> Kris

John -> Jon -> Johnny

Construct a G(V = (Name, Count), E = Synonyms)
Finding the connected components of G
Return head vertex of each connected component C, and add the count of each v in C

f :: Map Name Count -> Synonyms -> Map Name Count
- ns = names nameCounts
- al = makeAl(ns, ss)
- seen = set {}
- newNs = {}
- for n in ns:
    if n not in seen:
       newNs[n] = dfs(n)
- return newNs

dfs (mutates seen) :: Name -> TotalCountInclStart
- add n to seen
- synsNotSeen = filter (not in seen) al[n]
- return sum(map dfs synsNotSeen) + count(n)

makeAl :: [Name] -> Syns -> Map Name [Name]
- al = {}
- for s in ss:
    (f, t) = s
    append t onto al[f]
    append f onto al[t] <- undirected graph
- return al
"""
from collections import defaultdict
from functools import *

def f(ncs, ss):
    global gncs, al, seen
    gncs = ncs
    ns = list(ncs.keys())
    al = makeAl(ns, ss)
    seen = set()
    newNs = defaultdict(int)
    for n in ns:
        if n not in seen:
            newNs[n] = dfs(al, seen, n)
    return dict(newNs)

def makeAl(ns, ss):
    al = defaultdict(list)
    for s in ss:
        (f, t) = s
        al[f].append(t)
        al[t].append(f)
    for n in ns:
        if n[0] not in al:
            al[n[0]] = []
    return al

def dfs(al, seen, n):
    seen.add(n)
    syns = filter(lambda x: x not in seen, al[n])
    dfs1 = partial(dfs, al, seen)
    return sum(map(dfs1, syns)) + gncs[n]

ncs = { "John" : 15,
        "Jon" : 12,
         "Chris" : 13,
         "Kris" : 4,
         "Christopher" : 19,
       "Johnny": 0
      }
ss = [("John", "Jon"), ("John", "Johnny"), ("Chris", "Kris"), ("Chris", "Christopher")]

print(f(ncs, ss))
