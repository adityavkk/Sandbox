function log(x) {
  console.log(x)
  return x
}

function foldR(f, z, xs) {
  if (xs.length === 0) return z
  return f(xs[0], foldR(f, z, xs.slice(1)))
}

function foldL(f, z, xs) {
  if (xs.length === 0) return z
  return foldL(f, f(z, xs[0]), xs.slice(1))
}

/* purely function, lisp style implementation of cons and lists with delete */

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

/***************************************************************************/

module.exports = {
  foldR,
  foldL,
  cons,
  car,
  cdr,
  cadr,
  uncons,
  list,
  printList,
  log
}
