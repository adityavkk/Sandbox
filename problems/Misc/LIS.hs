-- length longest subsequence ending at index j

l ys = maximum (map f (heads ys) ++ [1])
  where f []      = 0
        f xs      = if x < y then l xs + 1 else 0
          where x = last xs
        y         = last ys

heads xs = tail $ scanl snoc [] xs
snoc xs x = xs ++ [x]

f xs = maximum (map l (heads xs))

f (xs ++ ys) = join (f xs) (f ys)
