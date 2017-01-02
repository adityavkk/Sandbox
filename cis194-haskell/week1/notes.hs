hailstone :: Integer -> Integer
hailstone n
  | n `mod` 2 == 0 = n `div` 2
  | otherwise      = (3 * n) + 1

hailstoneSeq :: Integer -> [Integer]
hailstoneSeq 1 = [1]
hailstoneSeq n = n : hailstoneSeq (hailstone n)

-- Compute the length of a list of integers
inListLength :: [Integer] -> Integer
inListLength []     = 0
inListLength (x:xs) = 1 + inListLength xs

-- Nested patterns
sumEveryTwo :: [Integer] -> [Integer]
sumEveryTwo []       = []
sumEveryTwo [x]      = [x]
sumEveryTwo (x:y:zs) = (x + y) : sumEveryTwo zs


