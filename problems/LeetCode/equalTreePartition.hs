import Prelude hiding (sum)

data BinTree =
  Node
    { getVal   :: Int
    , getSum   :: Int
    , getLeft  :: BinTree
    , getRight :: BinTree
    }
  | Leaf deriving (Eq, Show)

data BasicBinTree = BasicNode Int BasicBinTree BasicBinTree | BasicLeaf deriving Show

toBinTree :: BasicBinTree -> BinTree
toBinTree BasicLeaf = Leaf
toBinTree (BasicNode val left right) =
  Node val (getSum leftBinTree + getSum rightBinTree + val) leftBinTree rightBinTree
  where
    leftBinTree  = toBinTree left
    rightBinTree = toBinTree right
    getSum Leaf = 0
    getSum (Node _ sum _ _) = sum

modifiedDFS :: BinTree -> Bool
modifiedDFS tree = f tree 0
  where
    f :: BinTree -> Int -> Bool
    f Leaf parentSum = parentSum == 0
    f (Node val sum left right) parentSum =
      sever getLeft tree parentSum
      || sever getRight tree parentSum
      || f left (parentSum - getSum left)
      || f right (parentSum - getSum right)
    sever direction tree parentSum
      | direction tree == Leaf = False
      | otherwise              =
        getSum (direction tree) == parentSum - getSum (direction tree)

tree1 =
  BasicNode 3 (BasicNode (-2) BasicLeaf BasicLeaf) (BasicNode 8 (BasicNode (-9) BasicLeaf BasicLeaf) (BasicNode 2 BasicLeaf BasicLeaf))

tree2 = BasicNode 7 tree1 BasicLeaf


