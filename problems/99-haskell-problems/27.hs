-- In how many ways can a group of 9 people work in 3 disjoint subgroups of 2, 
-- 3 and 4 persons? Write a function that generates all the possibilities and 
-- returns them in a list.

mapPrepend x = map (\ y -> x : y)

combs :: Int -> [a] -> [[a]]
combs 0 _      = [[]]
combs _ []     = []
combs n ss
  | n > length ss = []
combs n (s:ss) = mapPrepend s (combs (n - 1) ss) ++ combs n ss

group :: [Int] -> [String] -> [[[String]]]
group [] _ = [[]]
group _ [] = []
group (n:ns) ss =
  concatMap (uncurry mapPrepend . tupleify ss (group ns)) combN
  where
    combN = combs n ss
    tupleify l f c = (c, f (wo c l))
      where
        wo ys = filter (`notElem` ys)

x = ["aldo", "beat", "carla", "david", "evi", "flip", "gary", "hugo", "ida"]
