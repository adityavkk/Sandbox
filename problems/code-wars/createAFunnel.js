/*
 *   \         /
   		\7 8 9  /
    	 \4 5 6/
     	  \2 3/
      	 \1/
 *
 */

class Vertex {
  constructor(val) {
    this.val = val
  }

  toString() {
    return JSON.stringify(this)
  }

}

class DirectedGraph {
  adjacencyList = {}
  root = null

  constructor () {}

  addEdge(v1, v2) {
    const isV1InGraph = v1 in this.adjacencyList
    const isV2InGraph = v2 in this.adjacencyList
    if (!isV1InGraph) this.adjacencyList[v1] = new Set()
    if (!isV2InGraph) this.adjacencyList[v2] = new Set()
    this.adjacencyList[v1].add(v2)
  }

  addVertex(v) {
    const isVInGraph = v in this.adjacencyList
    if (!isVInGraph) this.adjacencyList[v] = new Set()
  }

  neighbours(v) {
    return this.adjacencyList[v]
  }

  set root(v) {
    this.root = v
  }

  get vertices() {
    return Object.keys(this.adjacencyList)
  }

  weightAbove(vertex) {
    return dfs(vertex, this)
  }
}

const dfs = (vertex, graph) => {
  const visited = new Set()
  const go = vertex => {
    visited.add(vertex)
    const neighbours = graph.neighbours(vertex)
    if (neighbours.size == 0) return 0
    const unvisitedNeighbours = Array.from(neighbours).filter(v => !visited.has(v))
    console.log(vertex.val, unvisitedNeighbours)
    return 1 + unvisitedNeighbours.reduce((sum, v) => sum + go(v), 0)
  }
  return go(vertex)
}

class Funnel {

  #funnel = new DirectedGraph()

  constructor() {
    const root = new Vertex(1)
    this.#funnel.addVertex(root)
    this.#funnel.root = root
  }

  fill(...xs) {
    
  }
  
  drip() {}

  toString() {
    return `\\${this.#funnel.root.val}/`
  }
}

const g = new DirectedGraph()
const v1 = new Vertex(1)
const v2 = new Vertex(2)
const v3 = new Vertex(3)
const v4 = new Vertex(4)

g.addEdge(v1, v2)
g.addEdge(v1, v3)
g.addEdge(v2, v4)


const foo = new Funnel()
console.log(foo.toString())
console.log(g.vertices)
console.log(g.weightAbove(v1))
