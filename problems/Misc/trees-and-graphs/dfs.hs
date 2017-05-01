import qualified Data.HashMap.Lazy as H
import qualified Data.HashSet as S

type AL = H.HashMap Int [Int]

g :: AL
g = H.fromList [(1, [2, 3]), (2, [4, 5]), (3, [6, 7]), (4, []), (5, []), (6, []), (7, [])]

g' :: AL
g' = H.fromList [(1, [3]), (3, [])]

dfs g = fst $ f (H.keys g) S.empty
  where
    f vs s = foldl (\ (xs, s') v -> if S.member v s'
                                    then (xs, s')
                                    else let (ys, s'') = f (g H.! v) (S.insert v s') in
                                             (xs ++ (v:ys), S.union s'' s'))
                         ([], s) vs
