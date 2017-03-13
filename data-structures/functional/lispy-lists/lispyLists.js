/* A purely functional, lisp like linked list implementation with delete
 * There are no pointers, or node objects etc. in this list implementation,
 * */

const { foldR, log } = require('../../utils/utils')

function cons(h, t) {
  return (a) => {
    if (a === 'car') return h
    if (a === 'cdr') return t
  }
}

function car(ll) {
  return ll('car')
}

function cdr(ll) {
  return ll('cdr')
}

function cadr(ll) {
  return car(cdr(ll))
}

function uncons(n, ll) {
  if (ll === null) return null
  if (car(ll) === n) return cdr(ll)
  return cons(car(ll), uncons(n, cdr(ll)))
}

function list(...xs) {
  return foldR(cons, null, xs)
}

// printList :: [a] -> String
function printList(ll) {
  if (ll === null) return 'null'
  return car(ll) + ' ' + printList(cdr(ll))
}

const xs = list(1, 2, 3, 4)
log(printList(xs)) // 1 2 3 4 null
log(cadr(xs)) // 2
