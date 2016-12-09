const log = console.log
const rd = 'red',
  bk = 'black';
class Node {
  constructor(c, l, v, r) {
    this.v = v;
    this.l = l;
    this.c = c;
    this.r = r;
    this.mt = false;
  }
}

class mtNode {
  constructor() {
    this.l = null;
    this.r = null;
    this.c = false;
    this.mt = true;
  }
}

const mt = () => new mtNode();
const node = (c, l, v, r) => new Node(c, l, v, r);

function insert(v, n) {
  function insertHelper(v, n) {
    if (n.mt) return node(rd, mt(), v, mt());
    if (v > n.v) return bal(node(n.c, n.l, n.v, insertHelper(v, n.r)));
    if (v < n.v) return bal(node(n.c, insertHelper(v, n.l), n.v, n.r));
    else return n;
  }
  const root = insertHelper(v, n);
  return node(bk, root.l, root.v, root.r);
}

function bal(n) {
  //Case 1
  if (twoLefts(n)) {
    return node(rd,
                node(bk, mt(), n.l.l.v, mt()),
                n.l.v,
                node(bk, n.l.r, n.v, mt()));
  }
  if (twoRights(n)) {
    return node(rd,
                node(bk, mt(), n.v, n.r.l),
                n.r.v,
                node(bk, mt(), n.r.r.v, mt()));
  }
  //Case 2
  if (mixedLeft(n)) {
    return node(rd,
                node(bk, n.l.l, n.l.v, mt()),
                n.l.r.v,
                node(bk, mt(), n.v, mt()));
  }
  if (mixedRight(n)) {
    return node(rd,
                node(bk, mt(), n.v, mt()),
                n.r.l.v,
                node(bk, mt(), n.r.v, n.r.r));
  }
  return n;
}

function twoLefts(n) {
  return n.l.c === rd && n.l.l.c === rd;
}

function twoRights(n) {
  return n.r.c === rd && n.r.r.c === rd;
}

function mixedLeft(n) {
  return n.l.c === rd && n.l.r.c === rd;
}

function mixedRight(n) {
  return n.r.c === rd && n.r.l.c === rd;
}

function del(v, n) {
  if (n === null) return null;
  if (v > n.v) return node(n.c, n.l, n.v, del(v, n.r));
  if (v < n.v) return node(n.c, del(v, n.l), n.v, n.r);
  else {
    if (n.l === null && n.r === null) return null;
    if (n.l === null && n.r) return n.r;
    if (n.r === null && n.l) return n.l;
    else return node(n.c, n.l, min(n.r), del(min(n.r), n.r));
  }
}

function min(n) {
  if (n.l === null) return n.v;
  else return min(n.l);
}

const bt = mt(),
  t1 = insert(8, bt),
  t2 = insert(4, t1),
  t3 = insert(3, t2),
  t4 = insert(5, t3),
  t5 = insert(6, t4),
  t6 = del(4, t5);

log(t5);
