const contains = (map, keys) => keys.reduce((accum, key) => accum && map[key], true),
  set = (map, keys, val) => keys.reduce((acc, key) => {
    acc[key] = val;
    return map
  }, map),
  maxSet = (map, max, val) => {
    if (map[val] > map.max) map.max = map[val];
    return map
  };
const longestSequence = xs => {
  const table = {
    max: 0
  }
  xs.forEach(x => {
    let dec = x - 1,
      inc = x + 1;
    if (contains(table, [dec, inc])) {
      table[x] = table[dec] + table[inc] + 1
      set(table, [dec, inc], table[x])
      maxSet(table, table.max, table[x])
    } else if (table[dec]) {
      table[x] = table[dec] + 1
      table[dec] = table[x]
      maxSet(table, table.max, table[x])
    } else if (table[inc]) {
      table[x] = table[inc] + 1
      table[inc] = table[x]
      maxSet(table, table.max, table[x])
    } else table[x] = 1
  })
  return table.max
}

const map = { a: 5, b: 3 }

set(map, ['a', 'b'], 0)
console.log(map)
console.log(longestSequence([100, 4, 200, 1, 3, 2]))
