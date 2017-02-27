import Data.Maybe
-- given a list xs return if 3 elements in the list satisfy the 132 condition
-- i.e. for some i < j < k, there exist xi < xk < xj
-- [1,2,3,4] -> False
-- [3,1,4,2] -> True

snd' (_, a, _, _) = a

f ns = r || not (isNothing xi || isNothing xk) && fromJust xi < fromJust xk
  where
  (_, r, xi, xk) = foldl g ([], False, Nothing, Nothing) $ reverse ns

  g true@(_, True, _, _) _       = true
  g (xjs, r, Nothing, xk) x      = (xjs, r, Just x, xk)
  g (xjs, r, Just xi, Nothing) x = (xjs', r, Just x, xk')
    where
      (xjs', xk') = minsRemoved xjs xi Nothing
  g (xjs, r, Just xi, xk) x
    | x < xkv || xi < xkv = (xjs, True, Just x, xk)
    | otherwise           = (xjs', r, Just x, xk')
    where
      (xjs', xk') = minsRemoved xjs xi xk
      xkv = fromJust xk

minsRemoved [] y xk = ([y], xk)
minsRemoved (x:xs) y xk
  | x < y     = minsRemoved xs y (Just x)
  | otherwise = (y:x:xs, xk)

xs = [1,2,3,4] :: [Int]
ys = [3,1,4,2] :: [Int]
zs = [ 9, 11, 8, 9, 10, 7, 9 ] :: [Int]
as = [1,0,1,-4,-3] :: [Int]
bs = [0, 1,3,2,10] :: [Int]
cs = [10, 20, 6, 8, 1, 3, 12, 20] :: [Int]

-- Not working (attempt at a top down approach)

f' :: [Int] -> [(Int, Int, Int)]
f' xs = zip3 (pMinl xs) xs (pMinr xs)
  {- where -}
    {- g = foldr (\ (mx, x, mn) r -> (mn < x && mx < mn) || r) False -}

pMinl [] = []
pMinl (x:xs) = reverse $ fst $ foldl 
  (\(ys, x) x' -> if x' < x then (x:ys, x') else (x:ys, x)) ([x], x) xs

pMinr [] = []
pMinr xs = fst $ foldr
  (\ x' (ys, x) -> case x of
                     Nothing -> (x':ys, Just x')
                     Just y  -> if y < x'
                                then (y:ys, Just y)
                                else (y:ys, Just x')) ([], Nothing) xs
  
