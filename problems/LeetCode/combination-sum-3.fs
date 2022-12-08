(*
    Approach:
        1. Generate all k choose [1..9]
        2. Filter for sum = n
*)
let takeEach xs max =
    let rec go xs max =
        if List.length xs <= max - 1 then [] else
        match xs with
        | (x::xs) -> (x, xs) :: go xs max
    go xs max

let rec choose k xs = 
    if k = 0 or xs = [] then [[]]
    else
        let ts = takeEach xs k
        let chooseCombine (x, xs) =
            let res = List.map (fun cs -> x::cs) (choose (k - 1) xs)
            res
        List.collect chooseCombine ts
        
let f k n =
    let oneToNine = [1..9]
    let cs = choose k oneToNine
    List.filter (fun xs -> List.sum xs = n) cs
