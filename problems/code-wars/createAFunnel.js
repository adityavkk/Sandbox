const vm = require('vm')
const util = require('util')
/*
 *   \1 _ 3 4  / 5
   		\1 9 8 9/ 4
    	 \7 5 6/ 3
     	  \9 3/ 2 
      	 \2/ 1 
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
  adjacencyList = new Map()
  root = null

  constructor () {}

  addEdge(v1, v2) {
    const isV1InGraph = this.adjacencyList.has(v1)
    const isV2InGraph = this.adjacencyList.has(v2)
    if (!isV1InGraph) this.adjacencyList.set(v1, new Set())
    if (!isV2InGraph) this.adjacencyList.set(v2,new Set())
    this.adjacencyList.get(v1).add(v2)
  }

  addVertex(v) {
    const isVInGraph = v in this.adjacencyList
    if (!isVInGraph) this.adjacencyList.set(v, new Set())
  }

  neighbours(v) {
    return this.adjacencyList.get(v)
  }

  set root(v) {
    this.root = v
  }

  get vertices() {
    return this.adjacencyList.keys()
  }

  weightAbove(vertex) {
    return Math.max(0, bfs(vertex, this).length - 1)
  }

  removeEdge(v1, v2) {
    this.neighbours(v1).delete(v2)
  }
}

class Funnel {

  #funnel = new DirectedGraph()

  constructor(funnel) {
    if(funnel) this.#funnel = funnel
  }

  fill(...xs) {
    //create vertices for xs
    //add them to the bottom level of the graph 
    //update neighbours (at most 2 vertices)
  }
  
  drip() {
    console.log(`DRIPPING`)
    const graph = this.#funnel
    const getHeaviestNeighbour = vertex => {
      const neighbours = Array.from(graph.neighbours(vertex))
      console.log(vertex, neighbours)
      if (neighbours.length == 0) return null
      if (neighbours.length == 1) return neighbours[0]
      const [leftWeight, rightWeight] = neighbours.map(n => graph.weightAbove(n))
      const heaviestNeighbour = leftWeight >= rightWeight ? neighbours[0] : neighbours[1]
      //console.log(`LEFT`, leftWeight, `RIGHT`, rightWeight, neighbours, heaviestNeighbour)
      return heaviestNeighbour
    }
    // return the heaviest neighbour and restore the graph edges
    const replaceWithHeaviestNeighbour = vertex => {
      // remove edge between heaviest neighbour and vertex
      // add an edge between the other neighbour of vertex and heaviest
      // recursively replaceWithHeaviestNeighbour on heaviest neighbour
      const heaviest = getHeaviestNeighbour(vertex)
      console.log(`HEAVIEST`, heaviest)
      if (heaviest == null) return null
      if (heaviest !== null) {
        graph.neighbours(vertex).forEach(n => {
          graph.removeEdge(vertex, n)
          graph.addEdge(heaviest, n)
        })
        replaceWithHeaviestNeighbour(heaviest)
        return heaviest
      }
    }

    const replacedRoot = replaceWithHeaviestNeighbour(graph.root)
    //console.log(`ROOT`, replacedRoot)
    graph.root = replacedRoot
  }

  draw() {
    // BFS and stringify each level
    console.log(`DRAWING`)
    const graph = this.#funnel
    const bfsOrder = bfs(graph.root, graph)
    const numElements = [1, 2, 3, 4, 5]
    const levels = numElements.reduce((levels, n) => {
      levels.push(bfsOrder.splice(0, n))
      return levels
    }, []).reverse()
    return levels.map((l, i) => `${spaces(i)}\\${l.join(' ')}/`).join('\n')
  }
}

const spaces = i => new Array(i).fill(' ').join('')
const draw = (graph) => {
}

const bfs = (vertex, graph) => {
  // Q = [vertex]
  // loop:
    // v = deQ 
    // do work
    // add childen of v to Q
  const order = []
  const Q = [vertex]
  const visited = new Set()
  while (Q.length > 0) {
    const v = Q.shift()
    if (visited.has(v)) continue
    order.push(v.val)
    visited.add(v)
    const neighbours = graph.neighbours(v)
    Q.push(...neighbours)
  }
  return order
}

const g = new DirectedGraph()
const range = n => new Array(n).fill(0).map((_, i) => i+1)
const sandbox = vm.createContext({})
const rand = () => Math.floor(Math.random() * 9) + 1

const setUpVertices = (n) => {
  const nRange = range(n)
  const vNames = nRange.map(i => `v${i}`) 
  const vertices = nRange.map(i => new Vertex(rand()))
  vNames.forEach((v, i) => {
    vm.runInContext(`${v}=${vertices[i]}`, sandbox)
  })
}
setUpVertices(15)
g.addEdge(sandbox.v1, sandbox.v2)
g.addEdge(sandbox.v1, sandbox.v3)
g.addEdge(sandbox.v2, sandbox.v4)
g.addEdge(sandbox.v2, sandbox.v5)
g.addEdge(sandbox.v3, sandbox.v5)
g.addEdge(sandbox.v3, sandbox.v6)
g.addEdge(sandbox.v4, sandbox.v7)
g.addEdge(sandbox.v4, sandbox.v8)
g.addEdge(sandbox.v5, sandbox.v8)
g.addEdge(sandbox.v5, sandbox.v9)
g.addEdge(sandbox.v6, sandbox.v9)
g.addEdge(sandbox.v6, sandbox.v10)
g.addEdge(sandbox.v7, sandbox.v11)
g.addEdge(sandbox.v7, sandbox.v12)
g.addEdge(sandbox.v8, sandbox.v12)
g.addEdge(sandbox.v8, sandbox.v13)
g.addEdge(sandbox.v9, sandbox.v13)
g.addEdge(sandbox.v9, sandbox.v14)
g.addEdge(sandbox.v10, sandbox.v14)
g.addEdge(sandbox.v10, sandbox.v15)
g.root = sandbox.v1


const foo = new Funnel(g)

// console.log(foo.draw())
// console.log(foo.drip())
// console.log(foo.draw())

