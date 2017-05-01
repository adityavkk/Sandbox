-- Given two arrays of integers, compute the pair of values (one in each array)
-- with the smallest (non-negative) difference. Return the difference
  -- [1, 3, 15, 11, 2] [23, 127, 235, 19, 8]
  -- minDifference = 3 (11, 8)

-- Sort xs in descending and ys in ascending
-- [15, 11, 3, 2, 1] [7, 8, 12, 19, 23, 127, 235]
-- compare x with y
--   if x == y: 0
--   if x > y:
--      minSoFar = min (x - y, minSoFar)
--      f (x:xs) ys minSoFar
--   if x < y: minSoFar

import Data.List

data Inf = Inf | I Int deriving (Show, Eq)

instance Ord Inf where
  compare Inf _       = GT
  compare _ Inf       = LT
  compare (I a) (I b) = compare a b

f :: [Int] -> [Int] -> Inf
f xs ys = f' (sort xs) (sort ys) Inf
  where
    f' [] _ m     = m
    f' _ [] m     = m
    f' (x:xs) (y:ys) m
      | x == y    = I 0
      | x > y     = f' (x:xs) ys (min (I (abs (x - y))) m)
      | otherwise = f' xs (y:ys) (min (I (abs (x - y))) m)

ys = [7, 8, 10, 19, 23, 127, 235] :: [Int]
xs = [1, 3, 15, 11, 2] :: [Int]
