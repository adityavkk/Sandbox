-- Determine the greatest common divisor of two positive integer numbers.
myGCD a b = gcd' (abs a) (abs b)

gcd' :: Int -> Int -> Int
gcd' a 0 = a
gcd' 0 b = b
gcd' a b = gcd b (a `mod` b)
