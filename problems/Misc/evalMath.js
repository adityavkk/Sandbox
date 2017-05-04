/* Given an arithmetic equation consisting of positive integers and +, -, *, and /
 * but not (), compute the result.
 */

/* 2*3+5/6*3+15 = 23.5
 * PEMDAS
 * ts = split s on -, map split on +, map split on /, map split on *
 * return eval(ts)
 *
 * eval :: [[[[Float]]]] -> Float
 * evalS = eval (-) . (map evalA)
 * evalA = eval (+) . (map evalD)
 * evalD = eval (/) . (map evalM)
 * evalM = eval (*)
 */

const { map, compose, curry } = require('ramda')
const log = console.log

const evalMath = xs => {
  const ts = tokenize(xs),
        ev = curry((fn, xs) => xs.reduce((r, x) => fn(r, Number(x)))),
        evalD = ev((a, b) => a / b),
        evalM = compose(ev((a, b) => a * b), map(evalD)),
        evalA = compose(ev((a, b) => a + b), map(evalM)),
        evalS = compose(ev((a, b) => a - b), map(evalA))
  return evalS(ts)
}

function tokenize(xs) {
  return xs.split('-')
           .map(ys => ys.split('+')
                        .map(ys => ys.split('*')
                                     .map(ys => ys.split('/'))))
}

log(JSON.stringify(evalMath('2*3+5/6*3+15')))
