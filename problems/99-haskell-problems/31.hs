-- Determine whether a given integer number is prime.

-- isqrt oscillates for all n for which n + 1 is a perfect square
isqrt' :: Integer -> Integer
isqrt' n = try n 1 n

try :: Integer -> Integer -> Integer -> Integer
try n oldGuess guess
  | goodEnough oldGuess guess = guess
  | otherwise                 = try n guess $ improve guess
  where
    goodEnough o n = abs (o - n) < 1
    improve g      = div (g + n `div` g) 2

-------------------------------------------------------------

isqrt = floor . sqrt . fromIntegral

isPrime :: Integer -> Bool
isPrime n = (foldr f True . tillIsqrt) n
  where
    tillIsqrt n = [2..isqrt n]
    f x y = mod n x /= 0 && y
