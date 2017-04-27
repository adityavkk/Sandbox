-- Find the i largest elements in an arbitrarily ordered list

-- f :: Ord a => [a] -> Int -> [a] -> [a]
-- since list is arbitrarily ordered, pick the first element as a pivot
-- partition xs around pivot -> [pivotIdx, xsLT, xsGT]
-- if pivotIdx == i:
  -- pivot : (es ++ xsGT)
-- if pivotIdx < i:
  -- f xsGT (i - pivotIdx) es
-- otherwise:
  -- f xsLT i (pivot : (es ++ xsGT))
-- O (n) average case time complexity

largestElements :: Ord a => [a] -> Int -> [a]
largestElements xs i = f xs (length xs - i) []

f :: Ord a => [a] -> Int -> [a] -> [a]
f [] _ es = es
f (x:xs) i es
  | pivotIdx == i = es ++ xsGT
  | pivotIdx < i  = f xsGT (i - pivotIdx) es
  | otherwise     = f xsLT i (x : (es ++ xsGT))
  where (pivotIdx, xsLT, xsGT) = partition xs x

partition :: Ord a => [a] -> a -> (Int, [a], [a])
partition xs y = (length xsLT + 1, xsLT, xsGT)
  where xsLT = [x | x <- xs, x < y]
        xsGT = [x | x <- xs, x > y]

xs = [5, 1, 6, 4, 8, 2, 9, 0, 3, 7]
