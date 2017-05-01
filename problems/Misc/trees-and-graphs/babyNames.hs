{-# LANGUAGE FlexibleInstances #-}
-- Names: "John(15), Jon(12), Chris(13), Kris(4), Christopher(19)"
-- Synonyms: [("John", "Jon"), ("John", "Johnny"), ("Chris", "Kris"), ("Chris", "Christopher")]
-- Output: "John(27), Kris(36)"

-- f :: Names -> [(String, String)] -> Names
-- build an adjacency list out of the synonyms
-- dfs on adj list while creating new Names HM and updating with the counts of
-- the connect components
--
-- dfs :: [Vertex] -> Seen -> Names -> Names
-- if vs is empty: ns
-- if v is seen: dfs vs seen ns
-- otherwise: dfs vs (insert v seen) (update v (count v) ns)
--
-- count :: Vertex -> Int
-- c + sum (count <$> neighbors v)
--
-- makeAl :: [(String, String)] -> AL
-- fold over ss starting at empty HM
--    insertWith (n2:) n1 []
--    insertWith (n1:) n2 []

import qualified Data.HashMap.Lazy as H
import qualified Data.HashSet as S
import Data.Hashable
import Data.Monoid

type Names = H.HashMap String Int
type AL = H.HashMap String [String]
type Seen = S.HashSet String
type Vertex = String

instance Monoid Int where
  mempty = 0
  x `mappend` y = x + y

f :: Names -> [(Vertex, Vertex)] -> Names
f names syns = dfs (H.keys names)
  where
    dfs :: [Vertex] -> Names
    dfs vs = fst $ foldr (\ v (n, s) -> if S.member v s
                                        then (n, s)
                                        else let (c, s') = count S.empty v in
                                            (H.insert v c n, s' <> s))
                   (H.empty, S.empty) vs

    count :: Seen -> Vertex -> (Int, Seen)
    count s v
      | S.member v s   = mempty
      | null neighbors = (c, S.singleton v)
      | otherwise      = (c + nc, S.insert v s')
      where c = names H.! v
            (nc, s') = foldr (<>) (0, S.empty) (count (S.insert v s) <$> neighbors)
            neighbors = g H.! v

    g :: AL
    g = makeAl syns

makeAl :: [(String, String)] -> AL
makeAl = foldr
         (\ (v1, v2) n -> H.insertWith (++) v1 [v2] $ H.insertWith (++) v2 [v1] n)
         H.empty


ns :: Names
ns = H.fromList [("John", 15), ("Jon", 12), ("Chris", 13), ("Kris", 4), ("Christopher", 19), ("Johnny", 2)]
syns = [("John", "Jon"), ("John", "Johnny"), ("Chris", "Kris"), ("Chris", "Christopher")]
