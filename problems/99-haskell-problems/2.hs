-- Find the last but one element of a list.

myButLast :: [a] -> Maybe a
myButLast []     = Nothing
myButLast [x, _] = Just x
myButLast (x:xs) = myButLast xs
