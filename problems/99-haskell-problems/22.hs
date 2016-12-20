-- Create a list containing all integers within a given range.

range :: Int -> Int -> [Int]
range a b
  | a > b = []
  | otherwise = a : range (a + 1) b

range' s = flip take [s..] . (1 +) . abs . (s -)

range'' a b = rangeIter a b []
  where
    rangeIter a b r
      | a > b = r
      | otherwise = rangeIter (a + 1) b (r ++ [a])
