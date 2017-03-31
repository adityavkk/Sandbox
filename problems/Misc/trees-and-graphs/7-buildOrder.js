/* BuildOrder: You are given a list of projects and a list of dependencies which
 * is a list of pairs of projecs, where the second proect is dependent on the first
 * . All of a project's dependencies must be build before the project is. Find
 * a build order that will allow the projects to be build if there is no valid build
 * order return an error.
 *
 * Input: projects: a, b, c, d, e, f
 *        dependencies: (a, d), (f, b), (b, d), (f, a), (d, c)
 *
 * Output: f, e, a, b, d, c
 */

/* Approach 1:
 * Topological Sort on the graph of dependencies
 * - reverse a postorder traversal of graph
 * - visited :: Set a
 * - postOrder :: AL a -> Vs -> Ordering -> Ordering
 *   for v in vs:
 *   - if v is visited: continue
 *   - append (concatMap postOrder (neighbors v) []) ordering
 *   - push v into visited and push it into ordering
 * - return ordering
 */

const { AdjacencyList } = require('../../../utils/utils')
const log = console.log

// ts :: AL a -> [a]
const ts = g => {
  return postOrder(g, g.vertices(), []).reverse()
}

const visited = new Set()
// postOrder :: AL a -> [a] -> [a] -> [a]
function postOrder(g, vs, ord0) {
  return vs.reduce((ord, v) => {
    if (visited.has(v)) return ord
    ord = ord.concat(postOrder(g, g.neighbors(v), []))
    visited.add(v)
    ord.push(v)
    return ord
  }, ord0)
}

const g = new AdjacencyList().insert('a', 'd')
  .insert('f', 'b')
  .insert('b', 'd')
  .insert('f', 'a')
  .insert('d', 'c')
  .insert('g', 'd')
  .insert('e')

log(ts(g))
