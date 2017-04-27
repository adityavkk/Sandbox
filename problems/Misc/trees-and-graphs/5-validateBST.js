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

const f = (n, mn = -Infinity, mx = Infinity) => {
  if (n.v === null) return true
  if (n.v < mn || n.v > mx) return false
  return f(n.l, mn, n.v) && f(n.r, n.v, mx)
}

const g = (n) => {
  let inOrderPredecessor = -Infinity
  const check = (node) => {
    if (node === null) return true
    if (!check(node.l) || n.v < inOrderPredecessor) return false
    inOrderPredecessor = n.v
    return check(node.r)
  }
  return check(n)
}

const inOrder = (n) => {
  if (!n.l && !n.r) return []
  const left = inOrder(n.l),
        right = inOrder(n.r)
  return left.concat(n.v).concat(right)
}

const h = n => {
  let inOrderPredecessor = -Infinity
  function check(n) {
    if (!n.r && !n.l) return true
    if (check(n.l) && n.v >= inOrderPredecessor) {
      inOrderPredecessor = n.v
      return check(n.r) ? true : false
    }
    return false
  }
  return check(n)
}

log(f(bt))
log(g(bt))
log(h(bt))
log(inOrder(bt))
