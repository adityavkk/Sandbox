/* Given a string str and array of pairs that indicates which indices in the
 * string can be swapped, return the lexicographically largest string that
 * results from doing the allowed swaps. You can swap indices any number of times.
 *
 * Exhaustive Search
 * - Do every possible swap at each step and take the one that returns the largest
 * - f :: String -> [SwapToDo] -> [AllSwap] -> LargestString
 *   - max (call f on each string after performing each swap
 *                 (if swapStr is already seen return larger of currStr or swapStr)
 *                 (with swapToDo = all swaps except for performed swap)) or currStr
 */

const { curry, isEmpty } = require('ramda')

const seen = new Set()
const f = curry((sps, s) => {
  if (isEmpty(sps)) return s
  seen.add(s)
  const ns = sps.map(swap(s))
                .filter(swapped => !seen.has(swapped)),
        nsf = ns.map(f(sps)),
        mx = max(nsf)
  return mx > s ? mx : s
})

const swap = curry((s, [i, j]) => {
  s = s.split('')
  const t = s[i - 1]
  s[i - 1] = s[j - 1]
  s[j - 1] = t
  return s.join('')
})

const max = xs => xs.reduce((a, b) => b > a ? b : a, '')

const log = console.log,
      str1 = 'dznsxamwoj',
      swaps1 = [[1, 2], [3, 4], [6, 5], [8, 10]]
log(f(swaps1, str1) === 'zdsnxamwoj')
