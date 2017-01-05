fibTable = map fib [0..100]

mf n = fibTable !! n

fib 0 = 0
fib 1 = 1
fib m = mf (m - 1) + mf (m - 2)
