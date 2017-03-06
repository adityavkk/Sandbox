
f :: [Int] -> Int

f xs = fst $ foldr
  (\ x (gm, msf) -> (max gm msf, max x (msf + x)))
  (mx, head xs)
  (tail xs)
    where mx = maximum xs
