-- Given an input string (s) and a pattern (p), implement regular expression
-- matching with support for '.' and '*'.
-- '.' Matches any single character.
-- '*' Matches zero or more of the preceding element.
--
-- Example 1:
-- Input:
-- s = "aa"
-- p = "a"
-- Output: false
-- Explanation: "a" does not match the entire string "aa".

-- Example 2:
-- Input:
-- s = "aa"
-- p = "a*"
-- Output: true
-- Explanation: '*' means zero or more of the precedeng element, 'a'. Therefore, by repeating 'a' once, it becomes "aa".


import Control.Applicative
import Data.Maybe
import Data.Char

newtype Parser a = Parser { runParser :: String -> Maybe (a, String) }

satisfy :: (Char -> Bool) -> Parser Char
satisfy p = Parser f
  where
    f []     = Nothing
    f (x:xs)
      | p x       = Just (x, xs)
      | otherwise = Nothing

char :: Char -> Parser Char
char c = satisfy (== c)

posInt :: Parser Integer
posInt = Parser f
  where
    f []     = Nothing
    f xs = if null ns then Nothing else Just (read ns, rest)
      where (ns, rest) = span isDigit xs


inParser f = Parser . f . runParser

first f (x, y) = (f x, y)
second f (x, y) = (x, f y)

-- fmap :: (a -> b) -> Parser a -> Parser b
instance Functor Parser where
  fmap g (Parser f) = Parser f'
    where f' = fmap (first g) . f

instance Applicative Parser where
  pure a                      = Parser (\ s -> Just (a, s))
  (<*>) (Parser f) (Parser g) = Parser h
    where
      h cs = case f cs of
                Nothing ->  Nothing
                (Just (f', cs')) -> fmap (first f') (g cs')

abParser :: Parser (Char, Char)
abParser = (,) <$> char 'a' <*> char 'b'

abParser_ :: Parser ()
abParser_ = (\ _ _ -> ()) <$> char 'a' <*> char 'b'

intPair :: Parser [Integer]
intPair = (\a _ b -> [a, b]) <$> posInt <*> char ' ' <*> posInt

instance Alternative Parser where
  empty = Parser $ const Nothing
  Parser f <|> Parser g = Parser $ liftA2 (<|>) f g

upper = satisfy isUpper

ignore = const ()
intOrUppercase :: Parser ()
intOrUppercase = ignore <$> posInt <|> ignore <$> upper

zeroOrMore p = oneOrMore p <|> pure []

oneOrMore :: Parser a -> Parser [a]
oneOrMore p = (:) <$> p <*> zeroOrMore p

-- Approach:
-- check :: String -> Pattern -> Bool
--   parse patten into a parser
--   runParser on the input string
--   check if the result of parsing is something
--
-- makeParser :: Pattern -> Parser Bool
--   sanitize pattern to remove trailing duplicates after *
--   Grammar:
--    - Patten = Char Expr
--             | (Char *) Expr
--             | Empty
--   (empty <|> (char <*> star) <|> char) <*> makeParser

type Pattern = String

-- check :: String -> Pattern -> Bool
check cs pattern = runMetaParser regExParser pattern cs

anyChar   = satisfy (/= '*')
star      = char '*'
charP     = fmap (:[]) . char <$> anyChar
starP     = char <$> star
emptyP    = Parser (\s -> if null s then Just (pure [], []) else Nothing)
charStarP = zeroOrMore . char <$> anyChar <* star

runMetaParser :: Parser (Parser a) -> String -> String -> Maybe (a, String)
runMetaParser (Parser f) s1 s2 =
  case f s1 of
    Nothing               -> Nothing
    Just (Parser g, rest) -> g s2

combineParsers p1 p2 = (++) <$> p1 <*> p2
charOrCharStar = (charStarP <|> charP <|> emptyP)
x = combineParsers <$> charOrCharStar <*> charOrCharStar

regExParser =
  emptyP <|> combineParsers <$> (charStarP <|> charP) <*> regExParser


makeParser :: Pattern -> Parser String
makeParser pattern =
  Parser (\ s ->
      case runParser regExParser $ pattern of
        Nothing        -> Nothing
        Just (p, rest) -> runParser p $ s)

