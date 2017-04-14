-- Take an array as an argument and print the sum of all the odd numbers and
-- the sum of all the even numbers

f [] = (0, 0)
f (x:xs)
    | even x = (x + e, o)
    | otherwise = (e, o + x)
    where (e, o) = f xs

g :: [Int] -> (Int, Int)
g = foldr (\ x (e, o) -> if even x then (e + x, o) else (e, o + x)) (0, 0)

h = liftM2 (,) (sum . filter even) (sum . filter odd)

xs = [1, 2, 3, 4, 5, 6, 7, 8, 9] :: [Int]
