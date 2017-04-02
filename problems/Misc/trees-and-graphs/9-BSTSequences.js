/* A BST was created by traversing through an array from left to right and
 * inserting each element. Given a BST with distinct elements, print all possible
 * arrays that could've led to the tree.
 *
 * Ex:
 *  Input:
 *    2
 *  1   3
 *
 *  Output: [2, 1, 3], [2, 3, 1]
 */

/* Insert x n:
 *  if n is null = new Node
 *  if x < n: insert x n.l
 *  if x > n: insert x n.r
 */

/* f :: BST a -> [[a]]
 * - map (n: . concat) [f n.l ++ f n.r, f n.r ++ f n.l]
 */

const R = require('ramda')
const log = console.log
const bt = require('./2-minimalTree')

const f = n => {
  if (n.leaf) return [[]]
  if (n.r.leaf && n.l.leaf) return [
    [n.v]
  ]
  const consConcat = R.compose(xs => [n.v].concat(xs), R.flatten),
    l = f(n.l),
    r = f(n.r),
    lr = concat(l.map(x => r.map(y => x.concat(y)))),
    rl = concat(r.map(x => l.map(y => x.concat(y))))
  return lr.map(x => [n.v].concat(x))
  .concat(rl.map(x => [n.v].concat(x)))
}

function concat(xs) {
  return xs.reduce((flat, x) => flat.concat(x), [])
}

log(bt.l)
// log(f(bt))
log(f(bt))
