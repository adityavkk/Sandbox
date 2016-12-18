--  Duplicate the elements of a list.

dupli :: [a] -> [a]
dupli = foldr (\x -> (++) [x, x]) []

dupli' :: [a] -> [a]
dupli' = foldl concatDouble []
  where
    concatDouble a b = a ++ [b, b]
