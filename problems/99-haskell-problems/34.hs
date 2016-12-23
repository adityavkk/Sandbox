-- Calculate Euler's totient function phi(m).
-- Euler's so-called totient function phi(m) is defined as the number of 
-- positive integers r (1 <= r < m) that are coprime to m.

coPrime a b = gcd a b == 1

totient :: Int -> Int
totient x = length [y | y <- [1..x], coPrime x y]

---------------------------------------------------------------------------
-- Closed form 

isqrt = floor . sqrt . fromIntegral

isPrime :: Integer -> Bool
isPrime n = (foldr f True . tillIsqrt) n
  where
    tillIsqrt n = [2..isqrt n]
    f x y = mod n x /= 0 && y

distinctPf :: Integer -> [Integer]
distinctPf n = [p | p <- [2..n], isPrime p && n `mod` p == 0]
