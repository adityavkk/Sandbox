const log = console.log
  // f :: String -> Int
const f = e => {
  let [n, s, e1] = tillSymbol(e)
  if (num(n) && e1 === '')
    return +n
  if (num(n))
    return ev(n, s, e1)
  if (n === '(') {
    [n, s, e2] = tillClose(e1)
    return ev(f(n), s, e2)
  }
}

// ev :: String -> Sym -> String -> Int
function ev(n, s, e) {
  if (s === '+') return +n + f(e)
  else {
    let [n1, s1, e1] = tillSymbol(e)
    if(s1 === undefined) return +n1 * +n
    if (n1 === '(') {
      let [n2, s2, e2] = tillClose(e1)
      if(e2 === '') return +n * f(n2)
      return ev(+n * f(n2), s2, e2)
    }
    return ev(+n1 * +n, s1, e1)
  }
}

//num :: String -> Bool
function num(s) {
  return /\d*/.test(s)
}

//tillSymbol :: String -> (String, Sym, String)
function tillSymbol(s) {
  if (s[0] === '(') return ['(', '', s.slice(1)]
  let n = /\d*/.exec(s)[0],
    sym = s[n.length];
  s = s.slice(n.length + 1)
  return [n[0], sym, s]
}

//tillClose :: String -> (String, Sym, String)
function tillClose(s, c = 0, r = '') {
  if (c < 0) return [r.slice(0, r.length - 1), s[0], s.slice(1)]
  const n = s[0]
  if (n === '(') c++
    if (n === ')') c--
      return tillClose(s.slice(1), c, r += n)
}

console.log(f('4*(2*3)+1')) // 25
