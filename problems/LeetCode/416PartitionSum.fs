open System.Collections.Concurrent

let memoize (f: 'a -> 'b) = let c = ConcurrentDictionary<'a, 'b>() in fun x -> c.GetOrAdd(x, f)

let f (xs: int []) =
    let rec f' (i, s) =
        match i with
        | i when xs.Length = i -> s = 0
        | _ -> f' ((i + 1), (s + xs.[i])) or f' ((i + 1), (s - xs.[i]))
    memoize f' <| (0, 0)
    
let x = f [|2; 7; 10; 4; 5|]
let y = f [|1; 2; 3; 4; 5; 6; 7; 8; 102|]
let z = f [|12; 49; 85; 10; 2; 39; 13; 9|]


printfn "%b" x
printfn "%b" y
printfn "%b" z
