-- lcs "a"         "b"         = > ""
-- lcs "132535365" "123456789" = > "12356"
-- lcs "adb" "abc"             = > "ab"
import Data.List

lcs :: String -> String -> String
lcs [] _ = ""
lcs _ [] = ""
lcs a b
  | la == lb  = lcs (wl a) (wl b) ++ [la]
  | otherwise = maxL (lcs (wl a) b) (lcs a (wl b))
  where
    l  = last
    la = l a
    lb = l b
    wl xs = take (length xs - 1) xs
    maxL as bs = if length as > length bs then as else bs
