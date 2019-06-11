import qualified Data.Set as S


data SerializedTree a = SEmpty String | SNode (SerializedTree a) a (SerializedTree a)
  deriving Show 

serialization (SEmpty s) = s
serialization (SNode _ s _) = s

instance Foldable SerializedTree where
   foldr f z (SEmpty _) = z
   foldr f z (SNode l k r) = foldr f (f k (foldr f z r)) l

data Tree a = Empty | Node (Tree a) a (Tree a) 
  deriving (Show, Foldable)

toPreOrderSerialized :: Show a => Tree a -> SerializedTree String
toPreOrderSerialized  Empty = SEmpty "Null"
toPreOrderSerialized (Node l v r) = SNode sLeft sVal sRight 
  where sLeft = toPreOrderSerialized l
        sRight = toPreOrderSerialized r
        sVal = serialization sLeft ++ show v ++ serialization sRight

f :: Show a => Tree a -> [String]
f = S.toList . snd . foldr g (S.empty, S.empty) . toPreOrderSerialized 
    where g x (seen, dupes) =if S.member x seen then (seen, S.insert x dupes) else (S.insert x seen, dupes)

x = Node (Node (Node Empty 3 Empty) 5 (Node (Node Empty 3 Empty) 1 Empty)) 2 (Node (Node Empty 3 Empty) 1 (Node (Node Empty 3 Empty) 5 (Node (Node Empty 3 Empty) 1 Empty))) 
