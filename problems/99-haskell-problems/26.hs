-- Generate the combinations of K distinct objects chosen from the N elements 
-- of a list
import Data.List

perms :: (Eq a) => Int -> [a] -> [[a]]
perms 1 xs = map (: []) xs
perms _ [] = [[]]
perms n xs = concatMap (\x -> consMap x (perms (n - 1) (delete x xs))) xs
  where
    consMap x = map (x:)

combs' :: Int -> [a] -> [[a]]
combs' 0 _ = [[]]
combs' _ [] = []
combs' n (x:xs) = map (x:) (combs' (n-1) xs) ++ (combs' n xs)
