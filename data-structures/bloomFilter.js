const murmur32Bit = require('murmurhash3js').x86.hash32;

class BloomFilter {
  constructor(size, numHash, hashFunction) {
      this.bits = new Array(size);
      this.salt = new Array(numHash).fill(0).map((_, i) => i.toString());
      this.hash = val => hashFunction(val) % this.bits.length;
  }

  add(a) {
    this.salt.forEach(s => {
      this.bits[this.hash(a + s)] = 1
    })
  }

  contains(b) {
    return this.salt.reduce((acc, s) => {
      return this.bits[this.hash(b + s)] === 1 ? true && acc : false && acc
    }, true)
  }

}

const myBloom = new BloomFilter(25, 5, murmur32Bit);
myBloom.add('a')
myBloom.add('b')
myBloom.add('c')
myBloom.add('d')
myBloom.add('e')

console.log(myBloom.contains('a'))
console.log(myBloom.contains('g'))
console.log(myBloom.bits)
