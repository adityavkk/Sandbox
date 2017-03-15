-- You are given a binary tree in which each node contains a value. Design an
-- algorithm to print all paths which sum to a given value. The path does
-- not need to start or end at the root or a leaf.

data Tree a = Leaf | Node { left :: Tree a
                          , val :: a
                          , right :: Tree a
                          } deriving (Show, Eq)

f :: (Integral a) => Tree a -> a -> [[a]]
f Leaf y 			= []
f (Node l v r) x
  | v == x    = [x] : xs
  | otherwise = xs

	where xs = map (v:) (f l (x - v))
						 ++ map (v:) (f r (x - v))
						 ++ f l x ++ f r x

t0 = Node (Node Leaf 3 (Node Leaf (-3) Leaf))
					5
					(Node Leaf 4 (Node Leaf 1 Leaf))

