/* You are given a tree. The tree has N nodes numbered 1 to N and is rooted at node
 * 1. Find the minium number of edges you can remove from the tree to get a forest
 * such that each connected component of the forest contains an even number of
 * vertices.
 */

/* - Preprocess tree to add # of children + 1 information to each node
 * cut :: PreProcessedTree -> MaxEdgesRemoveable
 * - return sum (map cut cs) + # of cs with even count
 *
 * count = {}
 * process (mutates count) :: G -> Node -> Count
 * - count[n] = sum (map count cs) + 1
 *  return count[n]
 */

/* @flow */
const { sum, curry, defaultTo, map, range } = require('lodash')
const log = console.log

/*:: type node = number */
/*:: type graph = { [vertex:string] : node[] } */
/*:: type count = { [vertex:string] : number } */


const f = (g /*: graph */) /*: number */ => {
  const cut = curry((pg, n) => {
    const gn = defaultTo(g[n], []),
      evenKids = gn.filter(c => pg[c] % 2 === 0).length
    return sum(map(gn, cut(pg))) + evenKids
  })
  return cut(process(g), 1)
}

function process(g /*: graph */) /*: count */ {
  const counts = {}
  count(1)
  return counts

  function count(n /*: node */) {
    const gn = defaultTo(g[n], [])
    counts[n] = sum(map(gn, count)) + 1
    return counts[n]
  }
}

function parse(input) {
  input = input.split('\n')
  const es = +input.shift().split(' ')[1],
    gph = range(0, es).reduce((g, i) => {
    const [t, f] = input.shift().split(' ').map(Number)
    g[f] = defaultTo(g[f], []).concat(t)
    return g
  }, {})
  return gph
}

const g = {}
g[1] = [3, 6, 2]
g[2] = [5, 7]
g[3] = [4]
g[6] = [8, 9, 10]
const input = `10 9
2 1
3 1
4 3
5 2
6 1
7 2
8 6
9 8
10 8`
log(f(parse(input)))
