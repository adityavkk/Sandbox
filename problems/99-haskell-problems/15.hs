-- Replicate the elements of a list a given number of times.

repli :: [a] -> Int -> [a]
repli xs 0 = []
repli xs n = flatten (map (`duplicate` n) xs)
  where
    flatten [] = []
    flatten ([]:xs) = flatten xs
    flatten (x:xs) = head x : flatten(tail x:xs)
    duplicate x 1 = [x]
    duplicate x n = x : duplicate x (n - 1)

repli' :: [a] -> Int -> [a]
repli' = flip (concatMap . replicate)
