-- a) We suppose that a list contains elements that are lists themselves.
-- The objective is to sort the elements of this list according to their
-- length. E.g. short lists first, longer lists later, or vice versa.
import Data.Maybe
import Data.List

qsort' :: ([a] -> Int) -> [[a]] -> [[a]]
qsort' _ [] = []
qsort' f (x:xs) = qsort' f sm ++ [x] ++ qsort' f lg
  where
    sm = [y | y <- xs, f y < f x]
    lg = [y | y <- xs, f y >= f x]

lsort = qsort' length

-- b) Again, we suppose that a list contains elements that are lists themselves. 
-- But this time the objective is to sort the elements of this list according 
-- to their length frequency; i.e., in the default, where sorting is done 
-- ascendingly, lists with rare lengths are placed first, others with a more 
-- frequent length come later.

lfsort :: [[a]] -> [[a]]
lfsort = concat . lsort . groupBy (\ x y -> length x == length y) . lsort

-- Using a frequency association list of lengths
lfsort' :: (Eq a) => [[a]] -> [[a]]
lfsort' = qsort' f
  where
    f x = fromJust $ lookup (length x) lfTable
      where
       lfTable = foldl f1 [] (map length xs)
         where
           f1 lft x
             | isNothing lu = (x, 1) : lft
             | otherwise    = (x, v + 1) : delete (x, v) lft
             where
               lu = lookup x lft
               v  = fromJust lu

xs = ["abc", "de", "fgh", "de", "ijkl", "mn", "o"]
--lfsort xs = ["ijkl","o","abc","fgh","de","de","mn"]

