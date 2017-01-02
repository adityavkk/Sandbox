{-# LANGUAGE GeneralizedNewtypeDeriving, FlexibleInstances #-}
module Scrabble where
import Data.Monoid
import Data.Char

newtype Score = Score Int
  deriving (Show, Eq, Ord, Num)

getScore :: Score -> Int
getScore (Score i) = i

score :: Char -> Score
score c
  | uc `elem` "AEIOOUNRSLT" = Score 1
  | uc `elem` "GD"          = Score 2
  | uc `elem` "MBCP"        = Score 3
  | uc `elem` "YFVH"        = Score 4
  | uc `elem` "K"           = Score 5
  | uc `elem` "JX"          = Score 8
  | uc `elem` "QZ"          = Score 10
  | otherwise               = Score 0
  where uc = toUpper c

scoreString :: String -> Score
scoreString = foldr (\ s t -> t + score s) (Score 0)

instance Monoid Score where
  mempty  = Score 0
  mappend = (+)

