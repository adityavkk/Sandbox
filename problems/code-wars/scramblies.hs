-- Complete the function scramble(str1, str2) that returns true if a portion of str1 characters can be rearranged to match str2, otherwise returns false.

-- Approach: 
-- 	fX = frequency map of y
--  fXMinusX = fold over x with z = fX, \ x z -> if x in z, decrement freq of x in z, else z
--  return isEmpty fXMinusX 

import Data.HashMap.Strict (HashMap)

scramble xs ys = HashMap.null fYMinusX
  where 
    fY       = HashMap.fromListWith (+) [(y, 1) | y <- ys]
    fYMinusX = foldl f fY xs
    f freq x = if HashMap.member y freq then HashMap.adjust (\ v -> v - 1) x freq else freq

-- Test Cases --
test x y res = 
  if scramble x y == res
     then print "Pass"
     else print "Fail"

test "rkqodlw"           "world"       True
test "cedewaraaossoqqyt" "codewars"    True
test "katas"             "steak"       False
test "scriptjavx"        "javascript"  False
test "scriptingjava"     "javascript"  True
test "scriptsjava"       "javascripts" True
test "javscripts"        "javascript"  False
test "aabbcamaomsccdd"   "commas"      True
test "commas"            "commas"      True
test "sammoc"            "commas"      True
