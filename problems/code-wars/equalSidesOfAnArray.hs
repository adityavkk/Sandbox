prefixSums      = scanl (+) 0
postfixSums     = reverse . prefixSums . reverse
first (x, _, _) = x

findEvenIndex :: [Int] -> Int
findEvenIndex xs = first (foldl f (0, postSums, False) preSums)
  where postSums               = tail $ postfixSums xs
        preSums                = prefixSums xs
        f res@(_, _, True) _   = res
        f (i, ys'@(y:ys), _) x = if y == x then (i, ys, True) else (i+1, ys, False)
        f (i, [], _) x         = (-1, [], False)














------------------------------------------------------ Test Cases ------------------------------------------------------
check i o = findEvenIndex i == o

main = do
  print $ check [1,2,3,4,3,2,1] 3
  print $ check [1,100,50,-51,1,1] 1
  print $ check [1,2,3,4,5,6] (-1)
  print $ check [20,10,30,10,10,15,35] 3
  print $ check [20,10,-80,10,10,15,35] 0
  print $ check [10,-80,10,10,15,35,20] 6
  print $ check [0,0,0,0,0] 0
  print $ check [-1,-2,-3,-4,-3,-2,-1] 3
