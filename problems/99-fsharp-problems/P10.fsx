// Run-length encoding of a list.
module P10 =
    let xs = ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"e";"e";"e";"e"]

    let encode xs = 
        let f x = function
            | [] -> [(1, x)]
            | ((n, y) :: ys as ys') -> if y = x 
                                       then (n + 1, y) :: ys
                                       else (1, x) :: ys'
        List.foldBack f xs []