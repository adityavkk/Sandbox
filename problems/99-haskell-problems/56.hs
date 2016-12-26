-- Symmetric binary trees

data Tree a = Empty | Branch a (Tree a) (Tree a)
  deriving (Show, Eq)

leaf x = Branch x Empty Empty

symmetric :: Tree a -> Bool
symmetric Empty = True
symmetric (Branch _ l r) = mirror l r
  where
    mirror Empty Empty                       = True
    mirror (Branch _ l1 r1) (Branch _ l2 r2) = mirror l1 l2 && mirror r1 r2
    mirror _ _                               = False
