sieveSundaram :: Integer -> [Integer]
sieveSundaram n = (map ((+ 1) . (* 2)) . filter f) [1..n]
  where
    f = flip notElem table
      where
        table = [g i j | i <- [1..div n 2], j <- [i..div n 2], g i j <= n]
          where
            g i j = i + j + 2 * i * j
