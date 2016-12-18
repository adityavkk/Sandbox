-- Run-length encoding of a list. Use the result of problem P09 to implement
-- the so-called run-length encoding data compression method. Consecutive
-- duplicates of elements are encoded as lists (N E) where N is the number of 
-- duplicates of the element E.

pack [] = []
pack [x] = [[x]]
pack (x:xs) = (x : same) : pack rest
  where
    same = take n xs
    rest = drop n xs
    n = sameAs xs x


sameAs (x:xs) y = if x == y then 1 + sameAs xs y else 0
sameAs [] y = 0

encode :: (Eq a) => [a] -> [(Int, a)]
encode = map (\x -> (length x, head x)) . pack

