/* Utility functions */

function log(x) {
  console.log(x)
  return x
}

function foldR(f, z, xs) {
  if (xs.length === 0) return z
  return f(xs[0], foldR(f, z, xs.slice(1)))
}

function foldL(f, z, xs) {
  if (xs.length === 0) return z
  return foldL(f, f(z, xs[0]), xs.slice(1))
}

/* purely function, lisp style implementation of cons and lists with delete */

function cons(h, t) {
  return (a) => {
    if (a === 'car') return h
    if (a === 'cdr') return t
  }
}

function car(ll) {
  return ll('car')
}

function cdr(ll) {
  return ll('cdr')
}

function cadr(ll) {
  return car(cdr(ll))
}

function uncons(n, ll) {
  if (ll === null) return null
  if (car(ll) === n) return cdr(ll)
  return cons(car(ll), uncons(n, cdr(ll)))
}

function list(...xs) {
  return foldR(cons, null, xs)
}

// printList :: [a] -> String
function printList(ll) {
  if (ll === null) return 'null'
  return car(ll) + ' ' + printList(cdr(ll))
}

/* Queue */

class Q {
  constructor() {
    this.q = []
  }

  enQ(...x) {
    this.q.push(...x)
    return this
  }

  deQ() {
    return this.q.shift()
  }

  mt() {
    return this.q.length === 0
  }
}

/* BT */

class Node {
  constructor(l, v, r, p = null) {
    this.l = l
    this.r = r
    this.v = v
    this.p = p
    this.leaf = false
  }
}

class Leaf {
  constructor() {
    this.l = null
    this.r = null
    this.v = null
    this.p = null
    this.leaf = true
  }

}

/* Adjacency List */

// AdjacencyList :: AL a
class AdjacencyList {
  constructor() {
    // al :: HashMap a (Set a)
    this.al = {}
  }

  //insert :: Vertex -> Vertex -> AL
  insert(v, w) {
    const al = this.al
    if (!al[v])
      al[v] = new Set()
    if (w !== undefined) {
      if (!al[w])
        al[w] = new Set()
      al[v].add(w)
    }
    return this
  }

  // vertices :: [Vertex]
  vertices() {
    return Object.keys(this.al)
  }

  // neighbors :: Vertex -> [Vertex]
  neighbors(v) {
    return [...this.al[v]]
  }

  // connected :: Vertex -> Vertex -> Bool
  connected(v, w) {
    return this.al[v].has(w)
  }
}

/***************************************************************************/

module.exports = {
  foldR,
  foldL,
  cons,
  car,
  cdr,
  cadr,
  uncons,
  list,
  printList,
  log,
  AdjacencyList,
  Q,
  Leaf,
  Node
}
