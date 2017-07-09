// Reverse a list

let rev xs = List.fold (fun ys x -> x :: ys) [] xs