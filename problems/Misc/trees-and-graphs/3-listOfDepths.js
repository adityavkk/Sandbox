/* Given a binary tree, design an algorithm whcih creates a linked list of all
 * nodes at each depth
 */

/* Approach 1:
 * BFS, but before enQing all the neighbors of v, append it to ll
 * - add v to Q
 * - lls = []
 * - ll, ns
 * - while Q is not mt:
 *    - x = deQ
 *    - insert x ll
 *    - push (neighbors x) ns
 *    - if Q is mt:
 *      - push ll lls
 *      - enQ ns
 *      - reinit ll and ns
 * lls
 *
 * Approach 2:
 * f :: [Node a] -> [[a]] -> [[a]]
 * - if ns is mt: lls
 * - else:
 *    - foldr over ns to make ll
 *    - push ll lls
 *    - f (concatMap neighbord ns) lls
 */

const R = require('ramda')
const { cons, printList, car } = require('../../../utils/utils')
const bt = require('./2-minimalTree')
const log = console.log

const f = (ns, lls = []) => {
  if (!ns.length) return lls
  else {
    const ll = R.reduceRight((x, l) => x ? cons(x, l) : l, null, R.map(x => x.v, ns))
    lls.push(ll)
    return f(concatMap(n => children(n), ns), lls)
  }
}

// children :: Node a -> [Node a]
function children(n) {
  if (n.leaf) return []
  if (n.l.leaf) return [n.r]
  if (n.r.leaf) return [n.l]
  return [n.l, n.r]
}

function concatMap(fn, xs) {
  return R.compose(R.flatten, R.map(fn))(xs)
}

log(R.map(printList, f([bt])))
