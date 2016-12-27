-- Generate all the valid parenthesis permutations that can be made from n pairs

-- Using a fold
balancedParens' :: Int -> [String]
balancedParens' n0 = ext n0 ((n0 * 2) - 1) ["("]
  where
    ext _ 0 xs = xs
    ext n c xs = ext n (c - 1) $ foldl (\ ps x -> f x ++ ps) [] xs
      where
        f x
          | s > 0 && s == c  = [x ++ ")"]
          | s >= 0 && s < n  = [x ++ "(", x ++ ")"]
          | s == n           = [x ++ ")"]
          | otherwise        = []
          where
            s = sum $ map pTrans x
            pTrans '(' = 1
            pTrans ')' = -1

balancedParens'' n = f n n [""]
  where
    f 0 0 xs = xs
    f 0 c (x:xs) = f 0 (c - 1) ((x ++ ")") : xs)
    f o c (x:xs)
      | o == c    = f (o - 1) c ((x ++ "(") : xs)
      | otherwise = f (o - 1) c ((x ++ "(") : xs) ++ f o (c - 1)  ((x ++ ")") : xs)
