function equal(input) {
  let memo = {}
  const f = xs => {
    log(xs)
    let v, k = xs.sort((a, b) => a - b).toString()
    if (memo[k]) return memo[k]
    if (same(xs)) v = 0
    else {
      const os = flatten(xs.map(allOs))
        .reduce((os, o) => {
          if (os[1]) return os
          if (oneAway(o)) return [
            [o], true
          ]
          os[0].push(o)
          return [os[0], os[1]]
        }, [
          [], false
        ])[0]
      v = Math.min(...os.map(o => f(o) + 1))
    }
    memo[k] = v
    return v
  }

  function allOs(_, i, xs) {
    const o1 = xs.map((x, j) => j !== i ? x + 1 : x),
      o2 = xs.map((x, j) => j !== i ? x + 2 : x),
      o3 = xs.map((x, j) => j !== i ? x + 5 : x)
    return [o1, o2, o3]
      .filter(o => {
        return o.some((x, j) => j !== i && x <= xs[i])
      })
  }


  function oneAway(xs) {
    const x0 = xs[0],
      x1 = xs[1]
    x1 = i === 0 ? xs[1] : xs[0]
    return xs.every((x, j) => i === j || (xi === x && xi <= x))
  }


  // const xs = input.split('\n')
  // .filter((_, i) => i !== 0 && (i === 2 || i % 2 === 0))
  // .map(x => x.split(' ').map(x => +x))
  // return xs.forEach(x => {
  // console.log(f(x))
  // memo = {}
  // })
  return f([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
}

const log = console.log

function same(xs) {
  return xs.every(x => x === xs[0])
}

function flatten(xs) {
  return xs.reduce((y, x) => y.concat(x), [])
}

const f = xs => {
  
}

log(f([2, 2, 3, 7], 0))
