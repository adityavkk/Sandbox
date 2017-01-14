-- An O (n log n) algorithm to solve the longest increasing subsequence problem
-- based on the approach shown by Richard Bird in his functional pearl solving
-- the maximum surpasser count problem

lis :: Ord a => [a] -> Int
lis = maximum . map (\ (_, a, _) -> a) . table

type Table = Ord a => [(a, Int, a)]

table :: Ord a => [a] -> Table
table xs = join (n - m) (table ys) (table zs)
  where n        = length xs
        m        = n `div` 2
        (ys, zs) = splitAt m xs

join :: Int -> Table -> Table


