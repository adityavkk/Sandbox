-- By definition, a surpasser of an element of an array is a greater element to
-- the right, so x[j] is a surpasser of x[i] if i < j and x[i] < x[j]. The 
-- surpasser count of an element is the number of its surpassers.
-- Compute the maximum surpasser count of an array length n > 1 and do so
-- with a O(n log n) algorithm.

-- Specification, brute force
-------------------------------------------------------------------------------
msc' :: Ord a => [a] -> Int
msc' = maximum . map scount . tails

scount (y:ys) = length $ filter (y <) ys

tails [] = []
tails (x:xs) = (x:xs) : tails xs

-- The brute force algorithm is Quadratic

-- The divide and conquer algorithm:
-------------------------------------------------------------------------------
-- Similar to how one can reason about the merge sort algorithm by assuming
-- that each sub-list to be merged is sorted, and devise a merge sub-routine for them
-- that is linear, we can reason about the msc algorithm by assuming
-- that if each of the sub-lists is sorted and each element is packaged in a tuple
-- with the number of elements larger than it that came after it in the original
-- ordering.

-- Given such association sublists i.e. sorted and packaged with each elements
-- respective surpasser count in the original ordering, we can devise a join
-- sub-routine in linear time that preserves sorting and the surpasser counts
-- of each element in the original ordering.

type Table a = [(a, Int)]

msc :: Ord a => [a] -> Int
msc = maximum . map snd . table

-- table xs = join (table ys) (table zs) --> where ys and zs are half the size of xs
table :: Ord a => [a] -> Table a
table [x] = [(x, 0)]
table xs = join (m - n) (table ys) (table zs)
    where m        = length xs
          n        = m `div` 2
          (ys, zs) = splitAt n xs
          -- we introduce m and n so that we can keep track of the number of
          -- elements larger than the element in question for the join fn
          -- and also to remove having to calculate lenghts every time

join :: Ord a => Int -> Table a -> Table a -> Table a
join _ txs [] = txs
join _ [] tys = tys
join i txs@((x, c):txs') tys@((y, d):tys')
  | x < y  = (x, c + i) : join i txs' tys
  | x >= y = (y, d) : join (i - 1) txs tys'

  -- if x < y, then we know that everything left in tys, and by extension in ys,
  -- is greater than x since each list is sorted. Therefore, the num of successors
  -- of x in the original ordering of (xs ++ ys) is num of successors of x in xs +
  -- all the elements of ys i.e. i
  -- We also cons the new (x, c + 1) onto the rest of the join sub-routine to
  -- maintain the sorted order of the table that join returns, similar to merge sort

  -- if x >= y, then we know that d, the num of successors of y in ys remains the same
  -- because all the rest of the elements in xs after x are greater than y (b/c sorted)
  -- Therefore, we can cons (y, d) onto join (i - 1) txs tys' (i - 1) b/c tys now has
  -- one less element.
