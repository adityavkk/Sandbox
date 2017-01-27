-- For a given chemical formula represented by a string, count the number of atoms
-- of each element contained in the molecule and return a key value mapping of
-- elements to the number of them contained in the molecule

-- "H" -> Right [("H", 1)] -- Hydrogen
-- "O2" -> Right [("O", 2)] -- Oxygen
-- "H2O" -> Right [("H", 2), ("O", 1)] -- Water
-- "Mg(OH)2" -> Right [("Mg",1),("O",2),("H",2)] -- Magnesium hydroxide
-- "K4[ON(SO3)2]2" -> Right [("K",4),("O",14),("N",2),("S",4)] -- Fremy's salt
-- "pie" -> Left "Not a valid molecule"
import Control.Applicative
import Data.Char

instance Monoid a => Monoid (Either b a) where
  mempty = Right mempty
  (Left a) `mappend` _ = Left a
  _ `mappend` (Left a) = Left a
  (Right xs) `mappend` (Right ys) = Right (xs `mappend` ys)

---------------------------------- The Parser ---------------------------------

newtype Parser a = Parser { runParser :: String -> Maybe (a, String) }

satisfy :: (Char -> Bool) -> Parser Char
satisfy p = Parser f
  where
    f [] = Nothing
    f (x:xs)
        | p x       = Just (x, xs)
        | otherwise = Nothing

char :: Char -> Parser Char
char c = satisfy (== c)

posInt :: Parser Int
posInt = Parser f
  where
    f xs
      | null ns   = Nothing
      | otherwise = Just (read ns, rest)
      where (ns, rest) = span isDigit xs

inParser f = Parser . f . runParser

first :: (a -> b) -> (a,c) -> (b,c)
first f (x,y) = (f x, y)

instance Functor Parser where
  fmap = inParser . fmap . fmap . first

instance Applicative Parser where
  pure a = Parser (\s -> Just (a, s))
  (Parser fp) <*> xp = Parser $ \s ->
    case fp s of
      Nothing     -> Nothing
      Just (f,s') -> runParser (f <$> xp) s'

instance Alternative Parser where
  empty = Parser (const Nothing)
  Parser p1 <|> Parser p2 = Parser $ liftA2 (<|>) p1 p2

zeroOrMore :: Parser a -> Parser [a]
zeroOrMore p = oneOrMore p <|> pure []

zeroOrOne :: Parser a -> Parser [a]
zeroOrOne p = ((:[]) <$> p) <|> pure []

oneOrMore :: Parser a -> Parser [a]
oneOrMore p = (:) <$> p <*> zeroOrMore p

spaces :: Parser String
spaces = zeroOrMore (satisfy isSpace)

atomName :: Parser String
atomName =
  spaces *> ((:) <$> (satisfy isUpper) <*> (zeroOrMore $ satisfy isLower)) <* spaces

openBrac :: Parser Char
openBrac = spaces *> (char '(' <|> char '[') <* spaces

closeBrac :: Parser Char
closeBrac = spaces *> (char ')' <|> char ']') <* spaces

atom :: Parser Atom
atom = spaces *> (Atom <$> atomName <*> posInt)

atoms = oneOrMore atom

mol :: Parser [ Atom ]
mol = atoms <|> block

insideBlock :: Parser [[Atom]]
insideBlock = openBrac *> (oneOrMore mol) <* closeBrac

block = liftA2 times insideBlock posInt
  where
    times [] n = []
    times [as] n = foldr f [] as
      where
        f (Atom a m) rs = (Atom a (m * n)) : rs

comb [] [] = []
comb as [] = as
comb as bl = as ++ bl

data Atom = Atom String Int
  deriving (Show)

f :: String -> Either String [(String, Int)]
f "" = mempty
f (x0:x1:xs) = undefined
