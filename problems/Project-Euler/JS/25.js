// First index of fib number to contain 1000 digits

const smaller = (a, b) => {
    return a.length > b.length ? [b, a] : [a, b];
  },
  padZeros = (a, b) => {
    let [small, large] = smaller(a, b);
    small = new Array(large.length - small.length)
      .fill('0')
      .concat(small)
      .join('')
    return [small, large];
  },
  trimLeadingZeros = (str) => {
    let xs = str.split(''),
      i = 0;
    while (xs[i] === '0') {
      xs.shift()
    }
    return xs.join('')
  },
  add = (a, b) => {
    [a, b] = padZeros(a.toString(), b.toString());
    let carry = 0,
      res = [];
    for (let i = a.length - 1; i >= 0; i--) {
      let n = (+a[i] + +b[i] + carry).toString();
      carry = 0;
      if (n.length > 1) {
        carry = +n[0];
        n = n[1];
      }
      res.unshift(n)
    }
    if (carry !== 0) res.unshift(carry.toString())
    return trimLeadingZeros(res.join(''))
  },
  thousandDigFibIndex = (fibSeq = ['1', '1']) => {
    const lastFib = fibSeq[fibSeq.length - 1]
    if (lastFib.length > 999) {
      return fibSeq.length;
    }
    const fibN = add(lastFib, fibSeq[fibSeq.length - 2])
    return thousandDigFibIndex(fibSeq.concat([fibN]))
  }
  console.log(thousandDigFibIndex())
