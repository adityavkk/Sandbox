const { seive, randPrime } = require('./numberUtils')
const { sample } = require('lodash')

/* eslint no-shadow: "off" */

// isPrefix :: PotentialPrefix -> String -> Bool
function isPrefix(p, s) {
  return p.split('').every((c, i) => {
    return c === s[i]
  })
}

// isSubstring :: PotentialSubstring -> String -> Maybe Index
// Implementation of Rabin-Karp O(m + n) with rolling hash
function isSubstring(p, s) {
  const pl = p.length,
    prime = 3,
    pHash = rollingHash(p, prime, pl),
    hash = rollingHash(s.slice(0, pl), prime, pl),

    [found, idx] = s.slice(1).split('').reduce(([found, idx, h], c, i) => {
      if (found) return [found, idx, h]

      const subS = s.slice(i + 1, i + pl + 1),
        prevC = s[i],
        rh = rollingHash(subS, prime, pl, h, prevC)

      return rh === pHash &&
             subS === p ? [true, i + 1, rh] : [false, idx, rh]
    }, [false, 0, hash])

    return found ? idx : undefined

  function rollingHash(x, prime, pl, ph, prevC) {
    if (ph) {
        const r = ((ph - prevC.charCodeAt()) / prime) + x[x.length - 1].charCodeAt() * Math.pow(prime, pl - 1)
        return r
    } else {
      return x.split('').reduce((h, c, i) => {
        return h + c.charCodeAt() * Math.pow(prime, i)
      }, 0)
    }
  }
}

module.exports = {
  isPrefix,
  isSubstring,

}
