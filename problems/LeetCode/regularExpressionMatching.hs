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

instance Alternative Parser where
  empty = Parser $ const Nothing
  Parser f <|> Parser g = Parser $ liftA2 (<|>) f g

zeroOrMore p = oneOrMore p <|> pure []
zeroOrMoreWithState updater p = oneOrMoreWithState updater p <|> pure []

oneOrMore p = (:) <$> p <*> zeroOrMore p
oneOrMoreWithState updater p@(Parser f) = Parser (\ s ->
    case f s of
      Nothing -> Nothing
      Just x@(s', rest) ->
        runParser ((s':) <$> (zeroOrMoreWithState updater (updater x p))) $ rest)

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
check pattern cs =
  maybe False id checkMatch
  where
    result = runMetaParser regExParser pattern cs
    checkMatch =
      (\ (parseResult, rest) -> if null rest then True else False)
      <$> result

anyChar   = satisfy (const True)
star      = char '*'
charWithDot c
  | c == '.'  = anyChar
  | otherwise = char c

charP     = fmap (:[]) . charWithDot <$> satisfy (/= '*')
emptyP    = Parser (\s -> if null s then Just (pure [], []) else Nothing)
charStarP = zeroOrMoreWithState dotUpdater . charWithDot <$> satisfy (/= '*') <* star
  where dotUpdater (y, _) _ = char y

runMetaParser :: Parser (Parser a) -> String -> String -> Maybe (a, String)
runMetaParser (Parser f) s1 s2 =
  case f s1 of
    Nothing               -> Nothing
    Just (Parser g, rest) -> g s2

combineParsers p1 p2 = (++) <$> p1 <*> p2

regExParser =
  emptyP <|> (combineParsers <$> (charStarP <|> charP) <*> regExParser)
