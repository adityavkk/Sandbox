/*
Given a collection of integers that might contain duplicates, S, return all
possible subsets.

Elements in a subset must be in non-descending order.
The solution set must not contain dublicate subsets.
The subsets must be sorted lexicographically
*/

/* xs = [1, 2, 2]
 * => [[], [1], [1, 2], [1, 2, 2], [2], [2, 2]]
 */

/* Run lexicographical subsets and hash each subset and don't include subset if its in hash */

const g = xs => {
  xs = xs.sort((a, b) => a - b)
  const seen = new Set()
  return removeDups(f(xs))

  function f(xs) {
    if (xs.length === 0) return [[]]
      const fxs = f(xs.slice(1)),
        tailFxs = fxs.slice(1),
        x = xs[0],
      withX = fxs.map(ss => [x].concat(ss))
    return [[]].concat(withX).concat(tailFxs)
  }

  function removeDups(xxs) {
    const hash = ys => ys.toString()
    return xxs.reduce((nxxs, xs) => {
      const h = hash(xs)
      if (seen.has(h)) return nxxs
      seen.add(h)
      nxxs.push(xs)
      return nxxs
    }, [])
  }
}

console.log(g([1, 2, 2]))
