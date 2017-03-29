/* Check Permutation: Given two strings, write a method to decide if one
 * is a permutation of the other */

/* Approaches:
 * 1. Sort each and check if they're equal to each other
 *    - O (n log n) if using traditional sorting
 * 2. Fold s1 into frequency map and check it against freq. map of s2
 *    - O (n)
 */

const log = console.log
const R = require('ramda')

const f = (xs, ys) => {
  const freq1 = freq(xs),
    freq2 = freq(ys)
  return hmEqual(freq1, freq2)
}

function freq(xs) {
  return R.reduceRight((x, hm) => {
    if(hm[x]) hm[x] = hm[x] + 1
    else hm[x] = 1
    return hm
  }, {}, xs)
}

function hmEqual(x, y) {
  const ks1 = Object.keys(x),
    ks2 = Object.keys(y)
  return ks1.every(k => x[k] === y[k]) && ks1.length === ks2.length
}

log(f('abbcif', 'cabbie')) // => false
