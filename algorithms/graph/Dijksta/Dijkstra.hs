-- The file contains an adjacency list representation of an undirected weighted 
-- graph with 200 vertices labeled 1 to 200. Each row consists of the node 
-- tuples that are adjacent to that particular vertex along with the length of 
-- that edge. For example, the 6th row has 6 as the first entry indicating that 
-- this row corresponds to the vertex labeled 6. The next entry of this row 
-- "141,8200" indicates that there is an edge between vertex 6 and vertex 141 
-- that has length 8200. The rest of the pairs of this row indicate the other 
-- vertices adjacent to vertex 6 and the lengths of the corresponding edges.
-- 
-- Your task is to run Dijkstra's shortest-path algorithm on this graph, using 1 
-- (the first vertex) as the source vertex, and to compute the shortest-path 
-- 1distances between 1 and every other vertex of the graph. If there is no path 
-- between a vertex v and vertex 1, we'll define the shortest-path distance between 
-- 1 and v to be 1000000.
-- 
-- You should report the shortest-path distances to the following ten vertices, 
-- in order: 7,37,59,82,99,115,133,165,188,197. You should encode the distances as
-- a comma-separated string of integers. So if you find that all ten of these 
-- vertices except 115 are at distance 1000 away from vertex 1 and 115 is 2000 
-- distance away, then your answer should be 1000,1000,1000,1000,1000,2000,1000,
-- 1000,1000,1000. Remember the order of reporting DOES MATTER, and the string 
-- should be in the same order in which the above ten vertices are given. The 
-- string should not contain any spaces. Please type your answer in the space 
-- provided.

module Dijkstra where

import LeftistHeap
import qualified Data.HashMap.Lazy as H

type AL            = H.HashMap Vertex [(Vertex, Weight)]
type Vertex        = Int
type Weight        = Int
type ShortestPaths = (Vertex, H.HashMap Vertex Weight)

dijkstra :: Vertex -> AL -> ShortestPaths
dijkstra v al = (,) . v ()

parseAL :: String -> AL
parseAL = foldr ((\ (k, es) al -> H.insert k es al) . parseLine . words) 
                H.empty
          . lines
  where
    parseLine :: [String] -> (Vertex, [(Vertex, Weight)])
    parseLine l =
      (read $ head l,
       map (tupMap read . (\ (a, b) -> (a, tail b)) . break (== ',')) $ tail l)

    tupMap :: (a -> b) -> (a, a) -> (b, b)
    tupMap f (a, b) = (f a , f b)

graph = dijkstra 1 . parseAL <$> readFile "./dijkstraData.txt"
