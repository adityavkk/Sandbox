{-# LANGUAGE ScopedTypeVariables #-}
import qualified Data.Map as M

data Tree a = Leaf | N (Tree a) a (Tree a)
  deriving (Show)

type K = Int
type W = Int
type KW = (K, W)
type C = Int

aSls :: [KW] -> [[KW]]
aSls []         = []
aSls [x]        = [[x]]
aSls xs@(x:xs') = [take i xs | i <- [1..(length xs)]] ++ aSls xs'

fromJust (Just a) = a

h kws = fromJust $ M.lookup (show kws) memo
  where
    memo   = foldr g M.empty (aSls kws)
    lup [] = Leaf
    lup x  = fromJust $ M.lookup (show x) memo
    g kws' = M.insert (show kws') (f kws')

    f :: [KW] -> Tree KW
    f kws = fst $ foldl g (Leaf, max + 1) (map ((\ x -> (x, c x)) . r ) lr kws)
      where
        g :: (Tree KW, C) -> (Tree KW, C) -> (Tree KW, C)
        g minT@(mt, mtw) cT@(t, tw)    = if tw < mtw then cT else minT
        lr :: [KW] -> [(K, W, [KW], [KW])]
        lr kws = [(k, w, ls, rs) | (k, w) <- kws]
        max = length kws ^ 2 * (maximum . map snd) kws

    r :: (K, W, [KW], [KW]) -> Tree KW
    r (k, w, ls, rs) = N (lup ls) (k, w) (lup rs)

c :: Tree KW -> Int
c t = c' t 1
  where
    c' Leaf _ = 0
    c' (N l (k, w) r) n = n * w + c' l (n + 1) + c' r (n + 1)

ps :: [KW]
ps = [(j, j) | j <- [1..]]
