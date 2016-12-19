-- Remove the K'th element from a list.

removeAt :: [a] -> Int -> (a, [a])
removeAt xs n = removeAt' xs n (head xs) [] 1
  where
    removeAt' xs 1 d r c = (d, tail xs)
    removeAt' (x:xs) n d r c
      | (c + 1) == n = (head xs, r ++ [x] ++ tail xs)
      | otherwise = removeAt' xs n d (r ++ [x]) (c + 1)
