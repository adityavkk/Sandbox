-- Given a run-length code list generated as specified in problem 11. 
-- Construct its uncompressed version.

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

flatten :: [[a]] -> [a]
flatten [[]] = []
flatten ([]:xs) = flatten xs
flatten (x:xs) = head x : flatten (tail x : xs)

decode :: (Eq a) => [OneOrMany a] -> [a]
decode = flatten . map decoder
  where
    decoder None = []
    decoder (One e) = [e]
    decoder (Many n e) = if n == 1 then [e] else e : decoder (Many (n - 1) e)

