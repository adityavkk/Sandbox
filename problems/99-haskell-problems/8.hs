-- Eliminate consecutive duplicates of list elements.
-- If a list contains repeated elements they should be replaced with a single 
-- copy of the element. The order of the elements should not be changed.

compress :: (Eq a) => [a] -> [a]
compress []     = []
compress [a]    = [a]
compress (x:xs) = x : compress (dropTill xs x)
  where
    dropTill [] k = []
    dropTill (x:xs) k
      | x == k = dropTill xs k
      | otherwise = x:xs
