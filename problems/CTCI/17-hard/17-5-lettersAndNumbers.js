/* Given an array filled with letters and numbers, find the longest subarray with an
 * equal number of letters and numbers.
 *
 * a4nf24n5n39m2m
 */

/* f :: [LetterOrNumber] -> [LetterOrNumber]
 * - transform xs into preFixLetters, preFixNumbers
 * - ys = map (prefixLetters[i] - prefixNumbers[i]) onto xs
 * - ls = reduce over enum(ys) and return a set of the first occurance of each (y, i)
 * - rs = reduceRight over enum(ys) and return a set of the first occurance of each (y, i)
 * - reduce over ls keep track of longest length difference and start and end indices
 * - return xs[start:end + 1]
 *
 * prefixCount :: [String] -> RegExToMatch -> [Int]
 * - reduce over xs starting at [] by matching x with regEx if match: append last
 *   element + 1 to z else z
 */
const log = console.log
const { last, has } = require('ramda')

const f = (xs) => {
  xs = xs.split('')
  const pls    = prefix(xs, /[a-z]/),
        pns    = prefix(xs, /\d/),
        ys     = xs.map((_, i) => pls[i] - pns[i]),
        ls     = ys.reduce((s, y, i) => has(y, s) ? s : add(s, y, i), {}),
        rs     = ys.reduceRight((s, y, i) => has(y, s) ? s : add(s, y, i), {}),
        [i, j] = Object.keys(ls).reduce(([d, [s, e]], k) => {
          const dist = rs[k] - ls[k]
          return dist > d ? [dist, [ls[k], rs[k]]] : [d, [s, e]]
        }, [-Infinity, [0, 0]])[1]
  return xs.slice(i, j).join('')
}

function prefix(xs, regEx) {
  return xs.reduce((ys, x) => {
    return regEx.test(x) ? ys.concat(last(ys) + 1) : ys.concat(last(ys))
  }, [0])
}

function add(hm, k, v) {
  hm[k] = v
  return hm
}

const xs = 'afn1n22m'
log(f(xs))
