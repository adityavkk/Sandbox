-- Calculate Euler's totient function phi(m) (improved)
-- phi(m) = (p1 - 1) * p1 ** (m1 - 1) * 
         -- (p2 - 1) * p2 ** (m2 - 1) * 
         -- (p3 - 1) * p3 ** (m3 - 1) * ...
-- Where ((p1 m1) (p2 m2)....) are the prime factors and their respective multiplicities

phi n = foldl f 1 (primeFactorsMult n)
  where
    f tot (p, m) = tot * (p - 1) * p ^ (m - 1)

-------------------------------------------------------------------------------

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

