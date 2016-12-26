-- Binary search trees

data BST a = Empty | Branch a (BST a) (BST a)
  deriving (Show, Eq)

leaf n = Branch n Empty Empty

insert :: Int -> BST Int -> BST Int
insert n Empty          = Branch n Empty Empty
insert n (Branch a l r)
  | n > a     = Branch a l (insert n r)
  | otherwise = Branch a (insert n l) r

construct :: [Int] -> BST Int
construct = foldr insert Empty

symmetric :: BST a -> Bool
symmetric Empty = True
symmetric (Branch _ l r) = mirror l r
  where
    mirror Empty Empty                       = True
    mirror (Branch _ l1 r1) (Branch _ l2 r2) = mirror l1 l2 && mirror r1 r2
    mirror _ _                               = False
