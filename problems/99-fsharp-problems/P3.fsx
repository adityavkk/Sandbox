// Find the k'th element of a list
let rec at' k = function
    | [] -> None
    | x :: xs -> if k = 1 then Some x else at' (k - 1) xs

let at'' k xs = fst <| List.fold (fun (x', k') x -> if k' = 0 then (x', k') else (Some x, k' - 1) ) (None, k) xs

