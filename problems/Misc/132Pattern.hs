-- given a list xs return if 3 elements in the list satisfy the 132 condition
-- i.e. for some i < j < k, there exist xi < xk < xj
-- [1,2,3,4] -> False
-- [3,1,4,2] -> True

trd (_, _, a) = a

f :: [Int] -> Bool
f ns = snd $ foldl g ([], False) $ reverse ns
  where
    g ([], r) x = ([x], r)
    g ([y], r) x 
      | x > y = ([x, y], r)
      | otherwise = ([y], r)
    g (xs@(y:z:_), r) x
      | r || x < z = (xs, True)
      | x > y      = (x:xs, r)
      | otherwise  = (xs, r)

xs = [1,2,3,4] :: [Int]
ys = [3,1,4,2] :: [Int]
zs = [ 9, 11, 8, 9, 10, 7, 9 ] :: [Int]
as = [1,0,1,-4,-3] :: [Int]
