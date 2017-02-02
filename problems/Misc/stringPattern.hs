{-# LANGUAGE ScopedTypeVariables #-}
-- You are given a pattern, such as
-- [a b b a], String: "catdogdogcar" returns True
-- [a b a b], String: "redblueredblue" returns True
-- [a b b a], String: "redblueredblue" returns False
-- [a, b, a], String: "patrpatrr" returns False

import qualified Data.HashMap.Lazy as M

fromJust (Just a) = a

snoc xs x = xs ++ [x]

heads = tail . scanl snoc []

tails :: [a] -> [[a]]
tails = tail . foldr (\ x ts -> (x : head ts) : ts) [[]]

f :: [Char] -> String -> Bool
f ps cs = m ps cs M.empty

m :: [Char] -> String -> M.HashMap Char String -> Bool
m [] [] _     = True
m [] (c:cs) _ = False
m (p:ps) [] _ = False
m [p] cs d
  | M.member p d && d M.! p == cs  = True
m (p:ps) cs@(c:_) d
  | isMember && head v /= c             = False
  | isMember && v == take (length v) cs = m ps (drop (length v) cs) d
  where
    v = d M.! p
    isMember = M.member p d
m (p:ps) cs@(c:cs') d               = any g hts
  where
    hts = heads cs `zip` tails cs
    g :: (String, String) -> Bool
    g (f, r) = m ps r nd
      where
        nd = M.insert p f d
