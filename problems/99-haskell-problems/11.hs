-- Modify the result of problem 10 in such a way that if an element has no
-- duplicates it is simply copied into the result list. Only elements with
-- duplicates are transferred as (N E) lists.

data OneOrMany e = One e
                 | Many Int e
                 | None
  deriving Show

pack [] = []
pack [x] = [[x]]
pack (x:xs) = (x : same) : pack rest
  where
    same = take n xs
    rest = drop n xs
    n = sameAs xs x


sameAs (x:xs) y = if x == y then 1 + sameAs xs y else 0
sameAs [] y = 0

encode :: (Eq a) => [a] -> [OneOrMany a]
encode = map
  (\x -> if length x > 1 then Many (length x) (head x) else One (head x)) . pack

