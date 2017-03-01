import qualified Data.HashMap.Lazy as T
import Data.Maybe
import Data.List
import Data.Ratio

f s = uncurry (%) (g s, h (length s))

g cs = length $ filter isPal $ substrings cs

isPal str
  | even lstr = (everyEven $ foldr i T.empty str) == 0
  | otherwise = (atMostOneOdd $ foldr i T.empty str) == 1
  where lstr = length str
        everyEven hm = length $ ys hm
        atMostOneOdd hm = length $ ys hm
        i c hm = T.alter (\ x -> if isNothing x
                                 then Just 0
                                 else Just (fromJust x + 1)) c hm
        ys hm = foldr (\ (c, v) xs -> if even v
                                    then c:xs
                                    else xs) [] (T.toList hm)

heads = scanl snoc []
snoc xs x = xs ++ [x]
h n = n * (n + 1) `div` 2
substrings = concatMap (tail . heads) . tails
