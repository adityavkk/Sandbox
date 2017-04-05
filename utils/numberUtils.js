const { prepend, any } = require('ramda')
const { sample } = require('lodash')

/* eslint no-shadow: "off" */

// sieve :: Int -> [Int] -> [Int]
function sieve(n, ps = [2]) {
  if (n === 1) return ps
  const p = ps[0]
  return sieve(n - 1, prepend(nextP(p, ps), ps))

  // nextP :: Int -> [Int] -> Int
  function nextP(n, ps) {
    if (any(p => n % p === 0, ps)) return nextP(n + 1, ps)
    else return n
  }
}

function randPrime(n = 5) {
  return sample(sieve(n))
}


module.exports = { sieve, randPrime }
