-- You are now to create a function that returns a Josephus permutation, taking as parameters the initial array/list of items to be permuted as if they were in a circle and counted out every k places until none remained.
--
-- For example, with n=7 and k=3 josephus(7,3) should act this way. 
-- [1,2,3,4,5,6,7] - initial sequence
-- [1,2,4,5,6,7] => 3 is counted out and goes into the result [3]
-- [1,2,4,5,7] => 6 is counted out and goes into the result [3,6]
-- [1,4,5,7] => 2 is counted out and goes into the result [3,6,2]
-- [1,4,5] => 7 is counted out and goes into the result [3,6,2,7]
-- [1,4] => 5 is counted out and goes into the result [3,6,2,7,5]
-- [4] => 1 is counted out and goes into the result [3,6,2,7,5,1]
-- [] => 4 is counted out and goes into the result [3,6,2,7,5,1,4]
--
-- [1,2,3,4,5,6,7] -> [1,2] [3,4,5,6,7] -> [1,2,3,4,5,7] [3] [4,5,6,7,1,2] -> [3,6] [7,1,2,4,5] -> [3,6,2] [4,5,7,1] -> [3,6,2,7] [1,4,5] -> [3,6,2,7,5] [1,4]
-- [1,4] 3 -> [][1,4] -> [1] ([4] ++ []) 
-- [4,5,6,7,1,2]
--
-- do len xs times:
-- prev, next = splitAt (k-1 mod $ len xs) xs
-- res ++ head next, tail next ++ prev

module Josephus where
import Data.Maybe

safeHead = maybeToList . listToMaybe
safeTail = drop 1

josephus :: [a] -> Int -> [a]
josephus xs k = fst $ foldl f ([], xs) xs
  where 
    f (result, ys) _ = let (prev, next) = splitAt (mod (k - 1) (length ys)) ys in 
                           (result ++ safeHead next, safeTail next ++ prev)













------------------------------------------- TESTS ------------------------------------------
--
xs = [1,2,3,4,5,6,7]
k = 3

main = print $ josephus xs k
