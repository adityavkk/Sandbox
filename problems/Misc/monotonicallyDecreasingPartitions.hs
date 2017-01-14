f 0 _ = [[]]
f s h
  | g h < s   = []
  | otherwise = concatMap g1 [1..h-1]
  where
    g x = (x * (x - 1)) `div` 2
    g1 x = map (x:) (f (s - x) x)

g n = f n n
