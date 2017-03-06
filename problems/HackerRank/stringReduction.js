// Given a string consisting of letters, 'a', 'b' and 'c', we can perform the
// following operation:

// Take any two adjacent distinct characters and replace them with the third
// character. For example, if 'a' and 'b' are adjacent, they can replaced by 'c'.

// Find the smallest string which we can obtain by applying this operation repeatedly.

// cab => 2
// bcab => 1
// ccccc => 5

const h = cs => {
  
}

const memo = {}
const f = cs => {
  const csSorted = strSort(cs)
  if (memo[csSorted]) return memo[csSorted]
  const s = new Set(cs)
  let v
  if (s.size == 1) v = cs.length
  else v = Math.min(...allChanges(cs).map(c => f(strSort(c))))
  memo[csSorted] = v
  return v
}

function allChanges(cs) {
  return cs.split('')
    .reduce((xs, c, i) => {
      const c1 = cs[i + 1]
      if (i !== cs.length - 1 && c !== c1)
        return xs.concat(cs.slice(0, i) + other(c, c1) + cs.slice(i + 2))
      else return xs
    }, [])
}

function strSort(cs) {
  return cs.split('').sort().join('')
}

function other(a, b) {
  return "abc".split('').filter(c => c !== a && c !== b)[0]
}

/************************************************************************************/

function perms(cs) {
  if(cs.length === 1) return [cs[0]]
  cs = typeof cs === 'string' ? cs.split('') : cs
  return concatMap(g, cs).map(x => x.join(''))
}

function g(c, i, cs) {
  let x =  perms(cs.slice(0, i).concat(cs.slice(i + 1))).map(p => [c].concat(p))
  return x
}

function concatMap(f, xs) {
  return flatten(xs.map(f))
}

function flatten(ys) {
  return ys.reduce((zs, y) => zs.concat(y), [])
}

const log = console.log
log(perms("ab"))
log(f("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccccccccc"))
