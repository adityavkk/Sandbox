-- Pack consecutive duplicates of list elements into sublists. If a list
-- contains repeated elements they should be placed in separate sublists.

-- pack :: (Eq a) => [a] -> [[a]]
pack [] = []
pack [x] = [[x]]
pack (x:xs) = (x : same) : pack rest
  where
    same = take n xs
    rest = drop n xs
    n = sameAs xs x


sameAs (x:xs) y = if x == y then 1 + sameAs xs y else 0
sameAs [] y = 0
