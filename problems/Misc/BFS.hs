import Data.List (foldl')
data TreeNode a = TreeNode {
  left  :: Maybe (TreeNode a),
  right :: Maybe (TreeNode a),
  value :: a
} deriving Show


buildTree :: [a] -> Maybe (TreeNode a)
buildTree l = fst $ walk $ split 1 l
  where split _ [] = []
        split n l = h : split (2*n) t
          where (h, t) = splitAt n l
        walk [] = (Nothing, [])
        walk ls@([] : _) = (Nothing, ls)
        walk ((h : t) : ls) = (Just $ TreeNode l r h, t : ls'')
          where (l, ls') = walk ls
                (r, ls'') = walk ls'

tree = buildTree [1..1000000]

treeByLevels :: Maybe (TreeNode a) -> [a]
treeByLevels t = bfs [t]

bfs :: [Maybe (TreeNode a)] -> [a]
bfs []     = []
bfs ns     = foldr val [] ns ++ bfs (concatMap lAndR ns)
  where
    val Nothing vs                 = vs
    val (Just (TreeNode _ _ v)) vs = v : vs

    lAndR Nothing                       = []
    lAndR (Just (TreeNode l Nothing v)) = [l]
    lAndR (Just (TreeNode Nothing r v)) = [r]
    lAndR (Just (TreeNode l r v))       = [l, r]
