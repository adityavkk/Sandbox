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
cs = [10, 20, 6, 8, 1, 3, 12] :: [Int]
