/* Given two strings s and t, determine if they're isomorphic. Two strings are
 * said to be isomorphic if the characters in s can be replaced to get t.
 *
 * For example "egg" and "add" are isomorphic, "foo" and "bar" are not.
 */

/* f :: String1 -> String2 -> Bool
 * Reduce over s1 and match s with corresponding t in s2 in a hashmap
 *  - if s already exists in hashmap: check if t matches key in hashmap for s
 *  - if it doesn't match : return false
 */

const f = (s, t) => {
  return s.length === t.length &&
         s.split('').reduce(([h, b], c, i) => {
            if (!b || h[c] && t[i] !== h[c]) return [h, false]
            if (!h[c]) h[c] = t[i]
            return [h, b]
          }, [{}, true])[1]
}

const log = console.log
log(f('eoggo', 'aiddi'))
log(f('foo', 'bar'))
