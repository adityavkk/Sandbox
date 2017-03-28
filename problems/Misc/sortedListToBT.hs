data BT a = Leaf | Node (BT a) a (BT a)
  deriving (Show)

listToBT :: (Ord a) => [a] -> (BT a)
listToBT [] = Leaf
listToBT xs = Node (listToBT (take half xs)) m (listToBT (drop (half + 1) xs))
  where len  = length xs
        half = len `div` 2
        m    = xs !! half
