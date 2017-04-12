/* Given a matrix of M x N elements (M rows, N columns), return all elements of the
 * matrix in diagonal order.
 *
 * input: [ [1, 2, 3],
 *          [4, 5, 6],
 *          [7, 8, 9]
 *        ]
 * output: [1, 2, 4, 7, 5, 3, 6, 8, 9]
 */

/* f :: Mat -> [Int]
 * - Get diagonals going up starting from (0, 0) -> (m - 1, 0)
 *                                        (m - 1, 1) -> (m - 1, n - 1)
 * - concat all of them together making sure to reverse every odd one (since it
 *   would've been a downward trajectory)
 * - enumerate all starting positions in order
 * - map diag onto each starting position
 * - reduce while concating and reversing appropriate diagonal
 *
 * diag :: Mat -> StartPos -> DiagonalTillNow -> Diag
 * - if start is out of bounds in the matrix:
 *    return diagTillNow
 * - return diag(mat, next(start), diagTillNow + val at start)
 */

/* @flow */
const { range } = require('lodash')
const log = console.log

/*:: type diagonal = number[] */
/*:: type pos = [number, number] */

function f(matrix /*: number[][] */) /*: number[] */ {
  const mat = new Matrix(matrix), m = mat.rows(), n = mat.cols(),
    rows = range(0, m).map(r => [r, 0]),
    cols = range(1, n).map(c => [m - 1, c]),
    diags = rows.concat(cols)
                .map(pos => diag(mat, pos))
  return concatAndReverseOdd(diags)
}

class Matrix {
  /*:: mat: number[][] */
  constructor(mat) {
    this.mat = mat
  }

  rows() /*: number */ {
    return this.mat.length
  }

  cols() /*: number */ {
    return this.mat.length ? this.mat[0].length : 0
  }

  val(i, j) /*: ?number */ {
    return this.mat[i] ? (this.mat[i][j] !== undefined ?
                          this.mat[i][j] : null) : null
  }
}

function diag(mat /*: Matrix */, [i, j] /*: pos */, d /*: diagonal */ = []) /*: diagonal */{
  const sVal = mat.val(i, j)
  return sVal != null ? diag(mat, [i - 1, j + 1], append(sVal, d)) : d
}

function concatAndReverseOdd(xxs /*: diagonal[] */) /*: diagonal */ {
  return xxs.reduce((d, x, i) => {
    if (i % 2 === 0) return d.concat(x)
    return d.concat(x.reverse())
  }, [])
}

function append /*::<T>*/(v /*: T */, xs /*: T[] */) /*: T[] */ {
  xs.push(v)
  return xs
}

console.log(f([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]))
