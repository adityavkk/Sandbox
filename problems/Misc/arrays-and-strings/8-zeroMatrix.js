/* Make an algorithm such that if an element in an MxN matrix is 0, then the entire
 * row and column is set to 0
 *
 * Approach:
 * f :: Matrix -> Matrix
 * seen :: Set Int
 * makeZero :: Matrix -> Row -> Col -> Matrix
 *
 * - for r in mat:
 *      for c in r:
 *         if xij == 0 and i j not in seen:
 *           mat = makeZero mat i j
 *           insert i j into seen
 */
const log = console.log
const f = mat => {
  const seenR = new Set(),
    seenC = new Set()
  mat.forEach((r, i) => {
    r.forEach((x, j) => {
      if (x === 0 && !seenR.has(i) && !seenC.has(j)) {
        makeZero(mat, i, j)
        seenR.add(i)
        seenC.add(j)
      }
    })
  })
  return mat
}

function makeZero(mat, i, j) {
  mat[i] = new Array(mat[i].length).fill(0)
  mat.forEach(r => {
    r[j] = 0
  })
  return mat
}

const xs = [
  [1, 2, 3, 0],
  [1, 4, 3, 4],
  [9, 0, 1, 2]
]
log(f(xs))
