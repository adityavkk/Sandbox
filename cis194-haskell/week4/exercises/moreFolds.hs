xor :: [Bool] -> Bool
xor = foldr (\x y -> (x || y) && not (x && y)) False

map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x y -> f x : y) []

myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f z xs = foldr g z xs'
  where
    g = flip f
    xs' = reverse xs

myFoldl' f z xs = foldr step id xs z
  where step x g a = g (f a x)
