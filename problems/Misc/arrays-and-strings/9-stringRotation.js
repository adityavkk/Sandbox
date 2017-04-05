/* Assume you have a method isSubstring which checks if one word is a substring of
 * another. Given two strings, s1 and s2, write code to check if s2 is a rotation
 * of s1 using only one call to isSubstring (eg., "waterbottle" is a rotation of
 * "erbottlewat")
 *
 * Approach:
 * ba = ab <- string rotation, if original string is ab
 * ab must be a substring of ba ++ ba must be a substring for ba to be arotation
 *
 * - Linear scan of (tails s1) to find prefix of s2
 *   - a := tail
 *   - b := head
 * - check if a ++ b isSubstring b ++ a ++ b ++ a
 */

/* eslint no-undef: "off",  no-shadow: "off" */

const log = console.log
const { isPrefix, isSubstring } = require('../../../utils/stringUtils')
const { assignIn } = require('lodash')
assignIn(global, require('../../../utils/listUtils'))

const f = (s1, s2) => {
  const l1 = List(s1),
    l2 = List(s2),
    stringify = t => t.toJS().join(''),
    hs = heads(l1).map(stringify),
    ts = tails(l1).map(stringify),
    hts = hs.zip(ts),

    [a, b] = hts.reduce(([a, b, found], [h, t]) => {
      if (found) return [a, b, found]
      return isPrefix(t, s2) ? [t, h, true] : [a, b, found]
    }, ['', '', false])

  return !!isSubstring(s2, b + a + b + a)
}

const xs = List([1, 2, 3, 4])
log(f('erbottlewat', 'waterbottle'))
