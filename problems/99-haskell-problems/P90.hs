-- (**) Eight queens problem
--
-- This is a classical problem in computer science. The objective is to place 
-- eight queens on a chessboard so that no two queens are attacking each other; 
-- i.e., no two queens are in the same row, the same column, or on the same diagonal.
--
-- Hint: Represent the positions of the queens as a list of numbers 1..N.
-- Example: [4,2,7,3,6,8,5,1] means that the queen in the first column is in
-- row 4, the queen in the second column is in row 2, etc. Use the
-- generate-and-test paradigm.

f :: Int -> Int -> [[Int]]
f n 1 = [[x] | x <- [1..n]]
f m n = foldr (\ x xs -> let gx = g x m n in
                         if null gx then xs
                         else gx ++ xs) [] (f m (n - 1))

g xs m n = [xs ++ [i] | i <- [1..m], isValid (enum xs) i n]

isValid xs i n = foldr (\ (x, c) v -> check (x, c) i n && v) True xs

check (xr, c) i n
  | xr == i = False
  | otherwise = diag xr c i n

diag x y i j = not $ any (\ z -> (x + z == i && y + z == j) ||
                                 (x - z == i && y + z == j)) [1..j]

enum xs = zip xs [1..]

nQueens :: Int -> [[Int]]
nQueens n = f n n
