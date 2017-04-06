/* Given a digit string, return all possible letter combinations that the number
 * could represent.
 *
 * ns = "23"
 * Output = [ ad, ae, af, bd, be, bf, cd, ce, cf ]
 */

/* f     :: DigitString -> [String]
 * chars :: Digit -> [Char]
 * combine :: StringsToBeCombined -> CombinedStrings
 *
 * - combine (map chars ds:: [[Chars]])
 *
 * combine xxs:
 * if xxs is empty : [[]
 * if xxs is length 1: xs.split('')
 * otherwise: concatMap (\ x -> map (x:) (combine xxs)) xs
 */

const { map, curry } = require('ramda')
const log = console.log

const f = (digitStr) => {
  return combine(digitStr.split('').map(chars)).map(x => x.join(''))
}

const cons = curry((x, xs) => {
  return [x].concat(xs)
})

const flatMap = curry((fn, xs) => {
  return flatten(map(fn, xs))
  function flatten(xs) {
    return xs.reduce((flat, x) => {
      return flat.concat(x)
    }, [])
  }
})

// combine :: [String] -> [String]
function combine(xxs) {
  if (xxs.length === 0) return [[]]
  const xs = xxs[0]
  if (xxs.length === 1) return xs.split('')
  return flatMap(x => map(cons(x), combine(xxs.slice(1))), xs)
}

function chars(d) {
  switch (d) {
    case '1':
      return '1'
    case '0':
      return '0'
    case '2':
      return 'abc'
    case '3':
      return 'def'
    case '4':
      return 'ghi'
    case '5':
      return 'jkl'
    default:
      return 'xyz'
  }
}

log(f('234'))
