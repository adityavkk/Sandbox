-- This is P Set 5 from the fall 14 section of the Intro. to Haskell Course
-- from UPenn
-- @ http://www.seas.upenn.edu/~cis194/fall14/lectures.html

import Ring
import Parser
import Data.Maybe    ( listToMaybe )


-- 1.
intParsingWorks :: Bool
intParsingWorks = (parse "3" == Just (3 :: Integer, "")) &&
                  (parseRing "1 + 2 * 5" == Just (11 :: Integer)) &&
                  (addId == (0 :: Integer))

-- 2.
data Mod5 = MkMod Integer
  deriving (Show, Eq, Read)

instance Num Mod5 where
  (+) (MkMod a) (MkMod b) = MkMod ((a + b) `mod` 5)
  (*) (MkMod a) (MkMod b) = MkMod ((a * b) `mod` 5)
  (-) (MkMod a) (MkMod b) = MkMod ((a - b) `mod` 5)
  negate (MkMod a)        = MkMod (a + (5 - a))
  fromInteger = MkMod
  abs (MkMod a) = MkMod $ a `mod` 5
  signum a = MkMod 1

instance Ring Mod5 where
  addId = MkMod 0
  addInv = negate
  mulId = MkMod 1

  add = (+)
  mul = (*)

instance Parsable Mod5 where
  parse = fmap (\ x -> (MkMod $ fst x, snd x)) . listToMaybe . reads

mod5ParseTest :: Maybe Mod5
mod5ParseTest = parseRing "10 + 4 * (4 + 3)"

mod5ParsingWorks :: Bool
mod5ParsingWorks = (parse "3" == Just (MkMod 3, "")) &&
                   (parseRing "1 + 2 * 5" == Just (MkMod 1)) &&
                   addId == MkMod 0

-- 3.
data Mat2x2 = Mat [Integer]
  deriving (Show, Eq)

instance Ring Mat2x2 where
  addId  = Mat [0, 0, 0, 0]
  addInv (Mat es) = Mat (map negate es)
  mulId  = Mat [1, 1, 1, 1]

  add (Mat as) (Mat bs) = Mat (lAdd as bs [])
    where lAdd [] ys@(y:ys') r = ys
          lAdd xs@(x:xs') [] r = xs
          lAdd (x:xs) (y:ys) r = lAdd xs ys (r ++ [x + y])
          lAdd _ _ r           = r
  mul (Mat [a0, a1, a2, a3]) (Mat [b0, b1, b2, b3]) = Mat [a0 * b0 + a1 * b2,
                                                           a0 * b2 + a1 * b3,
                                                           a2 * b0 + b3 * b2,
                                                           a2 * b2 + a3 * b3]

instance Parsable Mat2x2 where
  parse = fmap (\ x -> (Mat $ concat $ fst x, snd x)) . listToMaybe . readsM
    where readsM :: ReadS [[Integer]]
          readsM = reads

mat2x2Test :: Maybe Mat2x2
mat2x2Test = parseRing "[[1,2], [3,4]] + [[2, 3], [4, 5]] * [[1, 1], [1, 1]]"

mat2x2ParsingWorks :: Bool
mat2x2ParsingWorks = (parse "[[1,2], [3,4]]" == Just (Mat [1,2,3,4], "")) &&
                     (parse "[[5,6],[7,8]]" == Just ((Mat [ 5,6, 7, 8 ]), "")) &&
                     (parse "[[9,3],[6,0]]" == Just ((Mat [ 9,3, 6, 0 ]), "")) &&
                     (parseRing "[[1,2],[3,4]] + [[5,6],[7,8]]" == Just (Mat [6,8, 10,12])) &&
                     (parseRing "[[1,2],[3,4]] + [[5,6],[7,8]] * [[1,0],[0,1]] + [[0,0],[0,0]]" == Just (Mat [ 6,8, 10,12 ]))

