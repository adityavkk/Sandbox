-- Flatten a nested list structure.
data NestedList a = Elem a
                  | List [NestedList a]
  deriving Show

list = List [Elem 1, Elem 2, List [Elem 2, List [Elem 3, Elem 4], Elem 5]]

flatten :: NestedList a -> [a]
flatten (Elem a)      = [a]
flatten (List [])     = []
flatten (List (x:xs)) = flatten x ++ flatten (List xs)

flatten' :: NestedList a -> [a]
flatten' (Elem a) = [a]
flatten' (List xs) = concat [flatten' x | x <- xs]

flatten'' :: NestedList a -> [a]
flatten'' (Elem a) = [a]
flatten'' (List xs) = concat $ map flatten'' xs
