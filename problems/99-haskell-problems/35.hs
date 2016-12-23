-- Determine the prime factors of a given positive integer
isqrt = floor . sqrt . fromIntegral

isPrime :: Integer -> Bool
isPrime n = (foldr f True . tillIsqrt) n
  where
    tillIsqrt n = [2..isqrt n]
    f x y = mod n x /= 0 && y

primeFactors :: Integer -> [Integer]
primeFactors n = concat [numOf n p [] | p <- [2..n], isPrime p && n `mod` p == 0]
  where
    numOf x p r
      | x `mod` p == 0 = numOf (div x p) p (p:r)
      | otherwise      = r
