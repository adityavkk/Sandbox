// Pack consecutive duplicates of list elements into sublists. (medium)
module P9 =
    let xs = ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"d";"e";"e";"e";"e"]

    let pack xs = 
        let f x = function
            | []                                  -> [[x]]
            | ((z :: zs as zs') :: ys) when x = z -> (x :: zs') :: ys
            | ys                                  -> [x] :: ys
        List.foldBack f xs []

    let pack' xs = 
        let rec f xs ys = 
            match xs, ys with
            | [], [] -> []
            | [], ys -> ys
            | (x :: xs), [] -> f xs [[x]]
            | (x :: xs), ((z :: zs as zs') :: ys) when x = z -> f xs ((x :: zs') :: ys)
            | (x :: xs), ys -> f xs ([x] :: ys)
        List.rev <| f xs []