/* lcs "132535365" "123456789" => "12356"
 * "132892" "123892"
 * [1, 0], [13, 2], [132, 5], [138, 3], [1389, 4], [13892, 5]
 * ls = map f over a, where f a -> [lcs ending at that index, smallest index of b in bs]
 * pick longest l from ls
 *
 * f a 0 = if a in bs then [a, j] else ["", bs.length - 1]
 * f a i = max over all k less than i (f a k): if b in bs s.t j > (f a k)1 & b == a
 * */
const log = console.log;

let memo = {}
const lcs = (as, bs) => {
  if (as === bs) return as;
  as = as.split('');
  bs = bs.split('');
  const ls = as.map(f)

  function f(a, i) {
    const key = a + ',' + i,
      val = memo[key];
    let y;
    const ks = range(0, i).map(k => f(as[k], k));
    if (val) return val;
    if (i === 0) y = z(a, bs);
    else
      y = ks.reduce((r, k) => {
        const next = g(a, k)
        if (next[0].length > r[0].length && next[0][next[0].length - 1] === a) return next;
        return r;
      }, z(a, bs))
    memo[key] = y;
    return y;
  }

  memo = {};
  return ls.reduce((r, l) => {
    if (l[0].length > r.length) return l[0]
    return r
  }, '')

  function g(a, k) {
    let c = 0;
    return bs.reduce((r, b, j) => {
      if (j > r[1] && b === a && c < 1) {
        c++;
        return [r[0] + b, j];
      }
      return r;
    }, k)
  }

  function z(x, ys) {
    return ys.reduce((r, y, j) => {
      if (y === x && j < r[1]) return [y, j]
      return r
    }, ['', ys.length - 1])
  }

  function range(a, b) {
    return new Array(b - a).fill(0).map((_, i) => a + i)
  }
}

const LCS = (a, b) => {
  const x = lcs(a, b);
  const y = lcs(b, a);
  return x.length > y.length ? x : y;
}

// log(lcs('anothertest', 'notatest'))
log(LCS('notatest', 'anothertest'))
