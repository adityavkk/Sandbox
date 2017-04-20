/*
   Given a string s, find the number of "unordered anagrammatic pairs" of substrings
   In other words, find the number of unordered pairs of substrings of s that are
   anagrams of each other.

   s = abba
   (a, a) (b, b) (ab, ba) (abb, bba) are all pairs of substrings of s that are
   anagrams of each other. Therefore, return 4

*/

/* Starting at each i:
 *  for j in range(1, n / 2)"
 *    check anagrams of substring of length j starting at s[i] in string starting
 *    at i + 1
 *
 * Seems like an n^3 algorithm
 */

/* f :: String -> Int
 * - reduce over string starting with 0
 *   - at each i:
 *      - for j in range(1, n / 2 - i):
 *        - ss = sort (substring starting at i of j length)
 *        - for k in range(i + 1, n - j):
 *          - check if sort (substring starting at i + k of length j) == ss:
 *              incr count
 *          - return count
 */

const { isEqual, range } = require('lodash')
const log = console.log,
      floor = Math.floor

const f = s => {
  const n = s.length
  return s.split('').reduce(g, 0)

  function g(c, _, i, xs) {
    return range(1, n - i + 1).reduce((c, j) => {
      const ss = xs.slice(i, i + j).sort()
      return range(i + 1, n - j + 1).reduce((c, k) => {
        const ys = xs.slice(k, k + j).sort()
        return isEqual(ys, ss) ? c + 1 : c
      }, c)
    }, c)
  }
}

log(f('iwwhrlkpek'))
