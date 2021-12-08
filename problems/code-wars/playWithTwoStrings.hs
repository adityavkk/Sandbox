-- https://www.codewars.com/kata/56c30ad8585d9ab99b000c54/
import qualified Data.Map as Map
import Data.Char(isLower, isUpper, toLower, toUpper)

toggleCase :: Char -> Char
toggleCase x | isUpper x = toLower x
             | isLower x = toUpper x
             | otherwise = x

freqMap :: String -> Map.Map Char Int
freqMap = foldl (\ m k -> Map.insertWith (+) k 1 m) Map.empty . map toLower

convertFreqToOp = Map.map (\ n -> if even n then id else toggleCase)

work :: String -> String -> String
work as bs = as' ++ bs'
    where 
        aOps  = convertFreqToOp $ freqMap as
        bOps  = convertFreqToOp $ freqMap bs
        as'   = [Map.findWithDefault id (toLower a) bOps $ a | a <- as]
        bs'   = [Map.findWithDefault id (toLower b) aOps $ b | b <- bs]









--------------------------------------------- Tests --------------------------------------------- 
shouldBe a b = print (a == b)
main = do 
    work "abc" "cde" `shouldBe` "abCCde"
    work "abcdeFgtrzw" "defgGgfhjkwqe" `shouldBe` "abcDeFGtrzWDEFGgGFhjkWqE"
    work "abcdeFg" "defgG" `shouldBe` "abcDEfgDEFGg"
    work "abab" "bababa" `shouldBe` "ABABbababa"
