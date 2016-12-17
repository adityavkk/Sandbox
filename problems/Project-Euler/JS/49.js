const eratosthenes = (min, max) => {
  const ns = new Array(max + 1).fill(true);
  ns.forEach((n, i, arr) => {
    if (i < 2) return;
    if (n) {
      for (let j = 2 * i; j < ns.length; j += i) {
        ns[j] = false;
      }
    }
  })
  const primes = ns.map((n, i) => ({
      value: i,
      isPrime: n
    }))
    .filter(n => n.isPrime)
    .map(n => n.value)
    .filter(n => n >= min)
    .slice(2)
  return primes
}

const nSort = n => {
  return n.toString().split('').sort().join('')
}

const filterIsPerm = ns => {
  return ns.reduce((map, n) => {
    let sorted = nSort(n)
    if (map[sorted]) {
      map[sorted].push(n)
    } else {
      map[sorted] = [n]
    }
    return map;
  }, new Map())
}

const pairwise = xs => {
  if (xs.length < 2) return [];
  const head = xs[0],
    tail = xs.slice(1),
    headPairs = tail.map(x => [head, x]);
  return headPairs.concat(pairwise(tail));
}

const flatten = (xs) => {
  let ys = [];
  xs.forEach(x => {
    ys = ys.concat(x)
  })
  return ys;
}

const triples = xs => {
  if (xs.length < 3) return [];
  const pairs = pairwise(xs),
    triplets = flatten(xs.map(x => {
      return pairs
        .filter(p => !p.some(e => e === x))
        .map(p => [x].concat(p))
    })),
    uniquenessSet = new Set();
  return triplets.filter(t => {
      const sortString = t.sort((a, b) => a - b).join();
      if (uniquenessSet.has(sortString)) return false;
      uniquenessSet.add(sortString);
      return true;
    })
    .map(t => t.sort((a, b) => a - b))
}

const constantDiff = ns => {
  // return array of 3 elements from ns that have a constant difference
  // if none exist return empty array/false
  const isConstDiff = ns => (ns[2] - ns[1]) - (ns[1] - ns[0]) === 0
  return ns.filter(n => {
    if (n.length === 3) return isConstDiff(n);
    return false;
  })
}

const allFourDigitPrimes = eratosthenes(1000, 10000),
  permutations = filterIsPerm(allFourDigitPrimes);

const primePermutations = perms => {
  let res = [];
  for (let p in perms) {
    const ns = perms[p],
      triplesNs = triples(ns),
      constDiff = constantDiff(triplesNs)
    if (constDiff.length > 0) res = res.concat(constDiff)
  }
  return res;
}

console.log(primePermutations(permutations)[1].join(''))
