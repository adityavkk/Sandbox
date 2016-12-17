-- Find the last element of a list

myLast :: [a] -> Maybe a
myLast []     = Nothing
myLast [x]    = Just x
myLast (x:xs) = myLast xs
