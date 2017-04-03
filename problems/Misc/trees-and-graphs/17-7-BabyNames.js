/* Given two lists, one of names/frequencies and ther other of pairs of equivalent
 * names, write an algorithm to print a new list of the true frequency of each name
 *
 * Input: [{John: 15}, {Jon: 12}, {Chris: 13}, {Kris: 4}, {Christopher : 19}]
 *        [[Jon, John], [John, Johnny], [Chris, Kris], [Chris, Christopher]]
 * Output: {John: 27, Kris: 36}
 */

/* Approach:
 * - Relationships define an edge between names
 * - The problem reduces to finding the connected components in an undirected graph
 *
 * - Build an Adjacency List with given relationships
 *   dfs :: Name -> Maybe EquivalentName
 *   - Run DFS
 *     - If v is unvisited, create new entry in frequency under v and recursively
 *       call dfs with equivalent name
 *     - If equivalent name: add to frequency
 */
const log = console.log
const { AdjacencyList } = require('../../../utils/utils')

const f = (ns, rs) => {
    const visited = new Set(),
    al = rs.reduce((g, r) => g.insert(r[0], r[1]), new AdjacencyList()),
    nLookup = ns.reduce((lup, n) => {
      lup[n[0]] = n[1]
      return lup
    }, {})

  function dfs(fs, v, eName) {
    if (eName) {
      fs[eName] += nLookup[v]
      al.neighbors(v).map(w => dfs(fs, w, eName))
      visited.add(v)
    }
    if (!visited.has(v)) {
      fs[v] = nLookup[v]
      al.neighbors(v).map(w => dfs(fs, w, v))
      visited.add(v)
    }
    return fs
  }
  return al.vertices().reduce((fs, v) => dfs(fs, v), {})
}

const ns = [[ 'John', 15 ], [ 'Jon', 12 ], [ 'Chris', 13 ], [ 'Kris', 4 ], [ 'Christopher' , 19 ], ['Johnny', 1]]
const rs = [['Jon', 'John'], ['John', 'Johnny'], ['Chris', 'Kris'], ['Kris', 'Christopher']]
log(f(ns, rs))
