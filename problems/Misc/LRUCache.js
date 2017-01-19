/* Design and implement a data structure for a Least Recently Used Cache. It
 * should be initialized with a capacity and support the following operations:
 * get and set
 * get(key) - gets the value (will always be positive) of the key if the key
 *  exists in the cache, otherwise return -1
 * set(key, val) - set or insert the value if the key is not already present.
 *
 * When the cache reaches its capacity, it should invalidate the least
 * recently used item before inserting a new item
 */

const log = console.log

class Node {
  constructor(l, k, v, r) {
    this.l = l;
    this.v = v;
    this.k = k;
    this.r = r;
  }
}

class DLL {
  constructor() {
    this.first = null;
    this.last = null;
    this.size = 0;
  }

  insert(k, v) {
    const n = new Node(this.last, k, v, null);
    if (!this.first) this.first = n;
    if (this.last) this.last.r = n;
    this.last = n;
    this.size++
      return n;
  }

  delete(n) {
    if (n === this.first) {
      this.first = n.r;
      this.first.l = null;
    } else {
      if (n === this.last) this.last = n.l;
      else
        n.r.l = n.l;
      n.l.r = n.r;
    }
    this.size--;
    return n;
  }
}

class LRUCache {
  constructor(cap) {
    this.cap = cap;
    this.ks = {};
    this.vs = new DLL();
  }

  get(k) {
    const vs = this.vs,
      ks = this.ks,
      n = ks[k];
    if (!n) return;
    const v = n.v;
    if (!n) return;
    vs.delete(n);
    const newN = vs.insert(k, v);
    ks[k] = newN;
    return v;
  }

  set(k, v) {
    const vs = this.vs,
      ks = this.ks;
    if (vs.size === this.cap) {
      const fk = vs.first.k
      vs.delete(vs.first)
      delete ks[fk]
    }
    const n = vs.insert(k, v);
    ks[k] = n;
    return [k, v];
  }
}

const lru = new LRUCache(2)
lru.set(1, 'a')
lru.set(2, 'b')
lru.set(3, 'c')
lru.get(2)
lru.set(4, 'd')
log(lru.get(3))
