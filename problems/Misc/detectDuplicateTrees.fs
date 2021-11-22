type Tree<'a> = Leaf | Internal of Internal
and Internal = {
    V: 'a
    L: Tree<'a>
    R: Tree<'a>
}
and SerializedTree<'a> = Leaf of string | InternalSerialized of Internal * string

let serialize (tree: Tree<'a>): SerializedTree = failwith ""
let makeSerialized (tree: Tree<'a>): SerializedTree<'a> = 
    match tree with
    | Leaf -> Leaf
    | Internal x -> 
        let l, sl = serialize x.L
        let r, sr = serialize x.R
        tree, sl + x.V.ToString() + sr
