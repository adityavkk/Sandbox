from functools import reduce

''' Simple tree implementation '''
class Node(object):
    def __init__(self, v, cs = []):
        self.v = v
        self.cs = cs

    def insert(self, v):
        n = Node(v, [])
        self.cs.append(n)
        return self

def from_list_to_tree(xs, n):
    return reduce(lambda tr, x: tr.insert(x), xs, n)

t = from_list_to_tree([1,2,3], Node(0))
from_list_to_tree([4,5,6], t.cs[0])
from_list_to_tree([7,8,9], t.cs[2])

''' Recursive BFS '''

def foldr(f, z, xs):
    return z if not xs else f(xs[0], foldr(f, z, xs[1:]))

# flat_map :: (a -> [b]) -> [a] -> [b]
def flat_map (f, xs):
    def flatten(ys):
        return foldr(lambda y, zs: y + zs, [], ys)
    return flatten(list(map(f, xs)))

# bfs :: Node a -> [a]
def bfs(n):
    # __bfs :: [Node a] -> [a]
    def __bfs(ns):
        if(not ns):
            return []
        return [n.v for n in ns] + __bfs(flat_map(lambda x: x.cs, ns))
    return __bfs([n])
