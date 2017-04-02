/* Given an array of numbers and a range length, determine the maximum element
 * for each range in the array
 *
 * xs = [2, 5, 1, 3, 3, 4, 8, 1]
 * rLength = 3
 * maxes = [5, 5, 3, 4, 8, 8]
 */

/* Approach:
 * - Assume an implementation of a maxQueue with the following api:
 *    enqueue -> O (1)
 *    dequeue -> O (1)
 *    max     -> O (1)
 * - Insert first rLength elements from xs into maxQueue
 * - for x in xs[rLength:]:
 *    dequeue
 *    enqueue x
 *    extract max and push into maxes
 * - return maxes
 */

/* Implementation of maxQueue:
 * - maxStack implementation:
 *   push -> O (1)
 *   pop  -> O (1)
 *   max  -> O (1)
 *   - For each push, keep track of maxes in a second stack
 *   - pop: pop element from primary stack and secondary stack
 *   - max: peek on top of second stack
 * - maxQueue implementation using 2 maxStacks:
 *   - enqueue x: push x into maxStack1
 *   - dequeue  : if maxStack 2 is empty, keep popping from maxStack1 and
 *                pushing into maxStack2 until maxStack1 is empty, then pop from
 *                maxStack2
 *   - max      : max(maxStack1.max(), maxStack2.max())
 */

const log = console.log

class MaxStack {
  constructor() {
    this.data = []
    this.maxes = [-Infinity]
  }

  push(x) {
    this.data.push(x)
    if (x > this.max()) this.maxes.push(x)
    else this.maxes.push(this.max())
  }

  pop() {
    this.maxes.pop()
    return this.data.pop()
  }

  max() {
    return this.maxes[this.maxes.length - 1]
  }

  mt() {
    return this.data.length === 0
  }

}

class MaxQueue {
  constructor() {
    this.s1 = new MaxStack()
    this.s2 = new MaxStack()
  }

  enqueue(x) {
    this.s1.push(x)
    return this
  }

  dequeue() {
    if (this.mt()) return
    if (this.s2.mt()) {
      while (!this.s1.mt()) this.s2.push(this.s1.pop())
    }
    return this.s2.pop()
  }

  max() {
    return this.s1.max() > this.s2.max() ? this.s1.max() : this.s2.max()
  }

  mt() {
    return this.s1.mt() && this.s2.mt()
  }
}

const f = (xs, rl) => {
  const q = xs.slice(0, rl).reduce((mxQ, x) => mxQ.enqueue(x), new MaxQueue())
  return xs.slice(rl).reduce((ms, x) => {
    q.enqueue(x)
    q.dequeue()
    ms.push(q.max())
    return ms
  }, [q.max()])
}

log(f([2, 5, 1, 3, 3, 4, 8, 1], 3)) // => [5, 5, 3, 4, 8, 8]
