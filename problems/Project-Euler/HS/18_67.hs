import qualified Data.HashMap.Lazy as M

---------------------- Bottom-up with a fold ---------------------------

f :: [[Int]] -> Int
f xs = head (foldr g [] xs)
  where
    g ys []           = ys
    g (y:ys) (m:n:ms) = (y + max m n) : g ys (n:ms)


------------------- Top-Down with Hash-Map Memoization ----------------

f' :: [[Int]] -> Int
f' xs = lup memo (0,0)
  where
    hm   = pHM xs
    memo = M.fromList [((i, j), g (i, j)) | i <- [0..lxs], j <- [0..i]]
      where lxs = length xs
    g :: (Int, Int) -> Int
    g (i, j)
      | i == length xs - 1 = x
      | otherwise          = max (lup memo ((i + 1),  j)) (lup memo ((i + 1), (j + 1))) + x
        where x = hm M.! (i, j)

lup = (M.!)

pHM :: [[Int]] -> M.HashMap (Int, Int) Int
pHM xs = M.fromList [((i, j), xs !! i !! j) | i <- [0..lxs], j <- [0..i]]
  where
    lxs = length xs - 1

t'' :: IO [[Int]]
t'' = readFile "./pyramid.txt" >>= parse
  where
    parse :: String -> IO [[Int]]
    parse s = return $ map (\ l -> map read $ words l) $ lines s

main = f' <$> t'' >>= print

----------------------- Sample Pyramids --------------------------------

t :: [[Int]]
t = [[3],
     [7, 4],
     [2, 4, 6],
     [8, 5, 9, 3]]

t' :: [[Int]]
t' = [[75],
  [95, 64],
  [17, 47, 82],
  [18, 35, 87, 10],
  [20, 04, 82, 47, 65],
  [19, 01, 23, 75, 03, 34],
  [88, 02, 77, 73, 07, 63, 67],
  [99, 65, 04, 28, 06, 16, 70, 92],
  [41, 41, 26, 56, 83, 40, 80, 70, 33],
  [41, 48, 72, 33, 47, 32, 37, 16, 94, 29],
  [53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14],
  [70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57],
  [91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48],
  [63, 66, 04, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31],
  [04, 62, 98, 27, 23, 09, 70, 98, 73, 93, 38, 53, 60, 04, 23]]
