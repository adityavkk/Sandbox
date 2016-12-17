const f = (s1, s2) => {
  ss = s1.split('')
  const mode = ss.reduce((m, c) => {
    console.log(m, c)
    if (m[c]) m[c]++;
    else m[c] = 1;
    return m;
  }, {});
  return ss.map((s, i) => isPerm(ss, i, s2.length, mode, s2))
    .reduce((res, b) => res || b, false);
}

function isPerm(ss, i, j, mode, s2) {
  // mode = Object.assign({}, mode);
  // for(let k = 0; k < j; k++) {}
  return s2.split('').sort() == ss.slice(i, i + j).sort();
}

console.log(f('cab', 'zyxwvuabc'))
console.log()
