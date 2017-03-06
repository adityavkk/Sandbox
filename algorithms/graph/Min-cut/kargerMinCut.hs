-- The corresponding file contains the adjacency list representation of a simple 200 node undirected graph.
-- The following algorithm runs the randomized contraction algorithm for the min cut problem and uses
-- it on the above graph to compute the min cut.

import AdjacencyList
import Control.Monad
import System.Random

parseLines :: String -> [[Int]]
parseLines = map (map read . words) . lines

parseAL :: AL Int -> [[Int]] -> AL Int
parseAL al []       = al
parseAL al (es:ess) = parseAL (foldr (\ e al' -> addEdge al' v e 0) al es') ess
  where v   = head es
        es' = tail es

unconnectedAL :: Int -> AL Int
unconnectedAL n = foldr (\ x al -> addVertex al (V x [])) empty [1..n]

parse200AL :: String -> AL Int
parse200AL = parseAL (unconnectedAL 200) . parseLines

graph :: IO (AL Int)
graph = parse200AL <$> readFile "./kargerMinCut.txt"

contraction :: AL Int -> IO Int
contraction (AL [])       = return 0
contraction (AL [v])      = return 0
contraction (AL [v0, v1]) = return (length $ es v0)
contraction (AL vs)       = do
                          vi <- randomRIO (0, len)
                          ei <- randomRIO (0, lenE)
                          gt
  where len  = length vs
        lenE = (length . es) v
        e    = (!! ei . es) v
        v    = vs !! vi
        lv   = from e
        rv   = to e

