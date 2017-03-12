// Write a function that takes a regex string of the form:
// - a-z
// - a*
// - . or .*
// and a string and returns true if the whole string matches the pattern
// or false if it doesn't
//
// Example: a*ab, aaab => true
//          a*cab, cab => true
//          .*c, adsfc => true

const log = console.log
const f = (r, t) => {
  if (r === '')
    if (t === '') return true
    else return false
  else if (t === '') return false
  if (r[1] === '*' && m(r[0], t[0])) {
    const ss = []
    for (let i = 1; i < t.length; i++) {
      if (t[i - 1] !== r[0]) break
      ss.push(t.slice(i))
    }
    r = !r.slice(2) ? r[0] : r.slice(2)
    return ss.map(s => f(r, s))
      .some(b => b)
  }
  if (m(r[0], t[0])) return f(r.slice(1), t.slice(1))
  return false
}

function m(r, t) {
  return r === t || r === '.'
}

console.log(f('a*b*c', 'aaabd'))
