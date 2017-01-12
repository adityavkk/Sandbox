f 1 = 0
f 2 = 1
f n
  | even n    = f (n `div` 2) + 1
  | otherwise = minimum [f (n - 1), f (n + 1)] + 1
