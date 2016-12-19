-- Split a list into two parts; the length of the first part is given.

split'' :: [a] -> Int -> ([a], [a])
split'' xs n = (take n xs, drop n xs)

split :: [a] -> Int -> ([a], [a])
split xs 0 = ([], xs)
split xs n = split' xs n [] xs
  where
    split' [] _ _ _ = ([], [])
    split' xs 0 h t = (h, t)
    split' (x:xs) n h t = split' xs (n - 1) (h ++ [head t]) (tail t)

