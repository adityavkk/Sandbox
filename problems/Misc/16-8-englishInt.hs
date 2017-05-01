-- Given any integer, print an English pharase that describes the integer
-- "One Thousand, Two Hundred Thirty Four"

-- f :: Int -> String
-- f' (show x

-- f' :: String -> String
-- x is 0: f' xs
-- else : toEng x ++ denom (length xs) ++ "," ++ f' xs
--
-- toEng :: Char -> String
-- denom :: Int -> String

import qualified Data.HashMap.Lazy as H
import Data.List.Split

table = H.fromList [("1", "One"), ("2", "Two"), ("3", "Three"), ("4", "Four"),
                    ("5", "Five"), ("6", "Six"), ("7", "Seven"), ("8", "Eight"),
                    ("9", "Nine"), ("10", "Ten"), ("20", "Twenty"), ("30", "Thirty"),
                    ("70", "Seventy"), ("60", "Sixty"), ("50", "Fifty"), ("40", "Forty"),
                    ("90", "Ninety"), ("80", "Eighty"), ("11", "Eleven"), ("12", "Twelve"),
                    ("16", "Sixteen"), ("13", "Thirteen"), ("14", "Fourteen"), ("15", "Fifteen"),
                    ("17", "Seventeen"), ("18", "Eighteen"), ("19", "Nineteen")]

denoms = H.fromList [(0, ""), (1, "Thousand"), (2, "Million"), (3, "Billion")]

f :: Int -> String
f = f' . breakUp . show
  where
    f' :: [String] -> String
    f' []       = ""
    f' (xs:xxs) = toEng xs ++ " " ++ denom (length xxs) ++ ", " ++ f' xxs

    denom :: Int -> String
    denom = (denoms H.!)

breakUp :: String -> [String]
breakUp = reverse . map reverse . chunksOf 3 . reverse

toEng :: String -> String
toEng ""     = ""
toEng (x:xs)
  | x == '0'                   = toEng xs
  | null xs                    = table H.! [x]
  | length xs == 1 && x == '1' = table H.! (x:xs)
  | length xs == 1             = (table H.! (x:"0")) ++ " " ++ toEng xs
  | otherwise                  = (table H.! [x]) ++ " Hundred " ++ toEng xs
