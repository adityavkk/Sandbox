-- How many different ways are there of decoding a string encoded by its indices
-- Ex: f("12") = 2 i.e. ["ab", "l"]
-- Ex: f("1234") = 3 i.e. ["abcd", "lcd", "ayd"]

f []    = 0
f [x]
  | x == '0' = 0
  | otherwise = 1
f [x, y]
  | y == '0'           = 1
  | x < '3' && y < '7' = 2
  | otherwise          = 1
f (x:y:xs)
  | x < '3' && y < '7' = f (y:xs) + f xs
  | otherwise          = f (y:xs)
