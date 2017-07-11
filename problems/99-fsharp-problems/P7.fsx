// Flatten a nested list structure
module P7

type 'a NestedList = One of 'a | Many of 'a NestedList list

let xs = Many [One 1; Many [One 2; One 3]; One 4]

let rec flatten = function
    | One x -> [x]
    | Many xs -> List.collect flatten xs

let rec flatten' = function
    | One x -> [x]
    | Many xs -> List.foldBack (fun x ys -> flatten' x @ ys) xs []

let rec flatten'' = function
    | One x -> [x]
    | Many xs -> List.concat [ for x in xs -> flatten'' x ]