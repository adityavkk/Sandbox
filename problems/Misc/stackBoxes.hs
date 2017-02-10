-- Given boxes each with a (h, w, d) what is the height of the tallest stack
-- you can make if you can only stack smaller boxes on top of bigger boxes

data Box = B { h :: Int
             , w :: Int
             , d :: Int
             } deriving (Show, Eq)

instance Ord Box where
  B h0 w0 d0 `compare` B h1 w1 d1
    | h0 > h1 && w0 > w1 && d0 > d1 = GT
    | h0 < h1 && w0 < w1 && d0 < d1 = LT
    | otherwise                     = EQ

f :: [Box] -> Box -> Int
f [] b  = h b
f [a] b
  | a < b = h a + h b
  | otherwise = h b
f bs b  = (maxHeight $ fst (g bs b)) + h b

g :: [Box] -> Box -> ([Box], Box)
g bs b = ([bx | bx <- bs, bx < b], b)

maxHeight :: [Box] -> Int
maxHeight bs = maximum (map (uncurry f . g bs) bs)

boxes = [B 3 2 1, B 101 0 0, B 100 3 12]
