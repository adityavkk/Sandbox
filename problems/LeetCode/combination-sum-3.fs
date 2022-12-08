(*
    Approach:
        1. Generate all k choose [1..9]
        2. Filter for sum = n
        
        
    Approach 2:
        1. Generate only the choices needed
            a. if the sum of elements chosen so far > sum needed: no choices
            b. choose each element as an option, add it to the sum so far and recurse on the remaining elements 
*)
let takeEach xs max =
    let rec go xs max =
        if List.length xs <= max - 1 then [] else
        match xs with
        | (x::xs) -> (x, xs) :: go xs max
    go xs max
        
let rec chooseSum k xs sumSoFar sumNeeded =
    if sumSoFar = sumNeeded && k = 0 then [[]] else
    if sumSoFar > sumNeeded then []
    else
        let ts = takeEach xs k
        let chooseCombine (x, xs) = List.map (fun cs -> x::cs) (chooseSum (k - 1) xs (sumSoFar + x) sumNeeded)
        List.collect chooseCombine ts
        
        
let f k n =
    let oneToNine = [1..9]
    let cs = chooseSum k oneToNine 0 n
    cs
