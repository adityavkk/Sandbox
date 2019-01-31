const { insert, del, size, empty } = require('../../data-structures/functional/rb-tree/immutableRBTrees')

const log = console.log

//You are given an integer array nums and you have to return a new counts array. 
//The counts array has the property where counts[i] is the number of smaller elements to the right of nums[i].

/* 
    Approach: 
    - Insert elements into RB Tree
    - fold over xs with init state ([], rbTree)
        Find x in rbt -> issue with duplicates can be solved with an id stored in each node corresponding to its index in the orig array
        numElemenetsSmaller = size(x.l)
        delete x from rbt
        push numElementsSmaller into state
*/

const f = xs => {
    const rbt = xs.reduce((t, x) => insert(x, t), empty())
    return xs.reduce(({ ys, rbt }, x) => {
        const xNode = find(x, rbt)
    }, { ys: [], rbt })
}

const xs = [5, 2, 6, 1]
const expectedOutput = [2, 1, 1, 0]
const res = f(xs)
log(res)
log(res === expectedOutput)