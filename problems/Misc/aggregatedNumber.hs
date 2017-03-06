-- we will name a number "aggregated number" if this number has the following attribute: 
-- the digits in the number can divided into several parts, and the later part 
-- is the sum of the former parts.
--
-- like 112358, because 1+1=2, 1+2=3, 2+3=5, 3+5=8 
-- 122436, because 12+24=36
-- 1299111210, because 12+99=111, 99+111=210
-- 112112224, because 112+112=224
-- so can you provide a function to check whether a number is an aggregated number

x = 5 /= 10

f :: Int -> Bool
f n = any id [try n p | p <- ps (length s)]
  where
    ps l
      | l > 1 && l < 4 = [(1, 1)]
      | otherwise      = [(i, j) | i <- [1..(l `div` 2) - 1], j <- [1..(l - i) `div` 2]]
    s  = show n
    try n (i, j)
      | length s < i                                 = False
      | length s == i + j || null s || length s == i = True
      | show ijSum == take ijSumLen (drop (i + j) s) = try nI (j, ijSumLen)
      | otherwise                                    = False
      where
        ijSum    = sum [read (take i s), read (take j (drop i s))] :: Int
        ijSumLen = (length . show) ijSum
        nI       = (read . drop i . show) n :: Int
        s        = show n
