/* Route Between Nodes: Given a directed graph, design an algorithm to find
 * out whether there is a route between two nodes
 */

const log = console.log
const { graph } = require('./samples')
const { Q } = require('../../../utils/utils')

// Approach 1:
  // DFS with a visited set
// f :: AL Int -> Int -> Int -> Set Int -> Bool
const f = (g, v, w, s = new Set()) => {
  if (g.connected(v, w)) return true
  if (s.has(v)) return false
  s.add(v)
  return g.neighbors(v).some(x => f(g, x, w, s))
}

/* Approach 2
 * BFS with visited set
 *  - add v to Q and visited
 *  - While Q is !mt
 *    - x = deQ
 *    - add all neighbors of x into Q
 *    - add x to visited
 *    - if visisted set has w => true
 *  - => false
 */

// bfsRoute :: AL Int -> Int -> Int -> Bool
const bfsRoute = (g, v, w) => {
  const visited = new Set(),
    q = new Q().enQ(v)
  while (!q.mt()) {
    const n = q.deQ(),
      ns = g.neighbors(n)
    if (visited.has(n)) continue
    q.enQ(...ns)
    visited.add(n)
    if (visited.has(w)) return true
  }
  return false
}

log(f(graph, 0, 3)) // => true
log(f(graph, 6, 0)) // => false
log(bfsRoute(graph, 0, 6)) // => false
log(bfsRoute(graph, 0, 3)) // => true
