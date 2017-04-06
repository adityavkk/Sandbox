/* Given a set of distinct integers, s, return all possible subsets
 * Note:
 * Elements in a subset must be in non-descending order.
 * The solution set must not contain duplicate subsets.
 * Also, the subsets should be sorted in ascending ( lexicographic ) order.
 * The list is not necessarily sorted.
 */

/* xs = [1, 2, 3]
 * => [ [], [1], [1, 2], [1, 2, 3], [1, 3], [2], [2, 3], [3] ]
 */

/* f :: [Int] -> [[Int]]
 * [[]] ++ (subsets with x w/o mt set) ++ (subsets without x w/o mt set)
 * Subsets with x w/o mt set:
 * map (x:) (f xs)
 * Subsets without x w/o mt set:
 * tail (f xs)
 */

const log = console.log
const { map, tail, curry } = require('ramda')
const g = xs => {
  xs = xs.sort((a, b) => a - b)
  return f(xs)
  function f(xs) {
    const hash = xs.toString(),
    cons = curry((x, xs) => {
      return [x].concat(xs)
    })
    if (xs.length === 0) return [[]]
    const fxs = f(xs.slice(1)),
      x = xs[0]
    return [[]].concat(map(cons(x), fxs))
            .concat(tail(fxs))
  }
}

log(g([1, 2, 3]))
