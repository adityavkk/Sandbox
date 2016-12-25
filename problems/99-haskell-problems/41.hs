-- goldbachList

eratosthenes :: [Int] -> [Int]
eratosthenes [] = []
eratosthenes (n:ns) = n : eratosthenes (filter (\ x -> x `mod` n /= 0) ns)

goldbach :: Int -> (Int, Int)
goldbach n = f $ eratosthenes [2..n]
  where
    f (x:xs)
      | (n - x) `elem` xs = (x, n - x)
      | otherwise       = f xs

goldbachList :: Int -> Int -> [(Int, Int)]
goldbachList a b = [goldbach x | x <- [y | y <- [a..b], even y]]

goldbachList' a b c = filter (tupleGreater c) $ goldbachList a b
  where
    tupleGreater c (x, y) = x > c && y > c
    tupleGreater _ _      = False
