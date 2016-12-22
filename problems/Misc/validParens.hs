g = analyze . prefixSum . map f1 . filter isParen
  where
    f1 x = if x == '(' then 1 else -1
    prefixSum = scanl1 (+)
    analyze xs = all (>= 0) xs && last xs == 0
    isParen x = x == '(' || x == ')'
