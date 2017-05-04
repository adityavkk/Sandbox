/* Write a method to shuffle a deck of cards. It must be a perfect shuffle - in
 * other words, each of the 52! permutations of the deck has to be equally likely.
 * Assume that you are given a random number generator which is perfect.
 */

/*
 * shuffle :: [a] -> [a]
 * for x, i in enum(xs):
 *    r = random between 0 and i (inclusive)
 *    swap xs[i] with xs[r]
 */

/* @flow */

const log = console.log
const { random, range } = require('lodash')

const shuffle = (cs /*: any[] */)/*: any[] */ => {
  cs = cs.slice()
  cs.forEach((_, i) => {
    const r = random(0, i)
    let t = cs[r]
    cs[r] = cs[i]
    cs[i] = t
  })
  return cs
}

log(shuffle(range(0, 52)))

