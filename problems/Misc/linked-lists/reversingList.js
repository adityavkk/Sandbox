/* @flow */

/*:: type list = null | 1 */

const f = (xs /*:: : number[] */) /*:: : number */ => {
  return xs.reduce((s, x) => s + x, 0)
}

const g = (ys : (?number)[]) => {
  return ys.reduce((s, x) => s + x, 0)
}

const log = console.log
log(f([1, 3, 3, 4, 5]))
log(g([null, null, 3, 4]))
log(5)
log(3)
log(7)
log(8)
log(8)
