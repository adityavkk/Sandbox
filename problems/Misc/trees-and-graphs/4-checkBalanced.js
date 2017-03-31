/* CheckBalanced: Implement a fn to check if a binary tree is balanced. A
 * balanced binary tree is defined to be a tree such that the heights of the
 * two subtrees of any node never differ by more than one
 */

/* Approach 1:
 * f :: Node a -> Bool
 * if leaf: true
 * if n.l & (n.l.l || n.l.r) & !n.r: false
 * if n.r & (n.r.l || n.r.r) & !n.l: false
 * f(n.l) || f(n.r)
 */
const log = console.log
const bt = require('./2-minimalTree')

const f = n => {
  if (n.leaf) return true
  if (n.l.v && (n.l.l.v || n.l.r.v) && !n.r.v) return false
  if (n.r.v && (n.r.l.v || n.r.r.v) && !n.l.v) return false
  return f(n.l) && f(n.r)
}

log(f(bt))
