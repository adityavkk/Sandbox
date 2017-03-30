const { AdjacencyList } = require('../../../utils/utils')

const graph = new AdjacencyList()

graph.insert(6, 5)
  .insert(5, 4)
  .insert(4, 6)
  .insert(0, 1)
  .insert(1, 2)
  .insert(2, 0)
  .insert(3, 2)
  .insert(2, 3)

module.exports = {
  graph
}
