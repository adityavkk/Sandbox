-- Dijkstra's Single Source Shortest Path Algorithm using a Min Heap

module Dijkstra where

import qualified LeftistHeap as Q
import qualified Data.HashMap.Lazy as H
import qualified Data.HashSet as S

data Distance      = Infinity | D { dist :: Int } deriving (Show)
data Shortest      = S { v       :: Vertex
                       , d       :: Distance
                       , p       :: Prev
                       } deriving (Show)
data AL            = AL { size :: Int
                        , al   :: H.HashMap Vertex [(Vertex, Weight)]
                        } deriving (Show)

type ShortestPaths = H.HashMap Vertex Shortest
type Vertex        = Int
type Weight        = Int
type Prev          = Maybe Vertex

instance Eq Distance where
  Infinity == Infinity = True
  (D a)    == (D b)    = a == b

instance Ord Distance where
  compare Infinity Infinity = EQ
  compare Infinity _        = GT
  compare _ Infinity        = LT
  compare (D a) (D b)       = compare a b

  Infinity <= Infinity      = True
  _ <= Infinity             = True
  Infinity <= _             = False
  (D a) <= (D b)            = a <= b

instance Eq Shortest where
  (S _ d _) == (S _ d' _) = d == d'

instance Ord Shortest where
  compare (S _ d _) (S _ d' _) = compare d d'

neighbors :: Vertex -> AL -> [(Vertex, Weight)]
neighbors v (AL _ al) = al H.! v

dijkstra :: Vertex -> AL -> ShortestPaths
dijkstra vert adj = relaxer adj q H.empty S.empty
  where
    q = Q.fromList
        . map (\ k -> if k == vert
                      then S k (D 0) Nothing
                      else S k Infinity Nothing)
        . H.keys $ (al adj)

    relaxer :: AL -> Q.LH Shortest -> ShortestPaths -> S.HashSet Vertex -> ShortestPaths
    relaxer al' q hm set
      | size al' == 0 = hm
      | otherwise     = if S.member (v u) set
                        then relaxer al' q' hm set
                        else relaxer (AL (size al' - 1) (H.delete (v u) (al al')))
                                     (relax q' (neighbors (v u) adj))
                                     (H.insert (v u) u hm)
                                     (S.insert (v u) set)
        where
          (Just u, q') = Q.deleteMin q

          relax :: Q.LH Shortest -> [(Vertex, Weight)] -> Q.LH Shortest
          relax = foldr (\ (v', w) q' -> Q.insert (S v' (D (dist (d u) + w)) (Just (v u))) q')

parseAL :: String -> AL
parseAL = foldr ((\ (k, es) (AL s al) -> (AL (s + 1) (H.insert k es al)))
                                         . parseLine . words)
                (AL 0 H.empty)
          . lines
  where
    parseLine :: [String] -> (Vertex, [(Vertex, Weight)])
    parseLine l =
      (read $ head l,
       map (tupMap read . (\ (a, b) -> (a, tail b)) . break (== ',')) $ tail l)

    tupMap :: (a -> b) -> (a, a) -> (b, b)
    tupMap f (a, b) = (f a , f b)

sssp n = dijkstra n . parseAL <$> readFile "./dijkstraData.txt"
