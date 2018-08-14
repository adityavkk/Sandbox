-- Given N floors and K eggs, determine the minimum number of drops needed to find the first floor from which a drop will break an egg
--
-- Examples:
-- N = 100
-- K = 1
-- minimum drops = 100
-- Start at floor 1 and drop the egg on each floor until the egg breaks. Worst case it doesn't break at any floor and you've dropped the egg 100 times
--
-- N = 100
-- K = 2
-- minimum drops = 14

-- Approach:

import Data.IORef
import qualified Data.Map as Map
import System.IO.Unsafe (unsafePerformIO)
import Data.Maybe (fromJust)

f :: Int -> Int -> Int
f 0 _ = 0
f n 1 = n
f n k = minimum [1 + max (f (i - 1) (k - 1)) (f (n - i) k) | i <- [1..n]]

memo2d :: (Ord a, Ord b, Eq c) => (a -> b -> c) -> IO (a -> b -> c)
memo2d f = do
  memoRef <- newIORef (Map.empty :: Map.Map (a, b) c)
  memo    <- readIORef memoRef
  (\ a b ->
    do
      let val = Map.lookup (a, b) memo
      if val == Nothing
      then do
        let x = f a b
        writeIORef memoRef $ Map.insert (a, b) x memo
        return x
      else
        return (fromJust $ val))

memoedF = memo2d f
