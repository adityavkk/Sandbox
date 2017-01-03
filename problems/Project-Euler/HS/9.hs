abc :: [(Float, Float, Float)]
abc = [(a, b, c a b) | a <- frange 0 999, b <- frange a 1000, a + b + c a b == 1000]
  where c a b = sqrt $ a^^2 + b ^^ 2

frange i j = f i j [i]
  where f i j r
          | i >= j = r
          | otherwise = f next j (r ++ [next])
          where next = i + 1.0
