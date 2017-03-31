/* Minimal Tree: Given a sorted (increasing order) array with unique integer elements,
 * write an algorithm to create a binary search tree with minimal height
 */

/* Approach 1:
 * f :: [Int] -> BST Int
 * - if xs is mt: leaf
 * - else Node (f xs[:ci]) xs[ci] (f xs[ci+1])
 *   where ci = length xs `div` 2
 *
 * O(log n) if work at each depth is O (1), so need to pass start and end idxs
 */

const log = console.log
const { Leaf, Node } = require('../../../utils/utils')

// f :: [Int] -> Int -> Int -> BST Int
const f = (xs, i = 0, j = xs.length - 1) => {
  if (j < i) return new Leaf()
  const ci = Math.floor((j - i + 1) / 2) + i
  return new Node(f(xs, i, ci - 1), xs[ci], f(xs, ci + 1, j))
}

const bt = f([1, 2, 3, 4, 5, 6, 7])

module.exports = bt
