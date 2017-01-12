-- Notes and workings from the Gentle Introduction to Haskell - Arrays tutorial
import Data.Ix
import Data.Array

squares = array (1, 100) [(i, i*i) | i <- [1..100]]

mkArray f bnds = array bnds [(i, f i) | i <- range bnds]

squares' = mkArray (\ i -> i * i) (1, 100)

-- With a list, where each indexing of xs takes linear time
fib n = last xs
  where
    xs = [0, 1] ++ [(xs!!(i - 1)) + (xs!!(i - 2)) | i <- [2..n]]

-- With an array, where each indexing of xs takes constant time
fib' n = xs!n
  where
    xs = array (0, n) ([(0, 1), (1, 1)] ++ [(i, xs!(i - 2) + xs!(i - 1)) | i <- [2..n]])

fibs n = a
  where
    a = array (0, n) ([(0, 1), (1, 1)] ++ [(i, a!(i - 2) + a!(i - 1)) | i <- [2..n]])

-- Accumulation, a way to specify what happens when you have repeated indices
hist bnds is = accumArray (+) 0 bnds [(i, 1) | i <- is, inRange bnds i]

-- Incremental Array Update function
-- To change value stored at index i in array arr, you have arr // i


