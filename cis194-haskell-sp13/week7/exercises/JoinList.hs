{-# LANGUAGE FlexibleInstances, TypeSynonymInstances #-}
module JoinList where
import Data.Monoid
import Buffer
import Sized
import Scrabble
import Editor

data JoinList m a = Empty
                  | Single m a
                  | Append m (JoinList m a) (JoinList m a)
  deriving (Eq, Show)

-- Exercise 1
(+++) :: (Monoid m) => JoinList m a -> JoinList m a -> JoinList m a
(+++) jl1 jl2   = Append (m1 `mappend` m2) jl1 jl2
  where m1 = tag jl1
        m2 = tag jl2

tag :: Monoid m => JoinList m a -> m
tag jl = case jl of
          Empty           -> mempty
          (Single m _)    -> m
          (Append m _ _ ) -> m

-- Exercise 2
tSize :: (Sized m, Monoid m) => JoinList m a -> Int
tSize = getSize . size . tag

indexJ :: (Sized b, Monoid b) => Int -> JoinList b a -> Maybe a
indexJ _ Empty                 = Nothing
indexJ i _ | i < 0             = Nothing
indexJ 1 (Single _ a)          = Just a
indexJ _ (Single _ _)          = Nothing
indexJ n jl@(Append m jll jlr)
  | n > ts                     = Nothing
  | n > ls                     = indexJ (n - ls) jlr
  | otherwise                  = indexJ n jll
  where ts  = tSize jl
        ls  = tSize jll

dropJ :: (Sized b, Monoid b) => Int -> JoinList b a -> JoinList b a
dropJ n jl | n < 1   = jl
dropJ n jl@(Single _ _)
  | n == 0           = jl
  | otherwise        = Empty
dropJ n jl@(Append m l r)
  | n == ts          = Empty
  | n == ls          = r
  | n > ls           = dropJ (n - ls) r
  | otherwise        = dropJ n l +++ r
  where ts = tSize jl
        ls = tSize l
{- dropJ _ _ = Empty -}

takeJ :: (Sized b, Monoid b) => Int -> JoinList b a -> JoinList b a
takeJ n _ | n < 1 = Empty
takeJ n jl@(Single _ _)
  | n >= 1    = jl
  | otherwise = Empty
takeJ n jl@(Append m l r)
  | n >= ts   = jl
  | n == ls   = l
  | n > ls    = l +++ takeJ (n - ls) r
  | otherwise = takeJ n l
  where ts = tSize jl
        ls = tSize l
takeJ _ _ = Empty

-- Exercise 3
scoreLine :: String -> JoinList Score String
scoreLine [] = Empty
scoreLine cs = Single (scoreString cs) cs

-- Exercise 4
scoreSizeString :: String -> JoinList (Score, Size) String
scoreSizeString [] = Empty
scoreSizeString cs = Single (scoreString cs, Size 1) cs

jlToList :: (Monoid m) => JoinList m a -> [a]
jlToList Empty = []
jlToList (Single _ a) = [a]
jlToList (Append _ l r) = jlToList l ++ jlToList r

listToJl :: [String] -> JoinList (Score, Size) String
listToJl = foldr (\ w jl -> scoreSizeString w +++ jl) Empty

instance Buffer (JoinList (Score, Size) String) where
  toString                                = unlines . jlToList
  fromString                              = listToJl . lines
  line                                    = indexJ
  replaceLine n l b                       = takeJ (n - 1) b +++ fromString l +++ dropJ n b
  numLines Empty                          = 0
  numLines (Single (Score _, Size s) _)   = s
  numLines (Append (Score _, Size s) _ _) = s
  value Empty                             = 0
  value (Single (Score s, Size _) _)      = s
  value (Append (Score s, Size _) _ _)    = s

main = runEditor editor (fromString $ unlines
        [ "This buffer is for notes you don't want to save, and for"
        , "evaluation of steam valve coefficients."
        , "To load a different file, type the character L followed"
        , "by the name of the file."
        ] :: JoinList (Score, Size) String)
