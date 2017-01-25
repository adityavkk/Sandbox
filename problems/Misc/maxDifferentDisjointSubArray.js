/* Given an array of integers. Find two disjoint contiguous sub-arrays such that
 * the absolute difference between the sum of two sub-arrays is maximum
 * eg- [2 -1 -2 1 -4 2 8] => [-1 -2 1 -4] and [2 8], max diff = 16
 */

const max = Math.max,
  abs = Math.abs,
  sum = xs => xs.reduce((a, b) => a + b, 0),
  log = console.log

const f = xs => {
  const gl = g(xs),
    gr = mR(xs),
    hl = mxL(xs),
    hr = mxL(xs);

  function f1(x, i) {
    const gls = sum(gl[i]),
      grs = sum(gr[i]),
      hls = sum(hl[i]),
      hrs = sum(hr[i])
    return abs(gls - hrs) > abs(grs - hls) ? [gl[i], hr[i]] : [gr[i], hl[i]]
  }

  function g(xs) {
    function GNode(cmXs, cm, cmi, rT, rTS) {
      this.cmXs = cmXs;
      this.cm = cm;
      this.cmi = cmi;
      this.rT = rT;
      this.rTs = rTS
    }

    function gnode(...args) {
      return new GNode(...args)
    }
    return xs.reduce((t, x, i) => {
      if (t.length === 0) return [gnode([x], x, i, [], 0)];
      const lastE = t[t.length - 1],
        oldSum = lastE.cm,
        rTs = lastE.rTs
      if (x < lastE.cm + x)
        return [...t, gnode([x], x, i, [x], x)];
      if (lastE.cmi + 1 === i) {
        if (oldSum + x > 0 && rTs + x > 0)
          return [...t, gnode(lastE.cmXs, lastE.cm, lastE.cmi, [], 0)];
        if (oldSum + x < oldSum)
          return [...t, gnode([...lastE.cmXs, x], lastE.cm + x, i, [...lastE.cmXs, x], lastE.cm + x)];
      }
      if (rTs + x < oldSum)
        return [...t, gnode([...lastE.rT, x], lastE.rTs + x, i, [...lastE.rT, x], lastE.rTs + x)]
      if (oldSum + x < 0)
        return [...t, gnode(lastE.cmXs, lastE.cm, lastE.cmi, [...lastE.rT, x], lastE.rTs + x)];
      if (rTs + x > 0) return [...t, gnode(lastE.cmXs, lastE.cm, lastE.cmi, [], 0)];
      if (rTs + x < 0)
        return [...t, gnode(lastE.cmXs, lastE.cm, lastE.cmi, [...lastE.rT, x], lastE.rTs + x)];
    }, []).map(x => x.cmXs);
  }

  function mxR(xs) {
    return reverse(g(xs).map(x => x.map(y => -y)))
  }

  function mR(xs) {
    return reverse(g(reverse(xs)))
  }

  function mxL(xs) {
    return g(xs.map(x => -x)).map(x => x.map(y => -y))
  }

  function reverse(xs) {
    return xs.slice().reverse()
  }
  const rs = xs.map(f1)
  return rs.reduce((maxPair, r) => {
    const lastMaxDiff = abs(sum(maxPair[0]) - sum(maxPair[1])),
      currMaxDiff = abs(sum(r[0]) - sum(r[1]))
    return currMaxDiff > lastMaxDiff ? r : maxPair
  }, [[],[]])
}

log(f([2, -1, -2, 1, -4, 2, 8]))
