/* You have k lists of sorted integers. Find the smallest range that includes
 * at least one number from each of the k lists
 *
 * xs = [4, 10, 15, 24, 26]
 * ys = [0, 9, 12, 20]
 * zs = [5, 18, 22, 30]
 *
 * The smallest range here would be [20, 24] as it contains 24 from xs,
 * 20 from ys and 22 from zs
 */

/* Keep track of one elem from each list
 *  Initialized to the first elems of each list
 *  Track the min range of the elements (max - min)
 *  move pointer of min element to next element and repeat until done
 */

function f (...xs) {
  const xs1 = xs.map((x, i) => x.map((e, j) => ({ v: e, l: i, i: j}))),
    limits = xs.map(x => x.length - 1)
  let ys = xs1.map(x => x[0]),
    memo = {}
  while (ys.some(y => y.i !== limits[y.l])) {
    analyze(ys)
    ys = moveMin(ys)
    console.log(ys)
  }
  function analyze (ys) {
    const ys1 = ys.map(y => y.v),
      min = Math.min(...ys1),
      max = Math.max(...ys1)
    memo[min] = max - min
  }
  function moveMin (ys) {
    const sorted = ys.sort((a, b) => a.v - b.v)
    let min = ys[0]
      if (limits[min.l] <= min.i + 1)
        min = xs1[min.l][min.i + 1]
      // bug here!!!
    return [min, ...sorted.slice(1)]
  }
  return Object.keys.reduce((acc, k) => {
    k = +k
    const mk = memo[k]
    if (acc[2] > mk) return [k, k + mk, mk]
  }, [0, 0, Infinity]).slice(0, 2)
}

console.log(f([4, 10, 15, 24, 26], [0, 9, 12, 20], [5, 18, 22, 30]))
