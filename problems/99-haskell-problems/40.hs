-- Goldbach's conjecture

eratosthenes :: [Int] -> [Int]
eratosthenes [] = []
eratosthenes (n:ns) = n : eratosthenes (filter (\ x -> x `mod` n /= 0) ns)

goldbach :: Int -> (Int, Int)
goldbach n = f $ eratosthenes [2..n]
  where
    f (x:xs)
      | (n - x) `elem` xs = (x, n - x)
      | otherwise       = f xs
