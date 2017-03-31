const log = console.log
const f = rs => {
  const srs = rs.sort(([s, e], [s1, e1]) => e - e1)
  return srs.slice(1).reduce((cs, [s, e]) => {
    const [s1, e1] = cs[0]
    if (e1 < s) return [[s, e]].concat(cs)
    return cs
  }, [srs[0]])
}


log(f([[0, 5], [2, 8], [4, 6], [10, 11], [4, 8], [100, 1002], [50, 66]]))
