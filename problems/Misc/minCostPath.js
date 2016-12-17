// http://www.geeksforgeeks.org/dynamic-programming-set-6-min-cost-path/
// Return the minimum cost to reach (m, n) from (0, 0) when you can only
// go down, right and diagonal
const matrix = [
  [1, 2, 3],
  [4, 9, 9],
  [1, 5, 3]
]

const minCost = (mx, m, n, i, j) => {
  const val = mx[i][j]
  if (i === m && j === n) return mx[i][j]
  if (i === m) return hSum(mx, i, j, n)
  if (j === n) return vSum(mx, i, j, m)
  const goDown = val + minCost(mx, m, n, i, j + 1),
    goRight = val + minCost(mx, m, n, i + 1, j),
    goDiagonal = val + minCost(mx, m, n, i + 1, j + 1)
  return Math.min(goDown, goRight, goDiagonal)
}

function hSum(mx, i, j, n) {
  return mx[i].slice(j, n + 1).reduce((acc, e) => acc + e)
}

function vSum(mx, i, j, m) {
  let sum = 0
  while (i <= m) {
    sum += mx[i][j]
    i++
  }
  return sum
}

console.log(minCost(matrix, 2, 2, 0, 0))
