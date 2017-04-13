/* @flow */
const log = console.log

/* In a matrix, black is represented by 0 and white by 1. Return all the (x, y)
 * coordinates of the top left corner of the black rectangles
 */

/* corners = coord[]
 * rectCoordSeen = set {}
 * for coord in coords:
 *   if coord == black and not in seen:
 *     add coord to corners
 *     add allRectCoords to seen
 * return corners
 *
 * allRectCoords :: Mat -> Start -> [Coords]
 * w = j' - j where j' is the first col from start where mat[i][j'] is 1
 * h = i' - i where i' is the first row from start where mat[i'][j] is 1 or mat[i'][j'] is 0
 *            or mat[i'][j < j'] is 1
 * return all coords from i to i' and j to j'
 */

/*:: type coord = [number, number] */
/*:: type matrix = number[][] */

const { range, flatten } = require('lodash')

const f = (mat /*: matrix */) /*: coord[] */ => {
  const [seen, corners] = mat.reduce(([seen, corners], r, i) => {
    return r.reduce(([seen, corners], x, j) => {
      if (x === 0 && !seen.has(hash(i, j))) {
        corners.push([i, j])
        allRectCoords(mat, [i, j]).reduce((s, [pi, pj]) => s.add(hash(pi, pj)), seen)
      }
      return [seen, corners]
    }, [seen, corners])
  }, [new Set(), []])
  return corners
}

function allRectCoords(mat /*: matrix */, [i, j] /*: coord */) /*: coord[] */ {
  let j1 = j, i1 = i
  while (exists(mat[i][j1]) && mat[i][j1] === 0) j1++
  while (exists(mat[i1]) && mat[i1][j1 - 1] === 0 && mat[i1][j] === 0) i1++
  return flatten(range(i, i1).map(x => range(j, j1).map(y => [x, y])))
}

function exists(x /*: any */) /*: bool */ {
  return !(x === undefined || x === null)
}

function hash(i /*: number */, j /*: number */) /*: string */ {
  return i + ';' + j
}

const xs = [
  [1, 1, 0, 0, 1],
  [1, 1, 0, 0, 1],
  [0, 0, 1, 0, 1],
  [0, 0, 1, 0, 0],
  [0, 0, 0, 1, 0]
]
log(f(xs))
