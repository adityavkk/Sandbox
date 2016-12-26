-- Construct completely balanced binary trees
data Tree a = Empty | Branch a (Tree a) (Tree a)
  deriving (Show, Eq)

leaf x = Branch x Empty Empty

count :: Tree a -> Int
count Empty          = 0
count (Branch _ l r) = 1 + count l + count r

insert :: a -> Tree a -> Tree a
insert x Empty = leaf x
insert x (Branch y l r)
  | numL == (numR + 1) = Branch y l (insert x r)
  | otherwise          = Branch y (insert x l) r
  where
    numL = count l
    numR = count r

cbalTree :: Int -> Tree Char
cbalTree n = foldr insert Empty ['x' | _ <- [1..n]]

