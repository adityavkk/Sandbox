-- Given an array of integers, write a method to find indices m and n such that if
-- you sorted elements m through n, the entire array would be sorted. Minimize n - m
-- xs = [1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19]
-- output: (3, 9)

-- f :: [Int] -> (Int, Int)
  -- mn = postMin xs
  -- mx = reverse (preMax xs)
  -- start = first index of xs where xs[i] > mn[i]
  -- end = length - (first index of (reverse xs) where xs[i] < mx[i] + 2)

f :: [Int] -> (Int, Int)
f xs = (start xs 0, len - (end rxs 0 + 1))
  where mn    = postMin xs
        mx    = postMax rxs
        rxs   = reverse xs
        len   = length xs

        start [] i                   = i
        start (x:xs) i | x > mn !! i = i
                       | otherwise   = start xs (i + 1)

        end [] i                   = i
        end (x:xs) i | x < mx !! i = i
                     | otherwise   = end xs (i + 1)

postMax = post (>)
postMin = post (<)

post :: Num a => (a -> a -> Bool) -> [a] -> [a]
post fn = fst . foldr (\ x (mn, l) -> case l of
                                        Nothing -> (x:mn, Just x)
                                        Just y  -> if fn y x
                                                   then (y:mn, Just y)
                                                   else (y:mn, Just x)
                                        ) ([], Nothing)

xs = [1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19] :: [Int]
ys = [1, 2, 3, 5, 7, 8, 4, 10, 9, 12, 19, 20] :: [Int]
