-- Drop every N'th element from a list.

drop' :: [a] -> Int -> [a]
drop' xs n
  | n < 2 = []
  | length xs < n = xs
  | otherwise = takeFirst ++ drop' rest n
  where
    takeFirst = take (n - 1) xs
    rest = drop n xs

drop'' :: [a] -> Int -> [a]
drop'' xs n = map fst (filter (\(x, i) -> i `mod` n /= 0) (zip xs [1..]))
