{-# LANGUAGE FlexibleContexts #-}

import qualified Data.HashMap.Lazy as H
import Control.Monad
import System.Random
import Control.Concurrent.Async

type AL     = H.HashMap Vertex [Vertex]
type Vertex = Int
type Edge   = (Vertex, Vertex)

contract :: AL -> Edge -> AL
contract al (vf, vt) = (H.delete vt . removeTFF . addFT . removeTT . addTF) al
  where
    addTF al    = add (al H.! vt) [vf] al
    removeTT al = remove [vt] (al H.! vt) al
    addFT al    = add [vf] (al H.! vt) al
    removeTFF   = remove [vt, vf] [vf]

    -- remove xs from ys
    remove :: [Vertex] -> [Vertex] -> AL -> AL
    remove xs ys al = foldr (H.adjust (filter (not . flip elem xs))) al ys

    -- add xs to ys
    add :: [Vertex] -> [Vertex] -> AL -> AL
    add xs ys al = foldr (H.adjust (xs ++ )) al ys

contraction :: AL -> IO Int
contraction al
  | len < 2   = return 0
  | len == 2  = return (length . snd . head $ H.toList al)
  | otherwise = liftM2 contract (return al) (randomE al) >>= contraction
  where
    len = length $ H.keys al

minCut :: Int -> AL -> IO Int
minCut n al = minimum <$> mapConcurrently contraction (replicate n al)

randomE :: AL -> IO Edge
randomE al = do
            (k, vs) <- oneOf $ H.toList al
            (\ v -> (k, v)) <$> oneOf vs

oneOf :: [a] -> IO a
oneOf xs = (xs !!) <$> randomRIO (0, length xs - 1)

parseAL :: String -> AL
parseAL = f .  map (map read . words) . lines
  where
    f :: [[Vertex]] -> AL
    f = foldr (\ (x:xs) al -> H.insert x xs al) H.empty

graph = parseAL <$> readFile "./kargerMinCut.txt"

main = graph >>= minCut 50
