-- Given an -digit positive integer, count and print the number of
-- subsequences formed by concatenating the given number's digits that are
-- divisible by . As the result can be large, print the result modulo 10^9 + 7

import Control.Arrow
import Data.List hiding (tails)

d :: Integer -> Bool
d 0 = False
d n = (== 0) . (`mod` 8) $ n

toList :: Integer -> [Integer]
toList = map (read . (: [])) . show

fromList :: [Integer] -> Integer
fromList = read . (>>= show)

c :: Integer -> Integer -> Integer
c n k = fact n `div` (fact (n - k) * fact k)
  where
    fact :: Integer -> Integer
    fact 0 = 1
    fact n = product [1..n]

numSS :: [Integer] -> Integer
numSS xs = sum . map (c n) $ [1..n]
  where n = toInteger $ length xs

-- All the subsequences of length 3 that are div by 8 starting with first number
threeSS :: [Integer] -> [Integer]
threeSS (x:xs) = filter d $ map fromList $ (\ ys -> x:ys) <$> (nub $ twoSS xs)

twoSS :: [Integer] -> [[Integer]]
twoSS xs = zip xs (tail $ tails xs) >>= (\ (y, ys) -> map (\ y' -> [y, y']) ys) 

f n = one + two + threeOrMore
  where
    one   = undefined
    two   = undefined
    threeOrMore = (sum . map g . filter (\ (_, xs) -> length xs >= 3) . zipHT) n
    zipHT       = uncurry zip . (heads &&& tails) . toList

    g :: ([Integer], [Integer]) -> Integer
    g (xs, ys) = numSS xs * numThree + numThree
      where numThree = toInteger (length (filter d $ threeSS ys))

heads :: [a] -> [[a]]
heads = scanl snoc []
  where snoc xs x = xs ++ [x]

tails :: [a] -> [[a]]
tails = foldr (\ x ts@(t:_) -> (x:t):ts) [[]]

