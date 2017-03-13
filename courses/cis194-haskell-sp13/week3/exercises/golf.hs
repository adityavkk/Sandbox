import Data.Maybe
import Data.List
-- Exercise 1 Hopscotch

skips :: [a] -> [[a]]
skips xs = map (\(_, i) -> map fst $ filter (\(_, j) -> j `mod` i == 0) enum) enum
  where
    enum = zip xs [1..]

-- Exercise 2 Local Maxima

localMaxima :: [Integer] -> [Integer]
localMaxima (x:y:z:xs)
  | y > z && y > x = y : localMaxima (z:xs)
  | otherwise = localMaxima (y:z:xs)
localMaxima _ = []

-- Exercise 3 Histogram

mode :: [Int] -> [(Int, Int)]
mode = addMissing . foldl uMode []
  where
    l = lookup
    addMissing :: [(Int, Int)] -> [(Int, Int)]
    addMissing ys = map (\x -> (x, fromMaybe 0 (l x ys))) [0..9]
    uMode m x
      | isNothing lu = (x, 1) : m
      | otherwise = (x, pv + 1) : deleteBy (\a b -> fst a == fst b) (x, pv) m
      where
        pv = fromJust lu
        lu = l x m

histogram :: [Int] -> String
histogram = intercalate "\n" . reverse . ("==========\n0123456789" :) . transpose . normMax . map f . mode
  where
    f (_, x) = gen x '*'
    gen x c = map (const c) [1..x]
    normMax xs = map (\x -> x ++ gen (m - length x) ' ') xs
      where
        m = length $ minimumBy len xs
          where
            len a b
              | length a < length b = GT
              | otherwise           = LT
