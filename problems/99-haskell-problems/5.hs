-- Reverse a list.

myReverse :: [a] -> [a]
myReverse []     = []
myReverse (x:xs) = myReverse xs ++ [x]

myReverseIter :: [a] -> [a]
myReverseIter xs = myReverseIter' xs []
  where
    myReverseIter' [] r     = r
    myReverseIter' (x:xs) r = myReverseIter' xs (x:r)
