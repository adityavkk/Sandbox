/* Trie with string keys and num values
 * Methods:
 * Add
 * isMember
 */

class Trie {
  constructor() {
    this.r = [mt(null)];
  }

  // Add a tuple ['amy', 56]
  add([key, v]) {
    const findOrCreate = (k, r) => {
      const match = r.filter(x => x.v === k);
      if (!match.length) {
        const n = node(k);
        r.push(n);
        return n;
      }
      return match[0];
    };
    const ks = key.split('');
    let p = findOrCreate(ks.shift(), this.r);
    ks.forEach(k => {
      p = findOrCreate(k, p.cs);
    })
    p.cs.push(mt(v))
  }

  isMember(key) {
    const ks = key.split('');
    let ns = this.r;
    return ks.reduce((contains, k, i) => {
      let f = ns.filter(x => x.v === k)
      if (f.length) {
        ns = f[0].cs;
        if (i === ks.length - 1) {
          let isWord = ns.filter(x => x.isWord)
          return isWord.length ? isWord[0].k : false;
        }
      }
      return !!f.length && contains;
    }, true)
  }

  remove(key) {}
}

class Node {
  constructor(v, cs = []) {
    this.v = v;
    this.cs = cs;
  }
}

function node(v, cs) {
  return new Node(v, cs);
}

class Mt {
  constructor(k) {
    this.k = k;
    this.isWord = true;
  }
}

function mt(key) {
  return new Mt(key)
}

const log = console.log,
  pp = x => log(JSON.stringify(x, null, 4)),
  myTrie = new Trie();

myTrie.add(['amy', 56])
myTrie.add(['amz', 60])
myTrie.add(['amzy', 65])
pp(myTrie)
log(myTrie.isMember('amzy'))
