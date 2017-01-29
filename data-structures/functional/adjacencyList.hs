-- Adjacency List with Structural Sharing and Weighted Edges

data AL a = AL { vs :: [Vertex a] }
  deriving (Show)

data Vertex a = V { value :: a
                  , es :: [Edge a]
                  } deriving (Show)

data Edge a = E { from :: Vertex a
                , to :: Vertex a
                , getW :: Int
                } deriving (Show)

printAL (AL vs) = [(value v, [(value $ to e, getW e) | e <- es v]) | v <- vs]

belongs (AL vs) a = any ((== a) . value) vs

adjacent g@(AL vs) a b
  | belongs g a = any ((== b) . value . to) (es x)
  | otherwise   = False
  where x = head [x | x <- vs, value x == a]

neighbors :: Eq a => AL a -> a -> Maybe [Vertex a]
neighbors (AL vs) a
  | not $ null x  = Just [to e | e <- es (head x)]
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

v1 = (V 1 [])
v2 = (V 2 [])
g0 = foldl addVertex (AL []) [V x [] | x <- [1..6]]
g1 = addEdge (addEdge g0 2 3 30) 2 5 20
