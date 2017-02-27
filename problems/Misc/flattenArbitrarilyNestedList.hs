data AList = I Int | R [AList]
  deriving (Show, Eq)

xs = R [I 1, R [R [I 2, I 3]], R [I 4, R [I 5, R [I 6]]]]
ys = R [I 1]

flatten :: AList -> [Int]
flatten (I x)      = [x]
flatten (R [])     = []
flatten (R (x:xs)) = flatten x ++ flatten (R xs)
