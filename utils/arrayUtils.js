const { map, curry, last, tail } = require('ramda')
const log = console.log

const flatMap = curry((fn, xs) => {
  return flatten(map(fn, xs))
})

function flatten(xs) {
  return xs.reduce((flat, x) => {
    return flat.concat(x)
  }, [])
}

function heads(xs) {
  return xs.reduce((hs, x) => {
    const l = last(hs)
    return hs.concat([l.concat(x)])
  }, [[]])
}

function tails(xs) {
  if (xs.length === 0) return [[]]
  return [xs].concat(tails(tail(xs)))
}

module.exports = { flatMap, flatten, heads, tails }
