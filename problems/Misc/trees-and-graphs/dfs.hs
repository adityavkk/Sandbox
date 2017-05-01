import qualified Data.HashMap.Lazy as H
import qualified Data.HashSet as S

type AL = H.HashMap Int [Int]

g :: AL
g = H.fromList [(1, [2, 3]), (2, [4, 3]), (3, [4, 1]), (4, [3])]

g' :: AL
g' = H.fromList [(1, [3]), (3, [])]

dfs g = f (H.keys g) S.empty
  where
    f vs s = foldr (\ v (xs, s') -> if S.member v s'
                                    then (xs, s')
                                    else let (ys, s'') = f (g H.! v) (S.insert v s) in
                                             (xs ++ (v:ys), S.union s'' s'))
                         ([], S.empty) vs
