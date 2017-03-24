/*
   You're given a list of words, choose a word from it and you may remove a
   letter from it if there's another word in the list that matches the word
   with the character removed. You can keep doing this as long as each successive
   character removal is performed from the resulting string after the removal

   return the length of the longest such string chain
*/

// xs = {"a", "b", "ba", "bca", "bda", "bdca"} => 4

// Approach:
// -> Sort array by length of string in descending order
// -> if all same length: return 0
// -> for all longest w's
//    -> check with each w of length w - 1
//    -> max (f (xs without words of length w and w - 1 that dont match)) + 1

const log = console.log
const memo = {
  '' : 0
}

// f :: [String] -> Int
const f = xs => {
  if(memo[xs.toString()]) return memo[xs.toString()]
  let v
  if (xs.every(x => x.length === xs[0].length)) v = 1
  else {
    const [ls, rxs] = longest(xs)
    v = Math.max(...ls.map(l => f(rxs.filter(x => x.length < l.length - 1 ||
                                      oneAway(l, x))))) + 1
  }
  memo[xs.toString()] = v
  return v
}

// longest :: [String] -> ([String], [String])
function longest(xs) {
  const lsort = xs.sort((a, b) => b.length - a.length),
    lst = lsort.filter(x => x.length === lsort[0].length)
  return [lst, lsort.slice(lst.length)]
}

// oneAway :: String -> String -> Bool
function oneAway(x, y) {
  const set = x.split('').reduce((s, a) => s.add(a), new Set())
  return y.split('').every(a => set.has(a))
}

log(f(["a", "b", "ba", "bca", "bda", "bdca", "bdcaf"]))
