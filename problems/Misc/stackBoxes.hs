-- Given boxes each with a (h, w, d) what is the height of the tallest stack
-- you can make if you can only stack smaller boxes on top of bigger boxes

import qualified Data.HashMap.Lazy as M
import Data.Hashable
import Data.List

data Box a = Nil |
             B { h :: a
               , w ::  a
               , d ::  a
               } deriving (Show, Eq)

instance (Ord a) => Ord (Box a) where
  B h0 w0 d0 `compare` B h1 w1 d1
    | h0 > h1 && w0 > w1 && d0 > d1 = GT
    | h0 < h1 && w0 < w1 && d0 < d1 = LT
    | otherwise                     = EQ

instance (Integral a, Show a) => Hashable (Box a) where
    hash Nil          = hash ""
    hash (B a1 a2 a3) = hash (show a1 ++ "," ++ show a2 ++ "," ++ show a3)
    hashWithSalt n b  = hash b * n

f' :: [Box Int] -> Box Int -> Int
f' [] b  = h b
f' [a] b
  | a < b = h a + h b
  | otherwise = h b
f' bs b  = (maxHeight $ fst (g bs b)) + h b

g :: [Box Int] -> Box Int -> ([Box Int], Box Int)
g bs b = ([bx | bx <- bs, bx < b], b)

mH bs = memo M.! (bs, Nil)
  where
    memo = foldr f M.empty (bs, Nil)

maxHeight :: [Box Int] -> Int
maxHeight bs = maximum (map (uncurry f' . g bs) bs)

boxes = [B 3 2 1, B 101 0 0, B 100 3 12]
mp = M.fromList [(boxes !! 1, 2), (boxes !! 2, 3)] :: M.HashMap (Box Int) Int
