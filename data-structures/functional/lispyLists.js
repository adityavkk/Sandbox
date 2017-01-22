/* a purely functional, lisp like linked list implementation with delete */

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
  return foldRight(cons, null, xs)
}

// printList :: [a] -> String
function printList(ll) {
  if (ll === null) return 'null'
  return car(ll) + ' ' + printList(cdr(ll))
}
