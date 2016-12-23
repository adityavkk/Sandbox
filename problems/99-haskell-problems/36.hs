-- Determine the prime factors of a given positive integer
-- Construct a list containing the prime factors and their multiplicity

isqrt = floor . sqrt . fromIntegral

isPrime :: Integer -> Bool
isPrime n = (foldr f True . tillIsqrt) n
  where
    tillIsqrt n = [2..isqrt n]
    f x y = mod n x /= 0 && y

primeFactorsMult :: Integer -> [(Integer, Integer)]
primeFactorsMult n = [numOf n p (p, 0) | p <- [2..n], isPrime p && n `mod` p == 0]
  where
    numOf x p r
      | x `mod` p == 0 = numOf (div x p) p (fst r, snd r + 1)
      | otherwise      = r
