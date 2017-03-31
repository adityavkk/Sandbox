/* Write an algorithm to find the in order successor of a given BST. You may assume
 * that each node has a pointer to its parent
 */

/* Approach 1:
 * if n has right children: min(n.r)
 * if n is a right child: f(n.p') where p' = n.p with right pointer = null
 * if n is a left child: parent
 */
const log = console.log

const f = n => {
  if (!n.r.leaf) return min(n.r)
  if (leftChild(n)) return n.p
  if (rightChild(n)) {
    const p = n.p
    const p1 = new Node(n.l, p.v, null, p.p)
    return f(n.p1)
  }
  return null
}

function min(n) {
  if (n.l.leaf) return n
  return min(n.l)
}

function leftChild(n) {
  return n.p && n.p.l === n ? true : false
}

function rightChild(n) {
  return n.p && n.p.r === n ? true : false
}
