/* Implement wildcar pattern matching with support for ? and *
 *
 * ? matches any single character.
 * * matches any sequence of characters (including the empty sequence)
 *
 * isMatch :: String -> RegExString -> Bool
 * isMatch("aa", "a") => false
 * isMatch("ab", "?*") => true
 * isMatch("aa", "*") => true
 * isMatch("aab", "c*a*b") => false
 */

/* Approach:
 * if rs is just *: true
 * if xs is empty : false
 * if match(r, x):
 *  if r is a *: isMatch(rs, xs) || isMatch(rs, (x:xs))
 *  else: isMatch(rs, xs)
 * else: false
 */

const log = console.log
const memo = {}

function isMatch(xs, rs) {
  let v
  rs = reduce(rs)
  const h = hash(xs, rs)
  if (memo[h]) return memo[h]
  if (rs !== '' && rs.split('').every(r => r === '*')) v = true
  else if (xs === '' && rs !== '')
    v = false
  else if (xs === '' && rs === '')
    v = true
  else if (match(xs[0], rs[0])) {
    if (rs[0] === '*') v = isMatch(xs.slice(1), rs.slice(1)) ||
      isMatch(xs.slice(1), rs) || isMatch(xs, rs.slice(1))
    else v = isMatch(xs.slice(1), rs.slice(1))
  } else v = false
  memo[h] = v
  return v

  function hash(xs, ys) {
    return xs + ';' + ys
  }

  function match(x, r) {
    return x === r || r === '*' || (x !== '' && r === '?')
  }
}

log(isMatch('bbbbbbbabbaabbabbbbaaabbabbabaaabbababbbabbbabaaabaab', 'b*b*ab**ba*b**b***bba'))
log(Object.keys(memo).length)

function reduce(xs) {
  return xs.split('')
    .reduce((nrs, r) => {
      const i = nrs.length - 1
      nrs = nrs[i] === '*' && r === '*' ? nrs : nrs + r
      return nrs
    }, '')
}
