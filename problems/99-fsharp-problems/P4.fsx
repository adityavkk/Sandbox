// Find the number of elements of a list

let length' xs = List.foldBack (fun _ c -> c + 1) xs 0

let length xs =
    let rec f' i = function
        | [] -> i
        | (x :: xs) -> f' (i + 1)  xs
    f' 0 xs

let length'' xs = List.sumBy (fun _ -> 1) xs