/* How many valid BSTs can be formed from permutations of the numbers [1..n] */

const sum = xs => xs.reduce((a, b) => a + b),
      lessThan = (xs, y) => xs.filter(x => x < y),
      greaterThan = (xs, y) => xs.filter(x => x > y);

const f = ns => {
    const l = ns.length;
    if(l < 2) return 1;
    return sum(ns.map((n) => {
        return f(lessThan(ns, n)) * f(greaterThan(ns, n));
    }));
}

console.log(f([1, 2, 3, 4, 5, 6])); // 132
