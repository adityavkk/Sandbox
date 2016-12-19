-- Insert an element at a given position into a list.

insertAt :: a -> [a] -> Int -> [a]
insertAt y xs n = insertAt' y xs n 1 []
  where
    insertAt' y (x:xs) n c r
      | n == c = r ++ [y] ++ (x:xs)
      | otherwise = insertAt' y xs n (c + 1) (r ++ [x])

insertAt'' y xs n = take (n - 1) xs ++ [y] ++ drop (n - 1) xs
