// parse :: String -> [(Graph, Start)]
// For parsing a graph like the one represented in the shortestReach problem
function parse(input /*: string */) /*: [graph, vertex][] */{
  input = input.split('\n')
  const gs = []
  const numQs = +input.shift()
  range(0, numQs).forEach(i => {
    const [vs, es] = input.shift().split(' ').map(Number),
          g = range(1, vs + 1).reduce((gph, i) => {
            gph[i] = []
            return gph
          }, {})
          range(0, es).forEach((_) => {
            const [frm, to] = input.shift().split(' ').map(Number)
            g[frm].push(to)
            g[to].push(frm)
          })
          const start = +input.shift()
          gs.push([g, start])
  })
  return gs
}

// parseString :: String -> (String -> a) -> [a]
function parseString(input, f) {
  return input.split('\n').map(x => console.log(f(x)))
}
