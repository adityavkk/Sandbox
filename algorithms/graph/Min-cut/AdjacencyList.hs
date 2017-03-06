module AdjacencyList where
-- Adjacency List with Structural Sharing and Weighted Edges

data AL a = AL { vs :: [Vertex a] }

data Vertex a = V { value :: a
                  , es :: [Edge a]
                  } deriving (Show)

data Edge a = E { from :: Vertex a
                , to :: Vertex a
                , getW :: Int
                } deriving (Show)

instance Show a => Show (AL a) where
  show (AL vs) = show [(value v, [(value $ to e, getW e) | e <- es v]) | v <- vs]

belongs :: Eq a => AL a -> a -> Bool
belongs (AL vs) a = any ((== a) . value) vs

adjacent :: Eq a => AL a -> a -> a -> Bool
adjacent g@(AL vs) a b
  | belongs g a = any ((== b) . value . to) (es x)
  | otherwise   = False
  where x = head [x | x <- vs, value x == a]

findVertex :: Eq a => AL a -> a -> Maybe (Vertex a)
findVertex g@(AL vs) a
  | belongs g a = Just $ head [v | v <- vs, value v == a]
  | otherwise   = Nothing

neighbors :: (Eq a, Show a) => AL a -> a -> Maybe [a]
neighbors (AL vs) a
  | not $ null x  = Just [value $ to e | e <- es (head x)]
  | otherwise     = Nothing
  where x = [y | y <- vs, value y == a]

addVertex :: Eq a => AL a -> Vertex a -> AL a
addVertex (AL vs) x = AL (x:vs)

addEdge :: Eq a => AL a -> a -> a -> Int -> AL a
addEdge (AL vs) a b w = AL (nX:nY:nVs)
  where
    nX = V a (nXE:[e | e <- es x, value (to e) /= b])
    nY = V b $
       foldr (\ e yes -> if value (to e) == a then (E nY nX (getW e)):yes else e:yes) [] $ es y
    nXE = E nX nY w
    nVs = [v | v <- vs, value v /= a, value v /= b]
    x = head [x' | x' <- vs, value x' == a]
    y = head [y' | y' <- vs, value y' == b]

removeVertex :: Eq a => AL a -> a -> AL a
removeVertex (AL vs) a = AL nVs
  where
    nVs = [re v a | v <- vs, value v /= a]
    re v a
      | any ((== a) . value . to) (es v) = V (value v) [e | e <- (es v), value (to e) /= a]
      | otherwise                        = v

delEdge :: Eq a => AL a -> a -> a -> AL a
delEdge g@(AL vs) a b = addVertex (removeVertex g a) nVa
  where
    (Just va) = findVertex g a
    nVa = V a [e | e <- es va, value (to e) /= b]

getEdgeWeight :: Eq a => AL a -> a -> a -> Int
getEdgeWeight g@(AL vs) a b
  | adjacent g a b = getW . head . filter (\ e -> value (to e) == b) $ es va
  | otherwise      = 0
  where (Just va) = findVertex g a

empty = AL []

g0 = foldl addVertex (AL []) [V x [] | x <- [1..6]]
g1 = addEdge (addEdge g0 2 3 30) 2 5 20
