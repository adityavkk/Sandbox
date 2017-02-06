-- In a matrix, black is represented by 0 and white by 1. Return all the
-- (x, y) coordinates of the top left corner of the black rectangles

import qualified Data.HashSet as S
import Data.Hashable
import Data.Maybe

data Pixel a = P { val :: a
                 , cor :: (Int, Int)
                 } deriving (Show, Eq)

type Cor = (Int, Int)

t :: [[a]] -> [[Pixel a]]
t xs = map (\ (x, i) -> zipWith (\ a b -> P a (i, b)) x [0..]) $ zip xs [0..]

pLookup :: Eq a => a -> [Pixel a] -> Maybe (Pixel a, [Pixel a])
pLookup _ [] = Nothing
pLookup a (p@(P a' _):ps)
  | a == a'   = Just (p, ps)
  | otherwise = pLookup a ps

f :: [[Int]] -> [(Int, Int)]
f rs = map cor $ snd $ foldl g (S.empty, []) pixels
  where
    pixels = t rs
    g s'@(s, xs) ps
      | isNothing plup        = s'
      | not (S.member pCor s) = g r rPs
      | otherwise             = g s' rPs
        where
          plup = pLookup 0 ps
          p    = fst $ fromJust plup
          rPs  = snd $ fromJust plup
          pCor = cor p
          nSet = addRect s pCor pixels
          r    = (nSet, p:xs)

addRect :: (Num a, Eq a) => S.HashSet Cor -> Cor -> [[Pixel a]] -> S.HashSet Cor
addRect s (i, j) rs =
  S.fromList [(i', j') | i' <- [i..i+rows-1], j' <- [j..j+cols-1]] `S.union` s
  where
    rows = cR i j rs 0
      where
        cR i j rs c
          | val (rs !! i !! j) /= 0 = c
          | otherwise         = cR (i + 1) j rs (c + 1)
    cols = cC i j rs 0
      where
        cC i j rs c
          | val (rs !! i !! j) /= 0 = c
          | otherwise         = cC i (j + 1) rs (c + 1)

