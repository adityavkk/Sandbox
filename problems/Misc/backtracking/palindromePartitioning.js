/* Given a string s, partition s such that every string of the partition is a
 * palindrome.
 *
 * Return all possible palindrome partioning of s
 *
 * s = "aab"
 * return [[a, a, b], [aa, b]]
 */

/* f :: String -> [[String]]
 * - Look at all possible first cuts which are palendromes
 *   and recursively call f on rest - O(2^n) can memoize
 *
 * heads x -> all possible first cuts
 * zip heads tails -> get all [head, tail] pairs
 * fzHT = filter headIsPlaindrome from zipHeadTails
 * map f over the tail of each fzHT and concat it with the corresponding head
 */
const { zip, init, tail } = require('ramda')
const { heads, tails, flatten } = require('../../../utils/arrayUtils')
const log = console.log

const f = (s) => {
  if (!Array.isArray(s)) s = s.split('')
  if (!s.length) return [[]]
  if (s.length === 1) return [[s]]
  const hs = init(tail(heads(s))),
    ts = init(tail(tails(s))),
    fZHT = zip(hs, ts).filter(([h, t]) => isPalindrome(h))
  return fZHT.map(([h, t]) => [h].concat(flatten(f(t)))).map(join)
}

function isPalindrome(cs) {
  return cs.join() === cs.reverse().join()
}

function join(xs) {
  return xs.map(y => Array.isArray(y) ? y.join('') : y)
}

log(f('aab'))
