-- You are building a diving board by placing a bunch of planks of wood end-to-end
-- There are two types of planks, one of length shorter and one of length longer.
-- You must use exactly K planks of wood. Write a method to generate all possible
-- lengths for the diving board.

-- Brute Force: 2^K
-- f :: Shorter -> Longer -> K -> [Length]
-- f' s 1 ++ f' l 1

-- f' :: CurrentLength -> PlanksUsed -> [Length]
-- pUsed == k: [c]
-- pUsed == k - 1: [c + s, c + l]
-- otherwise = f' (c + s) (pUsed + 1) ++ f' (c + l) (pUsed + 1)
--
-- Optimized: How many ways are there of using s, l to make k boards?
-- map (\ (ns, nl) -> ns * s + nl * l) [(numS, k - numS) | numS <- [0..k]]
-- O (k)


f :: Int -> Int -> Int -> [Int]
f s l k = map (\ (ns, nl) -> ns * s + nl * l) [(i, k - i) | i <- [0..k]]
