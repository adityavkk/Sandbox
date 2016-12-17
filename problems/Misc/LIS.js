// LIS Problem on arrays of number
const l = (j, xs) => {
  if (j === 0) return 1;
  const allLs = xs.slice(0, j).map((_, i) => {
    const xi = xs[i],
      xj = xs[j]
    return xi < xj ? l(i, xs) + 1 : l(i, xs)
  })
  return Math.max(...allLs)
}

const lis = xs => Math.max(...(xs.map((_, j, ns) => l(j, ns))))

console.log(lis([-5, 1, 2, 0, 1, 2, -1, 0, 1, 2, 3, 4]))
