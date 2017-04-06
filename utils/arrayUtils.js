const { map, curry } = require('ramda')

const flatMap = curry((fn, xs) => {
  return flatten(map(fn, xs))
})

function flatten(xs) {
  return xs.reduce((flat, x) => {
    return flat.concat(x)
  }, [])
}

module.exports = { flatMap, flatten }
