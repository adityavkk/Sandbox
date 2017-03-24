/* In processing a document, you have mistakenly removed all the spaces and
 * capitalizations. Luckily, you have a dictionary of most words you will find
 * in the string, however, there are somethings like proper nouns that you wont
 * find in the dictionary.
 *
 * Design an algorithm to find the optimal way of "unconcatenating" a sequence
 * of words. Optimal is defined to be the parsing which minimizes the number of
 * unrecoginized sequences of characters.
 *
 * String: jillandjackaresiblings
 * Parsed: JILL and JACK are siblings
 */

const log = console.log
const dict = new Set(['ill', 'and', 'are', 'siblings', 'bling', 'blings', 'land'])
const memo = {}

// f :: String -> String
const f = s => {
  let v
  if (memo[s]) return memo[s]
  if (!s.length) v = s
  else if (s.length === 1) {
    if (dict.has(s)) v = s
    else v = s.toUpperCase()
  }
  else v = substrings(s).map(g).reduce(optimal)
  memo[s] = v
  return v
}

// substrings :: String -> [(String, String)]
function substrings(s) {
  return dropFirstLast(s.split('').reduce((z, c) => {
    const [ss, rest] = z[z.length - 1]
    return z.concat([
      [ss + c, rest.slice(1)]
    ])
  }, [
    ['', s]
  ]))
}

// g :: (String, String) -> String
function g([ss, rest]) {
  const s = f(rest)
  if (dict.has(ss)) return ss + ' ' + s
  else return ss.toUpperCase() + ' ' + s
}

//optimal :: (String, String) -> String
function optimal(cm, cs) {
  return capsCount(cs) < capsCount(cm) ? cs : cm
}

// capsCount :: String -> Int
function capsCount(s) {
  return s.split(' ').reduce((c, w) => {
    return w.toUpperCase() === w ? c + 1 : c
  }, 0)
}

function dropFirstLast(xs) {
  return xs.slice(1)
}

log(f('jackandjillaresiblings'))
