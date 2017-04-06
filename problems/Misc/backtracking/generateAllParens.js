/* Given n pairs of parentheses, write a function to generate all combinations
 * of well-formed parentheses of length 2*n.
 * For example, given n = 3, a solution set is:
 * "((()))", "(()())", "(())()", "()(())", "()()()"
 */

/* f :: NumOfPairs -> NumOpen -> NumClosed -> [ParenStrings]
 * add :: String -> [String] -> [String]
 * Options at each state [addOpen, addClose, nothing]:
 *  State Variables:
 *  Total num, : n
 *  open braces added till now, : o
 *  closed braces added till now : c
 *
 *  memoize on state variables
 *
 * - if o + c = 2 * n or n is 0: return ['']
 * - if o < n:
 *    if c < o:
 *      return (add '[' (f updatedState) ++ add ']' (f updatedState))
 *    return add '['
 * - if c < n:
 *    return add ']'
 */
const { map, prepend, compose } = require('ramda')
const log = console.log

// Can memoize
const f = (n, o = 0, c = 0) => {
  if (o + c === 2 * n) return ['']
    if (o < n) {
      if (c < o) return prependOpen(f(n, o + 1, c))
                        .concat(prependClose(f(n, o, c + 1)))
      return prependOpen(f(n, o + 1, c))
    }
    return prependClose(f(n, o, c + 1))
}

const prependOpen = map(compose(x => x.join(''), prepend('[')))
const prependClose = map(compose(x => x.join(''), prepend(']')))

log(f(3))
