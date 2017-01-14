q :: (Ord a) => [a] -> [a]
q [] = []
q (p:xs) = q smaller ++ [p] ++ q larger
  where smaller = [x | x <- xs, x < p]
        larger  = [x | x <- xs, x >= p]
