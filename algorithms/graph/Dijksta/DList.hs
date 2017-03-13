-- A difference list represents lists as a function f, which when given a
-- list x, returns the list that f represents, prepended to x

module DList where

import Data.Monoid

newtype DList a = DList { getDList :: [a] -> [a] }

instance (Show a) => Show (DList a) where
  show dl = show $ fromDList dl

toDList :: [a] -> DList a
toDList xs = DList (xs++)

fromDList :: DList a -> [a]
fromDList (DList f) = f []

snoc :: DList a -> a -> DList a
snoc dl a = dl <> toDList [a]

instance Monoid (DList a) where
  mempty                    = DList (\ xs -> [] ++ xs)
  DList f `mappend` DList g = DList (f . g)
