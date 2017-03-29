/* isUnique: Implement an algorithm to determine if a string has all unique
 * characters. What if you cannot use additional data structures.
 */

/* Approaches:
 * - Encode each character by a prime number
 *   - Keep a running product
 *   - fold over string and check if the running product is divisible by the
 *     encoding of the current character
 * O(n)
 *
 * - Use a bit string consisting of the number of chars in the alphabet
 *   - Initialize bit string to all 0s
 *   - fold over string and toggle the corresponding bit
 *     - if already toggled return false
 *     - else true
 * O(n)
 *
 * - Sort the string
 *   - fold over sorted string and if there are 2 of the same charcs next to
 *     each other then string is not unique
 * O(n log n) without any additional data structures
 * O(n) with an array - since sorting a string with a finite alphabet can be done
 */

const log          = console.log
const { assignIn } = require('lodash')
const BN           = require('bignumber.js')
assignIn(global, require('ramda'))

// Prime number method
// f :: String -> Bool
const f = cs => {
  const ps = sieve(26)
  return reduceRight((c, [prod, r]) => {
    if (!r) return [prod, r]
    const p = ps[idx(c)]
    if (prod.mod(p).equals(0)) return [prod, false]
    return [prod.times(p), r]
  }, [new BN(1), true], cs.split(''))[1]
}

log(f('abcdefghijklmnopcqrst')) // => false

// sieve :: Int -> [Int] -> [Int]
function sieve(n, ps = [2]) {
  if (n === 1) return ps
  const p = ps[0]
  return sieve(n - 1, prepend(nextP(p, ps), ps))
}

// nextP :: Int -> [Int] -> Int
function nextP(n, ps) {
  if (any(p => n % p === 0, ps)) return nextP(n + 1, ps)
  else return n
}

// Bit string method
// f :: String -> Bool
const g = cs => {
  const bs = strMult('0', 26)
  return reduceRight((c, [bm, r]) => {
    const i = idx(c)
    if (r === false) return [bm, r]
    if (bm[i] === '1') return [bm, false]
    return [strUpdate(i, bm, '1'), r]
  }, [bs, true], cs.split(''))[1]
}

// strMult :: String -> Int -> String
function strMult(s, n) {
  return reduceRight((_, res) => res + s, '', range(0, n))
}

// strUpdate :: Int -> String -> Char -> String
function strUpdate(i, cs, c) {
  return slice(0, i, cs) + c + slice(i + 1, Infinity, cs)
}

// idx :: Char -> Int
function idx(c) {
  return c.charCodeAt() - 97
}

// log(g('abcdefghijklmnopqrstuvwxyza')) // => true
