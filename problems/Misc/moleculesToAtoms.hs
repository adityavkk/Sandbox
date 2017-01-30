-- For a given chemical formula represented by a string, count the number of atoms
-- of each element contained in the molecule and return a key value mapping of
-- elements to the number of them contained in the molecule

-- "H" -> Right [("H", 1)] -- Hydrogen
-- "O2" -> Right [("O", 2)] -- Oxygen
-- "H2O" -> Right [("H", 2), ("O", 1)] -- Water
-- "Mg(OH)2" -> Right [("Mg",1),("O",2),("H",2)] -- Magnesium hydroxide
-- "K4[ON(SO3)2]2" -> Right [("K",4),("O",14),("N",2),("S",4)] -- Fremy's salt
-- "pie" -> Left "Not a valid molecule"

import AParser
import Control.Applicative
import Data.Char

data Mol = A { name :: String, num :: Int }
         | B { mols :: [Mol], num :: Int }
  deriving (Show)

atomName :: Parser String
atomName = spaces *> ((:) <$> (satisfy isUpper) <*> (zeroOrOne $ satisfy isLower)) <* spaces

openBrac :: Parser Char
openBrac = spaces *> (char '(' <|> char '[') <* spaces

closeBrac :: Parser Char
closeBrac = spaces *> (char ')' <|> char ']') <* spaces

atom :: Parser Mol
atom = spaces *> (A <$> atomName <*> (posInt <|> pure 1))

block :: Parser Mol
block = B <$> insideBlock <*> posInt

insideBlock :: Parser [Mol]
insideBlock = openBrac *> (oneOrMore mol) <* closeBrac

mol :: Parser Mol
mol = atom <|> block

parseMols :: Parser [Mol]
parseMols = oneOrMore mol

combine :: [Mol] -> [(String, Int)]
combine = foldr (\ a as -> case a of
                  (A name n) -> (name, n):as
                  (B xs n)   -> f n (combine xs) ++ as) []
  where f n = map (\ (name, num) -> (name, num * n))

merge :: [(String, Int)] -> [(String, Int)]
merge = foldr (\ (s, n) xs -> case lookup s xs of
                                (Just on) -> (s, on + n) : [x | x <- xs, fst x /= s]
                                _         -> (s, n) : xs) []

convert (Just (parsed, _)) = Right $ merge $ combine parsed
convert _                  = Left "Not a valid molecule"

main = do
  formula <- getLine
  let parsed = runParser parseMols formula
  putStrLn $ show (convert parsed)
