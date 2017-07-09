// Reverse a list
module P5

let rev xs = List.fold (fun ys x -> x :: ys) [] xs