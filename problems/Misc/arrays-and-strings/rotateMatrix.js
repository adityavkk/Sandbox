/* Write an algorithm to rotate a matrix in place by pi/2 radians clockwise */

/* (i, j) -> (j, n' - i) -> (n' - i, n' - j) -> (n' - j, i) -> (i, j)
 * f :: Matrix -> Matrix
 * i in range(0, floor(n / 2)):
 *    j in range(i, n - i):
 *      reduce over [(i, j), (j, n' - i), (n' - i, n' - j), (n' - j, i), (i, j)]
 *      and swap each element
 * return matrix
 */

/* @flow */
const floor = Math.floor
const { range } = require('lodash')
const log = console.log

/*:: type matrix = number[][] */

const f = (mat /*: matrix */ ) /*: matrix */ => {
  const n = mat.length
  let last, curr
  range(0, floor(n / 2)).forEach(i => {
    range(i, n - 1 - i).forEach(j => {
      last = mat[i][j]
      let swaps = [[j, n - 1 - i], [n - 1 - i, n - 1 - j], [n - 1 - j, i], [i, j]]
      swaps.forEach(([x, y]) => {
          curr = mat[x][y]
          mat[x][y] = last
          last = curr
        })
    })
  })
  return mat
}

const xs = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]]
log(f(xs))
