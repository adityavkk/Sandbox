/*
   Given an array of numbers arr, determine whether arr can be divided into two
   subsets for which the sum of elements in both subsets is the same.

   xs = [3, 5, 16, 8] => true
   [3, 5, 8] [16]
*/

/* Brute Force!
 * - Try all size i subsets with xs[0] where 1 <= i <= n - 1
 * O ( sum over k (n - 1 Chooose k where 0 <= k <= n - 1))
 *
 * f :: [Int] -> Bool
 * - sum xs - x
 * - any (== sum / 2) (map (3 +) (sumCombs xs[1:]))
 *
 * sumCombs :: [Int] -> [SumsOfChooseCombinations]
 * - flatten (fold over xs starting with [xs])
 *   - ys = xs[-1]
 *   - fold over ys starting with []
 *      - ys' is rest of ys after y
 *      - return acc ++ (map (y +) ys)
 *   - return xs ++ (map (y +) ys)
 *
 * DP Solution
 * O (n)
 * - We can reduce this problem to one of finding a subset in xs which sums to
 *   sum xs / 2
 * - subsetSum :: [Int] -> TargetSum -> Bool
 *   subsetSum xs (sum xs / 2)
 *   - if xs is empty and t is not 0: false
 *   - if xs is empty and t is 0: true
 *   - Either x in xs is potentially in a subset which sums to t
 *      - subsetSum xs[1:] (t - x)
 *   - Or x is not in the subset which sums to t
 *      - subsetSum xs[1:] t
 */

/* @flow */
// const { any, sum, equals, add, last, flatten, map, range } = require('ramda')
// const log = console.log

// [> Brute Force <]
// const f = xs => {
  // const s = sum(xs),
    // ys = map(add(xs[0]), [0, ...sumCombs(xs.slice(1))])
  // return any(equals(s / 2), ys)
// }

// function sumCombs(xs) {
  // return flatten(xs.reduce((combs, _) => {
    // const ys = last(combs)
    // return combs.concat(ys.reduce((zs, y, i) => {
      // const ys1 = ys.slice(i + 1)
      // zs.push(map(add(y), sumCombs(ys1)))
      // return zs
    // }, []))
  // }, [xs]))
// }

/* DP Linear */
const log = console.log
const { isEmpty, sum } = require('lodash')
const g = xs => {
  const s = sum(xs)
  if (s % 2 === 1) return false
  return subsetSum(xs, sum(xs) / 2)
}

const memo = {}
function subsetSum(xs, t) {
  const h = xs.toString() + ';' + t
  let v
  if (memo[h]) return memo[h]
  if (t < 0) v = false
  else if (t === 0) v = true
  else if (isEmpty(xs)) v = false
  else {
    const x = xs[0]
    xs = xs.slice(1)
    v = subsetSum(xs, t - x) || subsetSum(xs, t)
  }
  memo[h] = v
  return v
}

const xs = [795, 743, 144, 829, 390, 682, 340, 541, 569, 826, 232, 261, 42, 360, 117, 23, 761, 81, 309, 190, 425, 996, 367, 677, 234, 690, 626, 524, 57, 614, 168, 205, 358, 312, 386, 100, 346, 726, 994, 916, 552, 578, 529, 946, 290, 647, 970, 51, 80, 631, 593, 857, 627, 312, 886, 214, 355, 512, 90, 412, 479, 610, 969, 189, 274, 355, 641, 620, 433, 987, 888, 338, 566, 770, 284, 856, 417, 606, 260, 849, 237, 205, 59, 217, 518, 945, 783, 873, 458, 873, 637, 289, 483]
const ys = [3, 5, 16, 8, 20, 12, 15, 16, 33, 10, 25, 29, 128]
log(g(xs))
log(Object.keys(memo).length)
