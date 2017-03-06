fibTable = map fib [0..]

mf n = fibTable !! n

fib 0 = 0
fib 1 = 1
fib m = mf (m - 1) + mf (m - 2)


fib' = f'
  where
    memo = map f' [0..]
    f n = memo !! n
    f' n | n < 2 = 2
         | otherwise = f (n - 1) + f (n - 2)
