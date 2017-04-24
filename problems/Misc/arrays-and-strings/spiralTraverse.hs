-- Traverse a matrix of integers from the top left in a spiral and return the elements
-- in that order
--
--  [ [1, 2, 3],
  --  [4, 5, 6],
  --  [7, 8, 9]
  --]
-- output: [1, 2, 3, 6, 9, 8, 7, 4, 5]

-- R - D - L - U
-- (0, 0) -> (0, m') -> (n', m') -> (n', 0) ->
-- (1, 0) -> (1, m'') -> (n'', m'') -> (n'', 1)
-- (2, 1)

-- f :: Matrix -> [Int]
-- Go right starting at (0, 0)
-- right :: Matrix -> Start -> Iters -> [Int] -> [Int]
  -- end = (startX, width - 1 - iters)
  -- if end < start: Nothing
  -- else: call down with iters and all x in matrix from start to end
-- down :: Matrix -> Start -> Iters -> [Int] -> [Int]
  -- end = (length - 1 - iters, startY)
  -- if end < start: soFar
  -- else: call left with iters all x in matrix from start to end
-- left :: Matrix -> Start -> Iters -> [Int] -> [Int]
  -- end = (startX, iters)
  -- if end < start: soFar
  -- else: call up with iters and all x in matrix from start to end
-- up :: Matrix -> Start -> Iters -> [Int] -> [Int]
  -- end = (iters + 1, startY)
  -- if end < start: soFar
  -- else: call right with iters + 1 & all x in matrix from start to end

type Matrix = [[Int]]
type Pos = (Int, Int)

get :: Matrix -> Pos -> Pos -> [Int]
get [[]] _ _ = []
get [] _ _= []
get mat (x, y) (x', y')
  | x' < x =  tail [mat !! i !! y | i <- [x, (x - 1)..x']]
  | y' < x =  tail [mat !! x !! j | j <- [y, (y - 1)..y']]
  | x' > x =  tail [mat !! i !! y | i <- [x..x']]
  | y' > y =  tail [mat !! x !! j | j <- [y..y']]

f :: Matrix -> [Int]
f [] = []
f [[]] = []
f mat = x : right mat (0, 0) 0 []
  where
    len = length mat
    wid = length $ head mat
    x = head . head $ mat

    right mat (x, y) i ys
      | ey <= y    = ys
      | otherwise = down mat (ex, ey) i (ys ++ get mat (x, y) (ex, ey))
      where (ex, ey) = (x, wid - 1 - i)

    down mat (x, y) i ys
      | ex <= x    = ys
      | otherwise = left mat (ex, ey) i (ys ++ get mat (x, y) (ex, ey))
      where (ex, ey) = (len - 1 - i, y)

    left mat (x, y) i ys
      | ey >= y    = ys
      | otherwise = up mat (ex, ey) i (ys ++ get mat (x, y) (ex, ey))
      where (ex, ey) = (x, i)

    up mat (x, y) i ys
      | ex >= x    = ys
      | otherwise = right mat (ex, ey) (i + 1) (ys ++ get mat (x, y) (ex, ey))
      where (ex, ey) = (i + 1, y)

xxs = [[1..4],
       [5..8],
       [10..13]] :: Matrix
