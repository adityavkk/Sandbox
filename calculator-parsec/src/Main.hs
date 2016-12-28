import Text.Parsec
import Text.Parsec.String (Parser)
import Prelude hiding (subtract)

numberString :: Parser String
numberString = many1 digit -- many1 applies digit until it fails

-- since numberString is a parser, and parsers are functors, we fmap readFloat
number :: Parser Float
number = withWhitespace plainNumber
  where plainNumber = fmap readFloat numberString
        readFloat   = read :: String -> Float
        -- digit is a parser that parses digits

plusChar :: Parser Char
plusChar = char '+'

plus :: Parser (Float -> Float -> Float)
plus = fmap transformPlus plusChar

transformPlus :: Char -> (Float -> Float -> Float)
transformPlus = const (+)

-- chain lets you chain parsers - value and an operator
-- chainl1 -> Parser value -> Parser operator
chainPlus :: Parser Float
chainPlus = chainl1 number plus
-- chainl is left associative chain there is a chainr that is right associative

-- between takes parser for the 1st thing, 2nd thing, and 3rd thing, but only
-- pays attention to the 3nd thing
withWhitespace :: Parser a -> Parser a
withWhitespace = between spaces spaces

-- sample withWhitespace which picks char a in between whitespaces
aWithWhitespace = withWhitespace (char 'a')

subtract :: Parser (Float -> Float -> Float)
subtract = fmap (const (-)) (char '-')

chainSubtract :: Parser Float
chainSubtract = chainl1 number subtract

multiply :: Parser (Float -> Float -> Float)
multiply = fmap (const (*)) (char '*')

divide :: Parser (Float -> Float -> Float)
divide = fmap (const (/)) (char '/')

chainMultiplyDivide :: Parser Float
chainMultiplyDivide = chainl1 number (divide <|> multiply)
-- <|> is a parsec or, which will pick plus if it finds a '+' or subtract for '-'

expression :: Parser Float
expression = chainl1 chainMultiplyDivide (plus <|> subtract)
-- Since we want the multiplication/division expression to be evaluated before
-- the plus and subtract are assigned we can chainMutiplyDivide which defaults
-- to number if it doesn't find a * or / anyway
