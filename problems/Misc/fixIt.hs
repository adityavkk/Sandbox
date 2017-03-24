module Fixit where
import Prelude hiding (reverse, foldr)

fix :: (a -> a) -> a
fix f = let x = f x in x

reverse' :: ([a] -> [a]) -> [a] -> [a]
reverse' _ []     = []
reverse' f (x:xs) = f xs ++ [x]

foldr' _ _ z []     = z
foldr' f g z (x:xs) = g x (f g z xs)

foldr = fix foldr'
reverse = fix reverse'
