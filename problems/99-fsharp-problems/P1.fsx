// Write a function last : 'a list -> 'a option that returns the last element of a list
let rec last = function
    | []        -> None
    | [x]       -> Some x
    | (_ :: xs) -> last xs

let last' xs = xs |> (List.rev >> List.tryHead)

let last'' xs = List.fold (fun _ x -> Some x) None xs

let last''' xs = List.foldBack (fun x y -> if Option.isNone y then Some x else y) xs None
