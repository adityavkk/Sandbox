//Find the last but one (last and penultimate) elements of a list. (easy)

let rec lastTwo = function
    | [] | [_]  -> None
    | [x ; _]   -> Some x
    | (_ :: xs) -> lastTwo xs

let lastTwo'' xs = xs |> List.rev |> List.tail |> List.tryHead 

let lastTwo' xs = snd <| List.fold (fun (a, b) x -> (Some x, a)) (None, None) xs