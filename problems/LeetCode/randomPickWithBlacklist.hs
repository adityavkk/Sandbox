-- Given a blacklist B containing unique integers from [0, N), write a function to return a uniform random integer from [0, N) which is NOT in B.

-- Optimize it such that it minimizes the call to system’s Math.random().

-- Approach:
-- Define a bijection f between [0, N) and all the allowed numbers
-- Use system.random to generate random number in range [0, m) where m is total number of allowed numbers

import qualified Data.HashSet as Set
import qualified Data.HashMap.Strict as Map
import Data.Maybe
import System.Random
import Prelude hiding (max)


xs = [4, 5, 2, 9, 98, 48, 294, 100, 97, 43, 120, 84, 211, 298, 101]
n  = 300

max             = n - length xs
(lefts, rights) = span (< max) xs
left            = Set.fromList lefts
right           = Set.fromList $ rights
rightAllowed    = [i | i <- [max .. n], not $ Set.member i right]
leftMapping     = Map.fromList $ zip lefts rightAllowed

f :: Int -> Maybe Int
f x
    | Set.member x left = Map.lookup x leftMapping
    | x <= max          = Just x
    | otherwise         = Nothing
        
main :: IO Int
main = do
    r <- randomRIO (0, max)
    return $ fromJust $ f r