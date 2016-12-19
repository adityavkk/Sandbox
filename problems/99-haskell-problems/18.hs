-- Given two indices, i and k, the slice is the list containing the elements 
-- between the i'th and k'th element of the original list (both limits included). 
-- Start counting the elements with 1.

slice :: [a] -> Int -> Int -> [a]
slice xs a b = slice' xs a b 1 []
  where
    slice' [] _ _ _ _ = []
    slice' (x:xs) a b c r
      | c >= a && c <= b = slice' xs a b (c + 1) (r ++ [x])
      | c < a = slice' xs a b (c + 1) r
      | otherwise = r

slice1 xs a b = map fst $ filter (\(x, i) -> i >= a && i <= b) (zip xs [1..])
