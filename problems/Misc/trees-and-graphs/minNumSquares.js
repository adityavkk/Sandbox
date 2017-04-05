/* Given an integer n, find the least number of perfect squares that sum to n
 * 25 = 5^2 => 1
 * 5 = 2^2 + 1^2 => 2
 * 3 = 3 * 1^2 => 3
 */

/* Approach 1:
 * f :: Int -> Int
 * y = sqrt x
 * if y is an int: 1
 * min([f (x - z^2) + 1 | z <- [1..floor y]])
 */

// DP Approach
const log = console.log
const memo = {}
const R = require('ramda')
const f = x => {
  if (memo[x]) return memo[x]
  const y = Math.sqrt(x)
  let v
  if (x <= 0) v = 0
  else if (y % 1 === 0) v = 1
  else {
    const ys = range(1, Math.ceil(y)).map(z => f(x - Math.pow(z, 2)) + 1)
    v = Math.min(...ys)
  }
  memo[x] = v
  return v
}

function range(i, j) {
  return new Array(j - i).fill(0).map((_, k) => k + i)
}

log(f(12))
