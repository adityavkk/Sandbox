const f = xs => {
  const t = xs.slice(0, 3),
    rest = xs.slice(3),
    s = Math.min(...t),
    m = Math.max(...t)
  return rest.reduce((z, x) => {
    const [s, m, r] = z
    if (r) return z
    if (x < m && x > s) return [s, m, true]
    if (x < s) return [x, m, r]
    if (x > m) return [s, x, r]
    if (x == m || x == s) return z
  }, [s, m, false])[2]
}

console.log(f([9, 11, 8, 9, 10, 7, 9]))
console.log(f([1, 2, 3, 4, 5, 6, 7, 8, 9, 6, 10]))
console.log(f([1,0,1,-4,-3]))
