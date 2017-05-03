/* Given two words (start and end), and a dictionary, find the length of
 * shortest transformation sequence from start to end, such that:
    * You must change exactly one character in every transformation
    * Each intermediate word must exist in the dictionary
 *
 * start = "hit"
 * end = "cog"
 * dict = ["hot","dot","dog","lot","log"]
 * return 5
 * namely, "hit" -> "hot" -> "dot" -> "dog" -> "cog"
 */

/* seen = set {}
 * f :: Word -> Word -> Int
 * memoize on start
 * add start to seen
 * if start is one away from end: 1
 * Change word into all possible changes in dict that haven't already been seen
 * take min of that and add 1 to it
 */

/* @flow */

const seen = new Set(),
      memo = {},
      { minBy, head } = require('ramda')

const f = (s /*: string */, e /*: string */, d) /*: [number, string[][]] */=> {
  if (memo[s]) return memo[s]
  seen.add(s)
  let v
  if (oneAway(s, e)) v = [2, [[e, s]]]
  else {
    const [c, xs] = allChanges(s, d).map(x => f(x, e, d))
                                    .reduce(minBy(head), [Infinity, []])
    v = [c + 1, xs.map(x => x.concat(s))]
  }
  memo[s] = v
  return v
}

function oneAway(x, y) /*: boolean */ {
  return x.length === y.length &&
         y.split('').reduce((c, y1, i) => x[i] === y1 ? c : c + 1, 0) === 1
}

function allChanges(s, d /*: string[] */) /*: string[] */ {
  return d.filter(w => oneAway(s, w) && !seen.has(w))
}

const ys = ["hot","dot","dog","lot","log"]
