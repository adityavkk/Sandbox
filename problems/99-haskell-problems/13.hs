data OneOrMany e = None
                 | One e
                 | Many Int e
  deriving Show

encode :: (Eq a) => [a] -> [OneOrMany a]
encode [] = []
encode (x:xs) = oneOrMany x n : encode (drop n xs)
  where
    n = numOf x xs
    numOf y [] = 0
    numOf y (x:xs)
      | x /= y = 0
      | otherwise = 1 + numOf y xs
    oneOrMany x n
      | n == 0 = One x
      | otherwise = Many (n + 1) x

