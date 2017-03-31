/* Implement a function to check if a binary tree is a binary search tree */

/* Approach 1:
 * f :: (Ord a) => Node a -> Min a -> Max a -> Bool
 * f n mn mx
 * if n.v == null: true
 * if n.v <= mn || n.v > mx: false
 * else: f n.l mn n.v && f n.r n.v mx
 */

const bt = require('./2-minimalTree')
const log = console.log

const f = (n, mn, mx) => {
  if (n.v === null) return true
  if (n.v < mn || n.v > mx) return false
  return f(n.l, mn, n.v) && f(n.r, n.v, mx)
}

log(f(bt))
