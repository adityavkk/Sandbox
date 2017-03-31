/* Design an algorithm and write code to find the first common ancestor of two
 * nodes in a binary tree. Avoid storing additional nodes in a data structure */

/* Approaches:
 * f :: Node 1 ->  Node 2 -> Optional From -> Ancestor
 * Case 1: a is ancestor of b -> search(b, a.l) || search(b, a.r) => a
 * Case 2: b is ancestor of a -> search(a, b.l) || search(a, b.l) => b
 * Case 3: They're siblings/cousins -> go up, search other side until you can't
 */
const log = console.log

const f = (a, b, frm = null) => {
  if (!frm) {
    if (search(b, a.l) || search(b, a.r)) return a
    if (search(a, b.l) || search(a, b.r)) return b
  } else {
    if (a.l === frm)
      if (search(a.r, b)) return a
    if (search(a.l, b)) return a
  }
  return f(a.p, b, a)
}

// search :: LookForNode -> Tree -> Bool
function search(n, t) {
  if (n === t) return true
  if (t === null) return false
  return search(n, t.l) || search(n, t.r)
}
