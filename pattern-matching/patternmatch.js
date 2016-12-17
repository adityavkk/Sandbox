const wc = '_';
const log = console.log;

class Cons {
  constructor(a,b) {
  	this.car = a;
  	this.cdr = b;
  }

  // match(pattern) {
  // 	return [(pattern[0].match(this.car)) &&	(pattern[1].match(this.cdr)), [this.car, this.cdr]];
  // }
}

const cons = (a,b) => new Cons(a,b);

const list = cons(1, cons(2, null));

function factorial(n) {
	return evalPatterns([n],
               [[ 0 ], () => 1],
               [['_'], () => n * factorial(n - 1)]);
}

function addIfOne (a, b) {
  return evalPatterns([a, b],
               [[1, '_'], (a, b) => a + b],
               [['_', '_'], () => 0])
}

function numOnes(list) {
	log('numOnes called with: ' + JSON.stringify(list, null, 4));
	return evalPatterns([list],
               [[null], () => 0],
               [[Cons, 1, '_'], (car, cdr) => 1 + numOnes(cdr)],
               [[Cons, '_', '_'], (_, cdr) => numOnes(cdr)]);
}

function evalPatterns(args, ...ps) {
  let l = ps.length, i = 0, matched = false, vals = [];
  while (i < l) {
  	log('args: ' + JSON.stringify(args, null, 4));
    if (match(args, ps[i][0])) return ps[i][1](...args);
    i++;
  }
  return false;
}

function match(vals, pt) {
	log(vals, pt);
  return pt.every((p, i) => {
    let v = vals[i];
    if (p === wc) return true;
    if (isPrim(p)) return p === v;
    if (isPrim(v)) return p === v;
    if (typeof p === 'function' && p === v.constructor)
      return match(Object.values(v), pt.slice(1));
    if (Array.isArray(p)) return match(v, p);
  })
}

function isPrim(x) {
  const type = typeof x,
    ts = ['number', 'string', 'boolean'];
  return ts.some(t => t === type);
}

Number.prototype.match = function (pattern) {
  if (pattern === wc) return true;
  return this.valueOf() === pattern;
}

log(numOnes(list))
