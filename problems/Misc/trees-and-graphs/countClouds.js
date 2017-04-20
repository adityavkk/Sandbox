/* Given a 2D grid skyMap composed of '1's (clouds) and '0's (clear sky), count
 * the number of clouds. A cloud is surrounded by clear sky, and is formed by
 * connecting adjacent clouds horizontally or vertically. You can assume that
 * all four edges of the skyMap are surrounded by clear sky.
 *
 * skyMap = [['0', '1', '1', '0', '1'],
            ['0', '1', '1', '1', '1'],
            ['0', '0', '0', '0', '1'],
            ['1', '0', '0', '1', '1']]
   countClouds(skyMap = 2
 */

/* DFS from each unseen cloud
 * countClouds :: Sky -> Int
 * seen = set {}
 * traverse sky:
 *    if cell is 1 and not in seen: incr count
 *    seen = dfs cell sky seen
 * return count
 *
 * dfs (mutates seen) :: Start -> Sky -> Seen -> FinalSeen
 * - add start to seen
 * - ns = filter (isCloud) (neighbors of start in sky)
 * - return merge seens from map dfs ns
 */
const log = console.log

const f = sky => {
  const seen = new Set()
  return sky.reduce(row, 0)

  function row(count, r, i) {
    return r.reduce((count, x, j) => {
      if (x === '1' && !seen.has(hash(i, j))) {
        dfs([i, j])
        return count + 1
      }
      return count
    }, count)
  }

  function dfs([i, j]) {
    seen.add(hash(i, j))
    const ns = neighbors(i, j, sky).filter(([i, j]) => sky[i][j] === '1' &&
                                                       !seen.has(hash(i, j)))
    ns.forEach(dfs)
  }

  function neighbors(i, j, sky) {
    const exists = ([i, j]) => sky[i] !== undefined && sky[i][j] !== undefined
    return [[i + 1, j], [i - 1, j], [i, j - 1], [i, j + 1]].filter(exists)
  }

  function hash(i, j) {
    return [i, j].toString()
  }
}

const sky = [['0', '1', '1', '0', '1'],
            ['0', '1', '1', '1', '1'],
            ['0', '0', '0', '0', '1'],
            ['1', '0', '0', '1', '1']]
const sky1 = [["1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","0","0","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","0","0","0","0","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1"]]
log(f(sky1))
