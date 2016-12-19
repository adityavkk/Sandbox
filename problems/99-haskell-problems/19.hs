-- Rotate a list N places to the left.

rotate :: [a] -> Int -> [a]
rotate xs n = map fst (first mapped ++ rest mapped)
  where
    len = length xs
    mapped = map (\(x, i) -> (x, (i - n + len) `mod` len)) (zip xs [1..])
    first (x:xs)
      | snd x == 1 = x:xs
      | otherwise = first xs
    rest (x:xs)
      | snd x == 1 = []
      | otherwise = x : rest xs

rotate' :: [a] -> Int -> [a]
rotate' xs n = drop n' xs ++ take n' xs
  where
    n' = if n < 0 then n + length xs else n `mod` length xs
