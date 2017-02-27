-- In a precise technical sense, folds and unfolds are the natural patterns of computation over recursive
-- datatypes; unfolds generate data structures and folds consume them.

data List a = Nil | Cons a (List a)
  deriving (Show, Eq)

wrap :: a -> List a
wrap a = Cons a Nil

nil :: List a -> Bool
nil Nil        = True
nil (Cons _ _) = False

list :: [a] -> List a
list = foldr Cons Nil

-- The natural fold for lists (the L is for List not for left and is equivalent to foldr in Haskell)
foldL :: (a -> b -> b) -> b -> List a -> b
foldL f e Nil         = e
foldL f e (Cons x xs) = f x (foldL f e xs)

-- Universal property of folds
-- h = foldL f e
-- is equivalent to
-- h xs = case xs of
--          Nil       -> e
--          Cons y ys -> f y (h ys)

-- Exercise 3.2
mapL :: (a -> b) -> List a -> List b
mapL f = foldL (\ x ys -> Cons (f x) ys) Nil

appendL :: List a -> List a -> List a
appendL xs ys = foldL Cons ys xs

concatL :: List (List a) -> List a
concatL = foldL appendL Nil

-- Insertion sort is a classic use of foldL
isort :: Ord a => List a -> List a
isort = foldL insert Nil
  where
    insert :: Ord a => a -> List a -> List a
    insert y Nil = wrap y
    insert y (Cons x xs)
      | y < x     = Cons y (Cons x xs)
      | otherwise = Cons x (insert y xs)

-- 3.4 write insert from isort as a foldL
insert2 y xs = if fst fold then snd fold else Cons y xs
  where fold = foldL (\ x (r, ys)  -> if y > x && not r
                                      then (True, x `Cons` (y `Cons` ys))
                                      else (r, x `Cons` ys)) (False, Nil) xs
