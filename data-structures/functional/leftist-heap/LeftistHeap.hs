{-# LANGUAGE DatatypeContexts #-}

module LeftistHeap where
import Prelude hiding (pure)
import Data.List hiding (insert)

class Heap h where
  empty     :: (Ord a) => h a
  isEmpty   :: (Ord a) => h a -> Bool

  pure      :: (Ord a) => a -> h a
  insert    :: (Ord a) => a -> h a -> h a
  merge     :: (Ord a) => h a -> h a -> h a

  findMin   :: (Ord a) => h a -> Maybe a
  deleteMin :: (Ord a) => h a -> (Maybe a, h a)

  fromList  :: (Ord a) => [a] -> h a

data (Ord a) => LH a  = E
                      | N { rnk :: Int
                           , v :: a
                           , l :: LH a
                           , r :: LH a }
            deriving (Show, Eq)


instance Heap LH where
  empty     = E
  isEmpty E = True
  isEmpty _ = False

  pure x    = N 1 x E E
  insert x  = merge (pure x)
  merge a E = a
  merge E b = b
  merge a b
    | v a < v b = heapify (v a) (l a) (merge (r a) b)
    | otherwise = heapify (v b) (l b) (merge a (r b))
    where
      heapify :: (Ord a) => a -> LH a -> LH a -> LH a
      heapify x a b
        | rank a < rank b = N (rank a + 1) x b a
        | otherwise       = N (rank b + 1) x a b

  findMin E           = Nothing
  findMin (N _ x _ _) = Just x

  deleteMin E           = (Nothing, E)
  deleteMin (N _ x a b) = (Just x, merge a b)

  fromList = foldr insert E

rank :: Ord a => LH a -> Int
rank E           = 0
rank (N r _ _ _) = r

-- Linear time fromList
{- fromList = head . pairMerge . map pure -}
  {- where -}
    {- pairMerge :: (Ord a) => [LH a] -> [LH a] -}
    {- pairMerge []  = [ E ] -}
    {- pairMerge [x] = [x] -}
    {- pairMerge xs  = pairMerge . map (uncurry merge) . pair $ xs -}


{- pair :: [a] -> [(a, a)] -}
{- pair (x:xs) = map swap . reverse $ fst $ foldl' (\ (ps, p) h' -> if null p -}
                                           {- then (ps, [h']) -}
                                           {- else ((h', head p):ps, []) ) -}
                                 {- ([], [x]) xs -}
  {- where swap (a, b) =  (b, a) -}
