/* Given two arrrays of integers, find a pair of values (one value from each array)
 * that you can swap to give the two arrays the same sum.
 *
 * xs = [4, 1, 2, 1, 1, 2]
 * ys = [3, 6, 3, 3]
 * output: [1, 3]
 */


/* f :: [Int] -> [Int] -> Maybe (Int, Int)
 * - make set of ys
 * - calculate sum of xs and ys
 * - for x in xs:
 *      y = (sx - x) - (sy + x) / 2
 *      if y in ys: [x, y]
 */

/* @flow */

type MaybeTyple = ?[number, number]

const { add } = require('ramda')

const f = (xs: number[], ys: number[]): MaybeTyple => {
  const sys = new Set(ys),
        sx  = xs.reduce(add, 0),
        sy  = ys.reduce(add, 0)
  return xs.reduce((r: ?[number, number], x: number): MaybeTyple => {
    if (r) return r
    const y = ((sy + x) - (sx - x)) / 2
    if (sys.has(y)) return [x, y]
  }, undefined)
}

const xs = [1, 4, 2, 1, 1, 2],
      ys = [3, 6, 3, 3]
console.log(f(xs, ys))
