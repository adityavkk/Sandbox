// Design a data-structure that can extract in constant time
class MedianHeap {
  constructor() {
    this.data = [];
  }

  insert(x) {
    this.data.push(x);
    this.heapifyUp();
    return x;
  }

  extract() {
    return this.data.shift();
  }

  heapifyUp() {
    
  }
}

class MinHeap {
  constructor() {
    this.data = [];
  }

  insert(x) {
    
  }
}

class MaxHeap {

}

