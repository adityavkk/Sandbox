-- Find the number of elements of a list.

myLength :: [a] -> Int
myLength [] = 0
myLength (x:xs) = 1 + myLength xs

myLength' :: [a] -> Int
myLength' = sum . map (\_ -> 1)
