module Foldmap where

import Data.Foldable (foldMap, Foldable)
import Data.Monoid

myToList :: Foldable t => t a -> [a]
myToList = foldMap mempty

data Min a = Min a | Infinity
  deriving (Show, Eq)

instance (Ord a) => Monoid (Min a) where
  mempty = Infinity
  (Min a) `mappend` (Min b) | a < b     = Min a
                            | otherwise = Min b
  Infinity `mappend` b = b
  a `mappend` Infinity = a

myMinimum :: (Ord a, Foldable t) => t a -> Maybe a
myMinimum = wrapMaybe . foldMap Min
  where wrapMaybe Infinity = Nothing
        wrapMaybe (Min x) = Just x

myFoldr :: (Foldable t) => (a -> b -> b) -> b -> t a -> b
myFoldr f z xs = foldMap (\a -> Endo (f a)) xs `appEndo` z


