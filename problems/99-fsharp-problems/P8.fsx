// Eliminate consecutive duplicates of list elements
module P8 =

    let xs = ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"e";"e";"e";"e"] 

    let compress xs =
        let rec f xs ys =
            match xs, ys with
            | [], _ -> ys
            | (x :: xs), [] -> f xs [x]
            | (x :: xs), (y :: ys as ys') -> if x = y then f xs ys' else f xs (x :: ys')

        f xs [] |> List.rev

    let rec compress' = function
        | x :: (y :: _ as ys) -> if y = x then compress' ys else x :: compress' ys
        | xs -> xs