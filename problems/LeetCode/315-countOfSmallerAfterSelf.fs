type Node<'a> = Leaf | Internal of Internal<'a>
    with
        member x.L = 
            match x with
            | Leaf -> Leaf
            | Internal n -> n.L
        member x.R = 
            match x with
            | Leaf -> Leaf
            | Internal n -> n.R
        member x.V =
            match x with
            | Leaf -> None
            | Internal n -> Some n.V
        member x.C =
            match x with
            | Leaf -> NoColor
            | Internal n -> n.C
        member x.Size =
            match x with
            | Leaf -> 0
            | Internal n -> n.Size
and Internal<'a> = {
    V: 'a
    L: Node<'a>
    C: Color
    R: Node<'a>
    Size: int
} 
// MinusBlack and DoubleBlack for Immutable Delete
and Color = Red | Black | MinusBlack | DoubleBlack | NoColor

let node c l v r s = 
    match v with
    | None -> Leaf
    | Some v' -> 
        Internal {
            V = v'
            L = l
            C = c
            R = r
            Size = s
        }
let lift n = Internal n
let size (l: Node<'a>) (r: Node<'a>) = l.Size + r.Size + 1
let twoLefts (n: Node<'a>) = n.L.C = Red && n.L.L.C = Red
let twoRights (n: Node<'a>) = n.R.C = Red && n.R.R.C = Red
let mixedLeft (n: Node<'a>) = n.L.C = Red && n.L.R.C = Red
let mixedRight (n: Node<'a>) = n.R.C = Red && n.R.L.C = Red

let rec bal (n: Node<'a>): Node<'a> = 
    match n.C with
    | Black ->
        if twoLefts n
        then 
            let left1 = node Black n.L.L.L n.L.L.V n.L.L.R <| size n.L.L.L n.L.L.R
            let right1 = node Black n.L.R n.V n.R <| size n.L.R n.R
            node Red left1 n.L.V right1 <| size left1 right1
        else if twoRights n
        then
            let left1 = node Black n.L n.V n.R.L <| size n.L n.R.L
            let right1 = node Black n.R.R.L n.R.R.V n.R.R.R <| size n.R.R.L n.R.R.R
            node Red left1 n.R.V right1 <| size left1 right1
        // Case 2
        else if mixedLeft n
        then
            let left1 = node Black n.L.L n.L.V n.L.R.L <| size n.L.L n.L.R.L
            let right1 = node Black n.L.R.R n.V n.R <| size n.L.R.R n.R
            node Red left1 n.L.R.V right1 <| size left1 right1
        else if mixedRight n
        then
            let left1 = node Black n.L n.V n.R.L.L <| size n.L n.R.L.L
            let right1 = node Black n.R.L.R n.R.V n.R.R <| size n.R.L.R n.R.R
            node Black left1 n.R.L.V right1 <| size left1 right1
        else n
    | Red -> n
    | _ -> failwith "Implement delete!"

let insert (v: 'a) (n: Node<'a>) = 
    let rec go (v: 'a) (n: Node<'a>): Node<'a> = 
        match n with
        | Leaf -> node Red Leaf (Some v) Leaf 1
        | Internal n -> 
            if v >= n.V
            then 
                let goRes = go v n.R
                bal <| node n.C n.L (Some n.V) goRes (size n.L goRes)
            else 
                let goRes = go v n.L
                bal <| node n.C goRes (Some n.V) n.R (size n.R goRes)
    let root = go v n
    node Black root.L root.V root.R root.Size

let rec lessThan x = function
    | Leaf -> Leaf.Size
    | Internal n -> 
        if n.V < x
        then 1 + n.L.Size + lessThan x n.R
        else lessThan x n.L

let insertAndLessThan (v: 'a) (n: Node<'a>): int * Node<'a> =
    let rec go (v: 'a) (n: Node<'a>): int * Node<'a> = 
        match n with
        | Leaf -> 0, node Red Leaf (Some v) Leaf 1
        | Internal n -> 
            if v > n.V
            then 
                let lessThan, goRes = go v n.R
                1 + n.L.Size + lessThan, bal <| node n.C n.L (Some n.V) goRes (size n.L goRes)
            else 
                let lessThan, goRes = go v n.L
                lessThan, bal <| node n.C goRes (Some n.V) n.R (size goRes n.R)
    let lessThan, root = go v n
    lessThan, node Black root.L root.V root.R root.Size

let listToTree xs = xs |> List.fold (fun t x -> insert x t) Leaf
//let tree = [1..100] |> List.fold (fun t x -> insert x t) Leaf
let xs = [8; -4; 5; 4; 2; 9; 1; 2] 
let tree = listToTree xs
let ys = xs |> List.rev |> List.fold (fun (ys, t) x -> let y, t' = insertAndLessThan x t in y :: ys, t') ([], Leaf) |> fst

let t = [5;7;2;8;4;1;3;6] |> listToTree
let t' = [5;7;2;8;4] |> listToTree
