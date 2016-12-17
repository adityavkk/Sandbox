-- Find the K'th element of a list. The first element in the list is number 1.

elementAt :: [a] -> Int -> Maybe a
elementAt [] _     = Nothing
elementAt (x:xs) 1 = Just x
elementAt (x:xs) k = elementAt xs (k - 1)
