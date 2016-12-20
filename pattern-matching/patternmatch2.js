const esprima = require('esprima');
const escodegen = require('escodegen');
const walk = require('esprima-walk');
const pp = (s) => JSON.stringify(s, null, 4);
const parse = (p) => esprima.parse(p.toString()).body[0].expression.body.body[0].expression.expressions;
const wc = '_';
const log = console.log;

class Cons {
  constructor(a,b) {
  	this.car = a;
  	this.cdr = b;
  }
}

const cons = (a,b) => new Cons(a,b);

const list = cons(1, cons(2, null));

function numOnes(xs) {
  return match(xs, () => {
    [Cons(1, a), 1 + numOnes(a)],
    [Cons(_, a), numOnes(a)]
  })
}

const predicate = p => p.elements[0];
const predicand = p => p.elements[1];

function match(args, thunk) {
  const pairs = parse(thunk);
  let l = pairs.length, i = 0, matched = false;
  while (i < l) {
    let locals = {};
    if (isMatch(args, predicate(pairs[i]), locals)) {
      const f = predicand(pairs[i]);
      // return eval(replace(f, locals));
      return replace(f, locals);
    }
    i++;
  }
  return false;
}
const isIdent = s => s.type === 'Identifier';
const isWC = p => isIdent(p) && p.name === '_';
const isCaps = s => s.toUpperCase() === s;
const isConstructor = p => isIdent(p.callee) && isCaps(p.callee.name[0]);
const isVar = p => isIdent(p) && !isCaps(p.name[0]);
const isPrimMatch = (p, v) => p.type === 'Literal' && p.value === v;
const getConstructor = v => {
  let x = v.constructor.toString();
  return x.match(/[A-Z][^\W]*/)[0]
}

function isMatch(val, pat, locals) {
  val = Array.isArray(val) ? val : [val]
  pat = Array.isArray(pat) ? pat : [pat]
  return pat.every((p, i) => {
    let v = val[i];
    if (Array.isArray(p) && Array.isArray(v)) 
      return isMatch(v, p, locals);
    if (isWC(p)) return true;
    if (isVar(p)) {
      locals[p.name] = v;
      return true;
    }
    if (isPrimMatch(p, v)) return true;
    if (p.callee && isConstructor(p) && getConstructor(v) === p.callee.name) 
      return isMatch(Object.values(v), p.arguments, locals)
  })
}

function replace(f, locals) {
  const rep = node => {
    let val = locals[node.name]
    if (node.type === "Identifier" && val) {
      // const newNode = esprima.parse(val.toString())
      log(val);
      node.type = "Literal";
      node.value = val;
      node.raw = JSON.stringify(val);
      delete node.name;
    }
  }
  walk(f, rep);
  // return escodegen.generate(f);
  return f;
}

let x = esprima.parse('50 + 5')
const cons1 = (a, b) => new Cons(b, a);
const zs = [3, 2, 1, 1].reduce(cons1, null);
const tk = () => {
  [Cons(1, a), 1 + numOnes(a)],
  [Cons(_, a), numOnes(a)]
}
// log(match(zs, tk))
// log(eval(escodegen.generate(x)))
const ast = parse(() => {
  [Cons(1, a), 1 + numOnes(a)],
  [Cons(_, a), numOnes(a)]
})

const toRep = { type: "Literal", value: 5, raw: (5).toString() }
log(pp(match(zs, tk)))
