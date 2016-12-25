-- Given a range of integers by its lower and upper limit, construct a list of
-- all prime numbers in that range.

primesR :: Int -> Int -> [Int]
primesR a b = dropWhile (< a) $ eratosthenes [2..b]

eratosthenes :: [ Int ] -> [Int]
eratosthenes [] = []
eratosthenes (n:ns) = n : eratosthenes (filter (\ x -> x `mod` n /= 0) ns)
