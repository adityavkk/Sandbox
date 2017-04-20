/*
   A group of farmers has some elevation data that we are going to use to help
   them understand how rainfall flows over their farmland. We represent the
   farmland as a 2D array of altitudes, the grid, and use the following model,
   based on the fact that water flows downhill:

   - If a cell's four neighboring cells all have altitudes not lower that itw
   own, this cell is a sink in which water collects.

   - Otherwise, water will flow into the neighboring cell with the lowest altitude.
   If a cell is not a sink, you can assume it has a unique lowest neighbor and
   that this neighbor will be lower than the cell.

   - Cells that drain into the same sink, directly or indirectly, are part of the same basin.

   Given an n × n grid of elevations, your goal is to partition the map into
   basins and output the sizes of the basins, in descending order.

  grid = [[1, 5, 2],
          [2, 4, 7],
          [3, 6, 9]]
  output = [7, 2]
 */

/* Build AdjList and DFS to get length of connected components
 * f :: Grid -> [LengthOfConnectedComponent]
 * g = makeGraph grid
 * sizes = []
 * seen = set {}
 * traverse v in vs:
 *    if v not in seen:
 *      sz = dfs(0, v)
 *      push sz seen
 *  return sorted sizes
 *
 * dfs (mutates seen, accesses g global):: Size -> Vertex -> SizeOfConnectedComp
 * - size++
 * - if v in seen:
 *     return size
 * - ns = all neighbors of v in g filter seen
 * - size += sum (map dfs(size) ns)
 *   return size
 *
 * makeGraph :: Grid -> AdjList
 * - reduce grid with h starting with {}
 *   h :: Graph -> Vertex -> Graph
 *   - n = min (neighbors to v that exist)
 *     if n < v:
 *        g[v] = [n]
 *        g[n] = [v]
 *     return g
 */
var log = console.log
var { defaultTo, equals } = require('ramda')

var f = gs => {
  var graph = makeGraph(gs),
    seen = new Set()
  return gs.reduce(row, []).sort((a, b) => b - a)

  function row(sizes, r, i) {
    return r.reduce((szs, x, j) => {
      var h = hash(i, j)
      if (!seen.has(h)) {
        szs.push(dfs(0, i, j))
      }
      return szs
    }, sizes)
  }

  function dfs(sz, i, j) {
    var h = hash(i, j)
    if (seen.has(h)) return sz
    sz++
    seen.add(h)
    var ns = defaultTo([], graph[h]).filter(n => !seen.has(hash(n)))
    sz += sum(ns.map(([ni, nj]) => dfs(0, ni, nj)))
    return sz
  }

  function makeGraph(gs) {
    return gs.reduce(row, {})

    function row(g, r, i) {
      return r.reduce((g, x, j) => {
        var ns = [
            [i - 1, j],
            [i + 1, j],
            [i, j + 1],
            [i, j - 1]
          ].filter(exists)
          .map(([ii, jj]) => [
            [ii, jj], gs[ii][jj]
          ]);
        var [[ni, nj], n] = min(ns),
          v = gs[i][j]
        if (n < v) {
          var h = hash(ni, nj), ij = hash(i, j)
          g[h] = !g[h] ? [[i, j]] : g[h].concat([[i, j]])
          g[ij] = !g[ij] ? [[ni, nj]] : g[ij].concat([[ni, nj]])
        }
        return g
      }, g)
    }

    function exists ([i, j]) {
      return gs[i] !== undefined && gs[i][j] !== undefined
    }

    function min(xs) {
      return xs.reduce(([pos, mn], [[i, j], x]) => {
        if (x < mn) return [[i, j], x]
        else return [pos, mn]
      }, [[], Infinity])
    }
  }

  function hash(i, j) {
    return [i, j].toString()
  }

  function sum(xs) {
    return xs.reduce((a, b) => a + b, 0)
  }

  function defaultTo(def, x) {
    if (x === null || x === undefined) return def
    return def
  }
}
var grid1 = [[58,7,0,90,54,39,73,16,34,24],
               [56,3,46,69,8,52,30,65,59,72],
                [34,61,51,44,37,78,100,49,89,71],
                [30,16,74,51,48,77,20,8,60,100],
                [9,34,33,70,42,28,89,26,6,0],
                [93,28,91,69,11,16,65,42,12,25],
                [4,86,36,82,53,7,97,84,77,2],
                [87,10,78,59,44,82,28,92,67,69],
                [88,65,56,50,68,84,34,18,70,77],
                [100,60,53,93,64,55,83,22,89,8]],
output = [10, 9, 7, 7, 7, 5, 5, 4, 4, 4, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1]
log(equals(f(grid1), output))
