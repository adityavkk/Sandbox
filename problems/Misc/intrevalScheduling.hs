-- we have a set of n requests the i th request corresponds
-- to an interval of time starting at si and finishing at fi, i.e. it spans the
-- interval [si, fi]. Suppose that a subset of the requests is
-- compatible if no two of them overlap in time; find the largest compatible
-- subset of any set of requests in a reasonable number of steps.
-- Example: Given 3 requests [[1, 3], [2, 4], [3, 5]] the maximum-size subset
-- of compatible requests is [1, 3].

-- Approach 1:
-- Pick r that ends earliest ++ f (all rs that start later than r ends)
  -- O (n^2)

-- Approach 2:
-- Sort by end time
-- Fold over rs
     -- keep going if current r starts before last picked r ends
     -- pick r
-- O (n log n)

import Data.List

f :: [(Int, Int)] -> [(Int, Int)]
f [] = []
f rs = foldl (\ cs@((_, f'):_) r@(s, _) -> if s <= f'
                                           then cs
                                           else r:cs) [r'] rs'
  where (r':rs') = sortBy (\ (_, f) (_, f') -> compare f f') rs
