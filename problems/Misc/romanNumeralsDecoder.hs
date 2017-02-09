import qualified Data.HashMap.Lazy as M

sCases = M.fromList [("IV", "IIII"), ("IX", "VIIII"), ("XL", "XXXX"), ("XC", "LXXXX"), ("CD", "CCCC"), ("CM", "DCCCC") ]
conv = M.fromList [('I', 1), ('V', 5), ('X', 10), ('L', 50), ('C', 100), ('D', 500), ('M', 1000)]

f = foldl (\ sum x -> sum + c x) 0 . mAdd'

c = (M.!) conv

mAdd' [] = []
mAdd' [x] = [x]
mAdd' [x, y]
  | M.member [x, y] sCases = (M.!) sCases [x, y]
  | otherwise              = [x, y]
mAdd' (x:y:z:xs)
  | M.member [x, y] sCases = (M.!) sCases [x, y] ++ mAdd' (z:xs)
  | M.member [y, z] sCases = [x] ++ (M.!) sCases [y, z] ++ mAdd' xs
  | otherwise              = [x, y] ++ mAdd' xs
