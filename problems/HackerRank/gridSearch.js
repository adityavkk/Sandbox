const log = console.log;
/*
 *  Scan through each row of G to match row 1 of P
 *    If there is a match then check if there are consequtive matches of rows
 *      When you reach the end of P return 'YES'
 *    If # of remaining rows in G < unchecked rows in P then return 'NO'
 * */
const rowCheck = (r1, r2) => {
  const r2RX = new RegExp(r2, 'g');
  const r1RX = new RegExp(r1, 'g');
  console.log(r1, r2, r2RX.exec(r1), r1.match(r2RX))
  return r2RX.exec(r1);
}

const consequtiveMatches = (m1, m2, index) => {
  m1 = m1.slice(0, m2.length)
  return m1.reduce((accum, curr, i) => {
    let rowMatch = rowCheck(curr, m2[i]);
    return rowMatch && rowMatch.index === index ?
      rowCheck(curr, m2[i]) && accum : false;
  }, true)
}

const gridSearch = (G, P) => {
  for (let i = 0; i < G.length; i++) {
    let Gi = G[i],
      P0 = P[0],
      initRowCheck = rowCheck(Gi, P0);
    if (initRowCheck) {
      let remG = G.slice(i + 1),
        remP = P.slice(1),
        initIndex = initRowCheck.index;
      if (remG.length < remP.length) {
        console.log('NO')
        return;
      }
      if (consequtiveMatches(remG, remP, initIndex)) {
        console.log('YES')
        return;
      }
    }
  }
  console.log('NO')
}
let G = ['123456',
'787890',
'686767',
'194729'];
let P = ['78', '67']
gridSearch(G, P)
