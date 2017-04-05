const { List } = require('immutable')
const mt = List()

// tails :: List a -> List (List a)
function tails(xs, ts = List()) {
  if (xs.isEmpty()) return ts.push(mt)
  return tails(xs.rest(), ts.push(xs))
}

// heads :: List a -> List (List a)
function heads(xs) {
  return xs.reduce((hs, x) => {
    const last = hs.last()
    return hs.push(last.push(x))
  }, List().push(mt))
}

module.exports = { heads, tails, mt, List }
