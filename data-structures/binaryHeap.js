// Array backed (min) binary heap

class BinHeap {
  constructor() {
    this._xs = []
  }

  size() { return this._xs.length }

  insert(x) {
    this._xs.push(x)
    this.heapifyUp(this._xs.length - 1)
    return this
  }

  peek() {
    return this._xs[0]
  }

  extract() {
    if (this._xs.length === 1) return this._xs.pop()
    const x = this._xs[0];
    this._xs[0] = this._xs.pop()
    this.heapifyDown(0)
    return x
  }

  heapifyUp(i) {
    const pi = Math.floor((i - 1) / 2),
      p = this._xs[pi],
      x = this._xs[i]
    if (x < p) {
      this._xs[pi] = x
      this._xs[i] = p
      this.heapifyUp(pi)
    }
  }

  heapifyDown(i) {
    const ci = (2 * i) + 1,
      cj = (2 * i) + 2,
      chi = this._xs[ci],
      chj = this._xs[cj],
      r = this._xs[i],
      sc = chi < chj ? chi : chj,
      si = chi < chj ? ci : cj
    if (r > sc) {
      this._xs[i] = sc
      this._xs[si] = r
      this.heapifyDown(si)
    }
  }
}

const log = console.log,
  xs = [10, 4, 2, 29, 3, 8, 9].reduce((h, e) => h.insert(e), new BinHeap())
log(xs._xs)
log(xs.extract())
log(xs.extract())
log(xs.extract())
log(xs.extract())
log(xs.extract())
log(xs.extract())
log(xs._xs)
