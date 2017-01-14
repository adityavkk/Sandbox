// LIS Problem on arrays of number
const log = console.log
const l = (j, xs) => {
  if (j === 0) return 1;
  const allLs = xs.slice(0, j).map((_, i) => {
    const xi = xs[i],
      xj = xs[j]
    return xi < xj ? l(i, xs) + 1 : 0
  })
  return Math.max(...allLs, 1)
}

const lis = xs => Math.max(...((xs.map((_, j) => l(j, xs)))))

console.log(lis([7, 2, 4, 8, 1, 9, 6, 7, 8]))
