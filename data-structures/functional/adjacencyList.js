// An Immutable Adjacency List Representation of a Graph with Weighted Edges and
// Structural Sharing

class AL {
  constructor(vs = []) {
    this.vs = vs
  }
}

class Vertex {
  constructor(v, es = []) {
    this.v = v
    this.es = es
  }
}

class Edge {
  constructor(x, y, w) {
    this.f = x
    this.t = y
    this.w = w
  }
}

// adjacent :: AL -> Vertex -> Vertex -> Bool
function adjacent(G, x, y) {
  if (G.vs.some(v => v === x) && G.vs.some(v => v === y))
    return x.es.some(e => e.t === y)
}

// adjacentVals :: AL a => AL -> a -> a -> Bool
function adjacentVals(G, xv, yv) {
  const x = G.vs.filter(v => v.v === xv)[0]
  if (G.vs.some(v => v.v === xv) && G.vs.some(v => v.v === yv))
    return x.es.some(e => e.t.v === yv)
}

// neighbors :: AL -> Vertex -> [Vertex]
function neighbors(G, x) {
  if (G.vs.some(v => v === x))
    return x.es.map(e => e.t)
}

// neighborsByVal :: AL a => AL -> a -> [Vertex]
function neighborsByVal(G, xv) {
  const x = G.vs.filter(v => v.v === xv)[0]
  if (x) {
    return x.es.map(e => e.t)
  }
}

// addVertex :: AL -> Vertex -> AL
function addVertex(G, x) {
  return new AL(G.vs.concat(x))
}

// addE :: AL -> Vertex -> Vertex -> Int -> AL
function addE(G, x, y, w) {
  const nVs = G.vs.filter(v => v !== x && v !== y),
    nY = new Vertex(y.v, y.es),
    nX = new Vertex(x.v),
    nXes = x.es.filter(e => e.t !== y).concat(new Edge(nX, nY, w)),
    nYes = nY.es.map(e => {
      if (e.t === x) {
        return new Edge(nY, nX, e.w)
      }
      return e
    })
  nX.es = nXes
  nY.es = nYes
  return new AL(nVs.concat(nX, nY))
}

// addEByVals :: AL a => AL -> a -> a -> Int -> AL
function addEByVals(G, xv, yv, w) {
  const nVs = G.vs.filter(v => v.v !== xv && v.v !== yv),
    y = G.vs.filter(v => v.v === yv)[0],
    x = G.vs.filter(v => v.v === xv)[0],
    nY = new Vertex(yv, y.es),
    nX = new Vertex(xv),
    nXes = x.es.filter(e => e.t !== y).concat(new Edge(nX, nY, w)),
    nYes = nY.es.map(e => {
      if (e.t === x) {
        return new Edge(nY, nX, e.w)
      }
      return e
    })
  nX.es = nXes
  nY.es = nYes
  return new AL(nVs.concat(nX, nY))
}

// removeVertex :: AL -> Vertex -> AL
function removeVertex(G, x) {
  const nVs = G.vs.filter(v => v !== x)
    .reduce((nvs, v) => {
      if (v.es.some(e => e.t === x)) {
        const nEs = v.es.filter(e => e.t !== x)
        return nvs.concat(new Vertex(v.v, nEs))
      }
      return nvs.concat(v)
    }, [])
  return new AL(nVs)
}

// delE :: AL -> Vertex -> Vertex -> AL
function delE(G, x, y) {
  const nX = new Vertex(x.v, x.es.filter(e => e.t !== y))
  return addVertex(removeVertex(G, x), nX)
}

// getEVal :: AL a => AL -> a -> a -> Int
function getEVal(G, xv, yv) {
  const x = G.vs.filter(v => v.v === xv)[0],
    y = G.vs.filter(v => v.v === yv)[0]
  return x.es.filter(e => e.t === y)[0].w
}

const log = console.log,
  vs = [1, 2, 3, 4, 5, 6].map(v => new Vertex(v))
const G = vs.reduce(addVertex, new AL()),
  G1 = addE(addE(addE(G, vs[0], vs[1], 10), vs[2], vs[3], 20), vs[4], vs[5], 30),
  G2 = addEByVals(addEByVals(G1, 2, 1, 15), 2, 1, 20)
log(getEVal(G2, 1, 2)) // 10
log(getEVal(addEByVals(G2, 1, 2, 7), 1, 2)) // 7
