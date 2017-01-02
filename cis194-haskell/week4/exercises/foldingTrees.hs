data Tree a = Leaf
            | Node Integer (Tree a) a (Tree a)
  deriving (Show, Eq)

foldTree :: [a] -> Tree a
foldTree = foldl f Leaf
  where
    f t v = insert (Node 1 Leaf v Leaf) t

height :: Tree a -> Integer
height Leaf = 0
height (Node h _ _ _ ) = h

insert :: Tree a -> Tree a -> Tree a
insert x Leaf = x
insert x (Node 0 l v r) = Node 1 (insert x l) v r
insert x (Node h l v r)
  | htR >= htL = Node uHtL lInsert v r
  | otherwise  = Node uHtR l v rInsert
  where
    htR = height r
    htL = height l
    lInsert = insert x l
    uHtL = max (height lInsert) (height r) + 1
    rInsert = insert x r
    uHtR = max (height r) (height rInsert) + 1
