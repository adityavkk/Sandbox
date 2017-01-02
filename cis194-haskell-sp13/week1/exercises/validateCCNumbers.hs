-- Exercise 1
-- To Digits
toDigitsRev :: Integer -> [Integer]
toDigitsRev n
  | n < 1     = []
  | otherwise = lastDigit n : toDigitsRev (allButLastDigit n)

lastDigit :: Integer -> Integer
lastDigit n = mod n 10

allButLastDigit :: Integer -> Integer
allButLastDigit n = div n 10

toDigits :: Integer -> [Integer]
toDigits n = toDigitsIter n []

toDigitsIter :: Integer -> [Integer] -> [Integer]
toDigitsIter n ns
  | n < 1 = ns
  | otherwise = toDigitsIter (allButLastDigit n) (lastDigit n : ns)

-- toDigits n
  -- | n < 1     = []
  -- | otherwise = toDigits (allButLastDigit n) ++ [lastDigit n]

-- Exercise 2
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther xs
  | evenLen xs = doubleEvens xs
  | oddLen xs  = doubleOdds xs

evenLen xs = even (length xs)
oddLen = not . evenLen
double = (* 2)

doubleEvens []           = []
doubleEvens [x]          = [x]
doubleEvens [x, y]       = double x : [y]
doubleEvens [x, y, z]    = [x, double y, z]
doubleEvens (w:x:y:z:xs) = double w : x : double y : z : doubleEvens xs

doubleOdds []         = []
doubleOdds [x]        = [x]
doubleOdds [x, y]     = double x : [y]
doubleOdds (x:y:z:xs) = x : double y : z : doubleOdds xs

-- Exercise 3
sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:xs)
  | x > 9 = sum (toDigits x) + sumDigits xs
  | otherwise = x + sumDigits xs

-- Exercise 4
validate :: Integer -> Bool
validate = isZero . mod10 . sumDigits . doubleEveryOther . toDigits

mod10 n = n `mod` 10
isZero n = n == 0

