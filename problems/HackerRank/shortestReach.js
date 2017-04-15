/* Consider an undirected graph consisting of n nodes where each node is labeled from
 * 1 to n and the edge between any two nodes is always of length 6. We define node s
 * to be the starting position for a BFS.
 *
 * Given q queries in the form of a graph and some starting node, s, perform each
 * query by calculating the shortest distance from starting node s to all the other
 * nodes in the graph. Then print a single line of n - 1 space-seperated integers listing node
 * s's shortest distance to each of the n - 1 other nodes
 */

/* Keep a HM of vertex : distance
 * - do a BFS from start node and for vs in each level add 6 to the previous
 * level's distance
 * - if a v is in the HM then don't BFS on that node
 */


/* f :: G -> Vertex -> Dist
 * dist = {}
 * bfs G [start] 0
 *
 * bfs :: G -> [Vertex] -> CurrentDist -> MutatesDist
 * - if vs is mt: do nothing
 * - for v in vs: add v to dist with currDist
 * - cvs = flatMap children vs
 * - filter notInDist cvs
 * - bfs with curDist + 6 on cvs
 */

const { flatMap } = require('../../utils/arrayUtils')
const log = console.log
const { range } = require('lodash')
const { readFileSync } = require('fs')

/*:: type vertex = number */
/*:: type graph = { [vertex:string] : vertex[] } */
/*:: type dist = {[vertex:string] : number} */

const f = (g /*: graph */, s /*: vertex */) /*: number[] */ => {
  const d = {}
  bfs(g, [s], 0)
  delete d[s.toString()]
  const inGNotD = Object.keys(g).filter(v => d[v] === undefined && v !== s.toString())
                        .map(v => [v, -1])
  const distances = Object.entries(d)
                          .concat(inGNotD)
                          .sort(([v, x], [w, y]) => +v - +w)
                          .map(x => x[1])
  return distances

  function bfs(g /*: graph */, vs /*: vertex[] */, cDist /*: number */) {
    if (!vs.length) return
    vs.forEach(v => d[v] = cDist)
    const cvs = flatMap(v => g[v], vs).filter(v => d[v] === undefined)
    bfs(g, cvs, cDist + 6)
  }
}

// parse :: String -> [(Graph, Start)]
function parse(input /*: string */) /*: [graph, vertex][] */{
  input = input.split('\n')
  const gs = []
  const numQs = +input.shift()
  range(0, numQs).forEach(i => {
    const [vs, es] = input.shift().split(' ').map(Number),
          g = range(1, vs + 1).reduce((gph, i) => {
            gph[i] = []
            return gph
          }, {})
          range(0, es).forEach((_) => {
            const [frm, to] = input.shift().split(' ').map(Number)
            g[frm].push(to)
            g[to].push(frm)
          })
          const start = +input.shift()
          gs.push([g, start])
  })
  return gs
}

function printOut(xs) {
  log(xs.length)
  xs.forEach(x => log(f(...x).join(' ')))
}

printOut(parse(readFileSync('./test/shortestReach.txt', 'utf8')))
