-- Given a list of people with their birth and death years, implement a method to
-- compute the year with the most number of people alive. You may assume that all
-- people were born between 1900 and 2000 (inclusive). If a person was alive during
-- any portion of that year, they should be included in that year's count.

-- Approach 1:
-- bs = [12, 13, 14, 26, 26, 40]
-- ds = [25, 55, 81, 65, 62, 68]
-- f :: [Int] -> [Int] -> Int -> HM Year Int -> (Year, Int)
-- bs = sort persons birth
-- ds = sort persons death
-- bs is empty: max year hm
-- b <= d : f bs (d:ds) (c + 1) (update d +1)
-- otherwise : f (b:bs) ds (c - 1) hm

import qualified Data.HashMap.Lazy as H
import Data.List

data Person = P { born :: Int ,
                  died :: Int }

f :: [Person] -> (Int, Int)
f ps = f' (sort $ born <$> ps) (sort $ died <$> ps) 0 H.empty

f' :: [Int] -> [Int] -> Int -> H.HashMap Int Int -> (Int, Int)
f' [] _ _ hm = maxYear hm
  where maxYear = H.foldrWithKey (\ k v (y, ct) -> if ct > v
                                                   then (y, ct)
                                                   else (k, v)) (0, 0)
f' (b:bs) (d:ds) c hm
  | b <= d    = f' bs (d:ds) (c + 1) (H.alter g d hm)
  | otherwise = f' (b:bs) ds (c - 1) hm
  where g Nothing  = Just (c + 1)
        g (Just x) = Just (x + 1)

ps = [P 12 55, P 13 25, P 14 81, P 26 65, P 26 62, P 40 68]
