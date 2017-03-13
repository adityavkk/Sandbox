{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Risk where

import Control.Monad.Random
import System.Random
import Control.Monad
import Data.List
import Debug.Trace
import Data.List

-- evalRandIO :: Rand StdGen a -> IO a
-- MonadRandom
------------------------------------------------------------
-- Die values

newtype DieValue = DV { unDV :: Int }
  deriving (Eq, Ord, Show, Num)

first :: (a -> b) -> (a, c) -> (b, c)
first f (a, c) = (f a, c)

instance Random DieValue where
  random           = first DV . randomR (1,6)
  randomR (low,hi) = first DV . randomR (max 1 (unDV low), min 6 (unDV hi))

die :: Rand StdGen DieValue
die = getRandom

dies :: Rand StdGen [DieValue]
dies = getRandoms

threeInts :: Rand StdGen (Int, Int, Int)
threeInts = do
  is <- getRandoms
  let [i1, i2, i3] = take 3 is
  return (i1, i2, i3)

------------------------------------------------------------
-- Risk

type Army = Int

data Battlefield = Battlefield { attackers :: Army
                               , defenders :: Army }
                                deriving (Show, Ord, Eq)
-- For fun!
instance Random Battlefield where
  random        = f (uncurry Battlefield) .
    (\ (r1, g1) -> (r1, randomR (1, 10) g1)) . randomR (1, 10)
    where f g (r1, (r2, g2)) = (g (r1, r2), g2)
  randomR (l, h)        = f (uncurry Battlefield) .
    (\ (r1, g1) -> (r1, randomR (attackers l, defenders h) g1)) . randomR (attackers l, defenders h)
    where f g (r1, (r2, g2)) = (g (r1, r2), g2)

bf :: Rand StdGen Battlefield
bf = getRandom

-- Exercise 2

battle :: Battlefield -> Rand StdGen Battlefield
battle bfd@(Battlefield a d)
  | a == 1  = return bfd
  | otherwise = do
      ras <- dies
      rds <- dies
      let as = sort $ take (if a - 1 > 3 then 3 else a - 1) ras
          bs = sort $ take (if d == 1 then 1 else 2) rds
          f as bs (Battlefield a' b') = uncurry Battlefield $
            foldl (\ (a'', b'') (a, b) -> if a > b
                                          then if b'' > b' - 2
                                               then (a'', b'' - 1)
                                               else (a'', b'')
                                          else (a'' - 1, b'')) (a', b') (zip as bs)
      return (f as bs bfd)

-- Exercise 3
invade :: Battlefield -> Rand StdGen Battlefield
invade bfd@(Battlefield a d)
  | a < 2 || d == 0 = return bfd
  | otherwise       = battle bfd >>= invade

invade1 bfd@(Battlefield a d) = do
  b <- f
  return b
    where f = (sequence $ iterate (>>= battle) (battle bfd)) >>=
                return . head . filter (\ (Battlefield a d) -> d == 0 || a < 2)

-- Exercise 4
successProb bfd@(Battlefield a d) = replicateM 1000 (invade bfd) >>= 
  (\ is ->
          let ws = fromIntegral $ length $ filter (\ (Battlefield a' d') -> d' == 0) is in
          return (ws / 1000))

successProb1 bfd@(Battlefield a d) = do
  is <- replicateM 1000 (invade bfd)
  let ws = fromIntegral $ length $ filter (\ b -> defenders b == 0) is
  return (ws / 1000)

