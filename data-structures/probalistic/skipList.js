const log = console.log

class SL {
  constructor() {
    const f = new SLNode(-Infinity, null, null, null, null, null, null, true),
      l = new SLNode(Infinity, null, null, null, null, null, null, true)
    f.n = l
    l.p = f
    f.f = f
    f.l = l
    l.f = f
    l.l = l
    this.bList = f
    this.tList = f
  }

  insert(v) {
    const insertedNode = this.tList.insert(v)
    this.tList = getTopmost(insertedNode)
    function getTopmost(n) {
      if (n.v === -Infinity && !n.u) return n
      if (n.v === -Infinity) return getTopmost(n.u)
      return getTopmost(n.p)
    }
    return insertedNode
  }

  delete(v) {
    return this.tList.delete(v)
  }

  get(v) {
    return this.tList.get(v)
  }
}

class SLNode {
  constructor(v, p, n, u, d, f, l, isBottom) {
    this.v = v
    this.n = n
    this.p = p
    this.d = d
    this.u = u
    this.f = f
    this.l = l
    this.isBottom = isBottom
  }

  get(v) {
    if (this.v === v && this.isBottom) return this
    if (this.v === v) return this.d.get(v)
    if (this.v < v && this.n.v > v && this.isBottom) throw new Error('not found')
    if (this.v < v && this.n.v > v) return this.d.get(v)
    if (v < this.v) return this.p.get(v)
    if (v > this.v) return this.n.get(v)
  }

  insert(v, ins) {
    if (this.v < v && this.n.v >= v) {
      if (this.isBottom || ins) {
        const newNode =
          new SLNode(v, this, this.n, null, null, this.f, this.l, this.f.isBottom)
        this.n = newNode
        const c = flipCoin();
        if (c) {
          const uList = findOrCreateUList(this);
          newNode.u = uList.insert(v, true)
          newNode.u.d = newNode
        }
        return newNode
      }
      return this.d.insert(v)
    } else if (this.v < v) {
      return this.n.insert(v)
    } else return this.p.insert(v)

    function flipCoin() {
      return Math.random() < 0.5
    }

    function findOrCreateUList(node) {
      if (node.u) return node.u
      if (!node.p) return initSLList(node)
      return findOrCreateUList(node.p)
    }

    function initSLList(n) {
      const f = new SLNode(-Infinity, null, null, null, n, null, null, false),
        l = new SLNode(+Infinity, null, null, null, n.l, null, null, false)
      f.n = l
      l.p = f
      f.f = f
      f.l = l
      l.f = f
      l.l = l
      n.f.u = f
      n.l.u = l
      return f
    }
  }

  delete(v) {
    if ((this.v === -Infinity && v < this.n.v ||
         this.v === Infinity && v > this.p.v ||
         this.v < v && this.n.v > v) && this.isBottom)
      throw new Error('not found')
    if (this.v === v) {
      this.p.n = this.n
      this.n.p = this.p
      if (this.d) {
        this.d.delete(v)
      }
      return
    } else if (this.v < v && this.n.v > v) this.d.delete(v)
    else if (this.v > v) this.p.delete(v)
    else if (this.v < v) this.n.delete(v)
  }
}

const x = new SL()
x.insert(4)
x.insert(5)
x.insert(2)
log(x.bList.n.v)
log(x.bList.n.n.v)
log(x.bList.n.n.n.v)
log(x.bList.n.n.n.n.v)
x.delete(4)
log(x.bList.n.v)
